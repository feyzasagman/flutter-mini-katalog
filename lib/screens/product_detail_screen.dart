import 'dart:math' show min;

import 'package:flutter/material.dart';

import '../models/product.dart';
import '../state/cart_state.dart';
import '../theme/app_colors.dart' show AppPalette;
import '../theme/design_tokens.dart';
import '../widgets/product_detail_bottom_bar.dart';
import '../widgets/product_image.dart';
import '../widgets/spec_info_card.dart';

/// Ürün detayı — görsel, özet bilgi, açıklama, teknik özellikler ve sabit alt aksiyon.
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.cartState,
  });

  final Product product;
  final CartState cartState;

  void _addToCart(BuildContext context) {
    final int previousQty = cartState.quantityFor(product.id);
    cartState.addProduct(product);
    final int newQty = cartState.quantityFor(product.id);

    final String message = previousQty == 0
        ? '${product.title} sepete eklendi.'
        : 'Sepetteki adet güncellendi · Toplam $newQty adet';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppPalette.primary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        content: Row(
          children: <Widget>[
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// İlk cümleyi veya kalan gövdeyi ayırır (açıklama bölümünde gövde kullanılır).
  static (String leadLine, String detailBody) _splitDescription(String raw) {
    final String t = raw.trim();
    if (t.isEmpty) {
      return ('', '');
    }
    final int dot = t.indexOf('. ');
    if (dot > 0 && dot < 220) {
      final String lead = t.substring(0, dot + 1);
      final String rest = t.substring(dot + 2).trim();
      if (rest.isEmpty) {
        return ('', t);
      }
      return (lead, rest);
    }
    return ('', t);
  }

  /// Üst bilgi alanında kısa öne çıkan metin (cümle yoksa kısaltılmış özet).
  static String _shortHighlight(String full, String leadFromSplit) {
    final String t = full.trim();
    if (t.isEmpty) {
      return '';
    }
    if (leadFromSplit.isNotEmpty) {
      return leadFromSplit;
    }
    const int maxChars = 132;
    final int dot = t.indexOf('. ');
    if (dot > 0 && dot <= maxChars + 24) {
      return t.substring(0, dot + 1);
    }
    if (t.length <= maxChars) {
      return t;
    }
    return '${t.substring(0, maxChars).trim()}…';
  }

  /// Mobilde ekranın ~yarısından az; geniş ekranda ortalanmış maksimum genişlik.
  static double _heroImageHeight(
    double paddedWidth,
    double screenHeight,
    double viewportWidth,
  ) {
    // Üst sınır: görünüm yüksekliğinin en fazla ~%42’si (yarıdan güvenli mesafe)
    final double capByScreen = screenHeight * 0.42;
    final double w = viewportWidth > 720 ? min(paddedWidth, 520) : paddedWidth;
    final double byAspect = w / 1.52;
    const double minH = 172;
    return byAspect.clamp(minH, capByScreen);
  }

  static double _scrollBottomPadding(BuildContext context, double viewportW) {
    final double safe = MediaQuery.paddingOf(context).bottom;
    // Alt bar: dar düzende kolon (fiyat + buton), geniş düzende tek satır — güvenli pay
    final double barEstimate = viewportW < 420 ? 158 : 104;
    return safe + barEstimate + AppSpacing.lg;
  }

  /// Özet kartında tüm metin gösteriliyorsa açıklama bölümünü tekrar etme.
  static bool _isDescriptionRedundant(String full, String highlight) {
    final String a = full.trim();
    final String b = highlight.trim();
    return a.isNotEmpty && b.isNotEmpty && a == b;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String rawDescription = product.description.trim();
    final (String leadLine, _) = _splitDescription(rawDescription);
    final String highlight = _shortHighlight(rawDescription, leadLine);
    final bool showDescriptionBlock =
        rawDescription.isNotEmpty &&
        !_isDescriptionRedundant(rawDescription, highlight);
    final bool hasSpecs = product.specifications.isNotEmpty;
    final double viewportW = MediaQuery.sizeOf(context).width;
    final double screenH = MediaQuery.sizeOf(context).height;
    final double bottomPad = _scrollBottomPadding(context, viewportW);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Ürün Detayı'),
        centerTitle: false,
        titleSpacing: AppSpacing.sm,
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: cartState,
        builder: (BuildContext context, Widget? child) {
          final int inCart = cartState.quantityFor(product.id);
          return ProductDetailBottomBar(
            formattedPrice: product.formattedPrice,
            quantityInCart: inCart,
            onAddToCart: () => _addToCart(context),
          );
        },
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints box) {
          final double horizontal = AppSpacing.lg;
          final double paddedW = box.maxWidth - horizontal * 2;
          final double imageH = _heroImageHeight(paddedW, screenH, viewportW);
          final double imageDisplayW =
              viewportW > 720 ? min(paddedW, 520) : paddedW;

          final List<Widget> scrollChildren = <Widget>[
            _DetailHeroImage(
                product: product,
                imageHeight: imageH,
              imageWidth: imageDisplayW,
              horizontalPadding: horizontal,
            ),
            _DetailProductSummary(
                theme: theme,
                category: product.category,
              title: product.title,
              formattedPrice: product.formattedPrice,
              highlight: highlight,
            ),
            SizedBox(height: AppSpacing.sm + 2),
          ];

          if (showDescriptionBlock) {
            scrollChildren.add(const _SectionDivider());
            scrollChildren.add(
              _DetailDescriptionSection(
                theme: theme,
                body: rawDescription,
              ),
            );
          }

          if (hasSpecs) {
            scrollChildren.add(const _SectionDivider());
            scrollChildren.add(
              _DetailSpecsSection(
                theme: theme,
                specs: product.specifications,
              ),
            );
          }
          scrollChildren.add(const SizedBox(height: AppSpacing.md));

          return ListView(
            padding: EdgeInsets.only(bottom: bottomPad),
            physics: const BouncingScrollPhysics(),
            children: scrollChildren,
          );
        },
      ),
    );
  }
}

// --- Bölümler ----------------------------------------------------------------

class _DetailHeroImage extends StatelessWidget {
  const _DetailHeroImage({
    required this.product,
    required this.imageHeight,
    required this.imageWidth,
    required this.horizontalPadding,
  });

  final Product product;
  final double imageHeight;
  final double imageWidth;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        AppSpacing.md,
        horizontalPadding,
        AppSpacing.lg,
      ),
      child: Center(
        child: Hero(
          tag: 'product-image-${product.id}',
            child: Material(
            color: Colors.transparent,
            elevation: 3,
            shadowColor: AppPalette.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadii.lg),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.lg),
              child: ColoredBox(
                color: AppPalette.surface,
                child: SizedBox(
                  height: imageHeight,
                  width: imageWidth,
                  child: ProductImage(
                    product: product,
                    fit: BoxFit.cover,
                    width: imageWidth,
                    height: imageHeight,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailProductSummary extends StatelessWidget {
  const _DetailProductSummary({
    required this.theme,
    required this.category,
    required this.title,
    required this.formattedPrice,
    required this.highlight,
  });

  final ThemeData theme;
  final String category;
  final String title;
  final String formattedPrice;
  final String highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppPalette.surface,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(color: AppPalette.border),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppPalette.primary.withValues(alpha: 0.07),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg + 2,
            AppSpacing.lg + 2,
            AppSpacing.lg + 2,
            AppSpacing.lg + 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                category.toUpperCase(),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppPalette.accent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: AppSpacing.sm + 2),
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.22,
                  letterSpacing: -0.35,
                  color: AppPalette.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                formattedPrice,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppPalette.priceHighlight,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                ),
              ),
              if (highlight.isNotEmpty) ...<Widget>[
                const SizedBox(height: AppSpacing.lg + 2),
                Text(
                    highlight,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppPalette.textSecondary,
                    height: 1.55,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailDescriptionSection extends StatelessWidget {
  const _DetailDescriptionSection({
    required this.theme,
    required this.body,
  });

  final ThemeData theme;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl + 4,
        AppSpacing.xl,
        AppSpacing.xl + 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Ürün açıklaması',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
              color: AppPalette.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg + 2),
          Text(
            body,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppPalette.textSecondary,
              height: 1.72,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailSpecsSection extends StatelessWidget {
  const _DetailSpecsSection({
    required this.theme,
    required this.specs,
  });

  final ThemeData theme;
  final Map<String, String> specs;

  @override
  Widget build(BuildContext context) {
    if (specs.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<MapEntry<String, String>> entries =
        specs.entries.toList(growable: false);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Teknik özellikler',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
              color: AppPalette.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg + 2),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints c) {
              final double w = c.maxWidth;
              final bool twoCol = w > 520;
              final double gap = AppSpacing.md;
              final double cardW = twoCol ? (w - gap) / 2 : w;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: entries
                    .map(
                      (MapEntry<String, String> e) => SizedBox(
                        width: cardW,
                        child: SpecInfoCard(
                          label: e.key,
                          value: e.value,
                        ),
                      ),
                    )
                    .toList(growable: false),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppPalette.border.withValues(alpha: 0.85),
      ),
    );
  }
}
