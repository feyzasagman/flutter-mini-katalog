import 'package:flutter/material.dart';

import '../models/product.dart';
import '../state/cart_state.dart';
import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

/// Sepet özeti — vurgulu toplam kartı ve tutarlı butonlar.
class CartSummaryFooter extends StatelessWidget {
  const CartSummaryFooter({
    super.key,
    required this.cartState,
    required this.onContinueShopping,
    required this.onCompleteSimulation,
  });

  final CartState cartState;
  final VoidCallback onContinueShopping;
  final VoidCallback onCompleteSimulation;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final double subtotal = cartState.totalPrice;
    final int unitCount = cartState.totalUnits;
    final int lineCount = cartState.distinctCount;

    return Material(
      elevation: 20,
      shadowColor: AppPalette.primary.withValues(alpha: 0.16),
      color: scheme.surface,
      surfaceTintColor: Colors.transparent,
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
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints c) {
            final bool narrow = c.maxWidth < 440;

            final Widget summaryRows = DecoratedBox(
              decoration: BoxDecoration(
                color: AppPalette.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadii.md),
                border: Border.all(color: AppPalette.border),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppPalette.primary.withValues(alpha: 0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _SummaryRow(
                      label: 'Ara toplam',
                      value: formatMoney(subtotal),
                      theme: theme,
                      scheme: scheme,
                      emphasized: false,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _SummaryRow(
                      label: 'Toplam ürün adedi',
                      value: '$unitCount adet',
                      theme: theme,
                      scheme: scheme,
                      emphasized: false,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      child: Divider(
                        height: 1,
                        color: AppPalette.border.withValues(alpha: 0.95),
                      ),
                    ),
                    _SummaryRow(
                      label: 'Genel toplam',
                      value: formatMoney(subtotal),
                      theme: theme,
                      scheme: scheme,
                      emphasized: true,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '$lineCount farklı ürün kalemi',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );

            final Widget buttons = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: onCompleteSimulation,
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text('Simülasyonu tamamla'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppPalette.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
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
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: onContinueShopping,
                  icon: const Icon(Icons.storefront_outlined),
                  label: const Text('Alışverişe devam et'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppPalette.primary,
                    side: const BorderSide(color: AppPalette.border, width: 1.2),
                    padding: const EdgeInsets.symmetric(
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
                        return AppPalette.accent.withValues(alpha: 0.08);
                      }
                      return null;
                    }),
                  ),
                ),
              ],
            );

            if (narrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  summaryRows,
                  const SizedBox(height: AppSpacing.lg),
                  buttons,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(flex: 5, child: summaryRows),
                const SizedBox(width: AppSpacing.xl),
                Expanded(
                  flex: 4,
                  child: buttons,
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

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.theme,
    required this.scheme,
    required this.emphasized,
  });

  final String label;
  final String value;
  final ThemeData theme;
  final ColorScheme scheme;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value,
          style: emphasized
              ? theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppPalette.priceHighlight,
                  letterSpacing: 0.15,
                )
              : theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppPalette.textPrimary,
                ),
        ),
      ],
    );
  }
}
