import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';
import 'product_image.dart';

typedef OnProductTap = void Function(Product product);

/// Ana sayfa ürün kartı — beyaz yüzey, hafif gölge, hover’da yükselme.
class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final Product product;
  final OnProductTap onTap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;

    final double elevation = _hover ? 4.0 : 1.2;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedPhysicalModel(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        elevation: elevation,
        shadowColor: AppPalette.primary.withValues(alpha: _hover ? 0.10 : 0.055),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        shape: BoxShape.rectangle,
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: AppPalette.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
            side: const BorderSide(color: AppPalette.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.lg),
            onTap: () => widget.onTap(widget.product),
            splashColor: AppPalette.accent.withValues(alpha: 0.10),
            highlightColor: AppPalette.accent.withValues(alpha: 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppRadii.lg),
                    ),
                    child: Hero(
                      tag: 'product-image-${widget.product.id}',
                      child: ProductImage(
                        product: widget.product,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md + 2,
                      AppSpacing.md,
                      AppSpacing.md + 2,
                      AppSpacing.sm + 2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm + 2,
                            vertical: AppSpacing.xs + 1,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.product.category.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: scheme.onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.65,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs + 2),
                        Text(
                          widget.product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.18,
                            letterSpacing: -0.12,
                            fontSize: 13.5,
                            color: AppPalette.textPrimary,
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm - 1,
                          ),
                          decoration: BoxDecoration(
                            color: AppPalette.priceBlockBg,
                            borderRadius: BorderRadius.circular(AppRadii.sm),
                            border: Border.all(color: AppPalette.priceBlockBorder),
                          ),
                          child: Text(
                            widget.product.formattedPrice,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: AppPalette.priceHighlight,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.12,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            widget.product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppPalette.textSecondary,
                              height: 1.28,
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'İncele',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: scheme.secondary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 15,
                              color: scheme.secondary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
