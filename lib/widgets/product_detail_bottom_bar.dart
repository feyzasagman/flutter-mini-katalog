import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

/// Ürün detayı — sabit alt fiyat özeti ve [Sepete Ekle].
class ProductDetailBottomBar extends StatelessWidget {
  const ProductDetailBottomBar({
    super.key,
    required this.formattedPrice,
    required this.quantityInCart,
    required this.onAddToCart,
  });

  final String formattedPrice;
  final int quantityInCart;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;

    return Material(
      elevation: 18,
      shadowColor: AppPalette.primary.withValues(alpha: 0.14),
      surfaceTintColor: Colors.transparent,
      color: scheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(
            height: 1,
            thickness: 1,
            color: AppPalette.border.withValues(alpha: 0.95),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints c) {
                final bool narrow = c.maxWidth < 420;

                final Widget priceColumn = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Birim fiyat',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      formattedPrice,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppPalette.priceHighlight,
                        letterSpacing: 0.2,
                      ),
                    ),
                    if (quantityInCart > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.xs),
                        child: Text(
                          'Sepette $quantityInCart adet',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                );

                final Widget button = FilledButton.icon(
                  onPressed: onAddToCart,
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  label: const Text('Sepete Ekle'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppPalette.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.md + 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ).copyWith(
                    overlayColor: WidgetStateProperty.resolveWith<Color?>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.white.withValues(alpha: 0.12);
                      }
                      return null;
                    }),
                  ),
                );

                if (narrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      priceColumn,
                      const SizedBox(height: AppSpacing.md),
                      button,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: priceColumn),
                    const SizedBox(width: AppSpacing.lg),
                    Flexible(
                      flex: 2,
                      child: button,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
