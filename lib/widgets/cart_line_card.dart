import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/product.dart';
import '../state/cart_state.dart';
import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';
import 'product_image.dart';

/// Sepet satırı — beyaz kart, border, fiyat vurgusu palette uyumlu.
class CartLineCard extends StatelessWidget {
  const CartLineCard({
    super.key,
    required this.line,
    required this.cartState,
    required this.thumbSize,
  });

  final CartItem line;
  final CartState cartState;
  final double thumbSize;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final Product p = line.product;

    return Material(
      color: AppPalette.surface,
      elevation: 2,
      shadowColor: AppPalette.primary.withValues(alpha: 0.07),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
        side: const BorderSide(color: AppPalette.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.sm),
              child: SizedBox(
                width: thumbSize,
                height: thumbSize,
                child: ProductImage(
                  product: p,
                  fit: BoxFit.cover,
                  width: thumbSize,
                  height: thumbSize,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    p.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppPalette.textPrimary,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Birim fiyat: ${p.formattedPrice}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: <Widget>[
                      CartQtyControl(
                        quantity: line.quantity,
                        onDecrement: () =>
                            cartState.decrementQuantity(p.id),
                        onIncrement: () =>
                            cartState.incrementQuantity(p.id),
                      ),
                      const Spacer(),
                      Text(
                        formatMoney(line.lineTotal),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppPalette.priceHighlight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Kaldır',
              style: IconButton.styleFrom(
                foregroundColor: AppPalette.textSecondary,
              ),
              onPressed: () => cartState.removeLine(p.id),
              icon: const Icon(Icons.delete_outline_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class CartQtyControl extends StatelessWidget {
  const CartQtyControl({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(color: AppPalette.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            tooltip: 'Azalt',
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            padding: EdgeInsets.zero,
            onPressed: onDecrement,
            style: IconButton.styleFrom(
              foregroundColor: AppPalette.primary,
            ),
            icon: const Icon(Icons.remove_rounded, size: 20),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 36),
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppPalette.textPrimary,
                  ),
            ),
          ),
          IconButton(
            tooltip: 'Artır',
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            padding: EdgeInsets.zero,
            onPressed: onIncrement,
            style: IconButton.styleFrom(
              foregroundColor: AppPalette.primary,
            ),
            icon: const Icon(Icons.add_rounded, size: 20),
          ),
        ],
      ),
    );
  }
}
