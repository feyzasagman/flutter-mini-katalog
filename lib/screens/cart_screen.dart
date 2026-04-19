import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../state/cart_state.dart';
import '../theme/design_tokens.dart';
import '../widgets/cart_line_card.dart';
import '../widgets/cart_summary_footer.dart';
import '../widgets/empty_state_widget.dart';

/// Sepet — liste, adet kontrolü, silme ve özet alt alan.
class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
    required this.cartState,
  });

  final CartState cartState;

  static const double _thumbSize = 84;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Sepetim'),
        actions: <Widget>[
          ListenableBuilder(
            listenable: cartState,
            builder: (BuildContext context, Widget? child) {
              if (cartState.isEmpty) {
                return const SizedBox.shrink();
              }
              return TextButton(
                onPressed: () => _confirmClear(context),
                child: const Text('Tümünü kaldır'),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: cartState,
        builder: (BuildContext context, Widget? child) {
          if (cartState.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.shopping_bag_outlined,
              title: 'Sepetiniz boş',
              message:
                  'Henüz ürün eklemediniz. Koleksiyonumuza göz atarak sepetinizi oluşturabilirsiniz.',
              action: FilledButton.icon(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Ürünlere dön'),
              ),
            );
          }

          final List<CartItem> items = cartState.items;

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.sm,
                  ),
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (BuildContext context, int index) {
                    final CartItem line = items[index];
                    return CartLineCard(
                      line: line,
                      cartState: cartState,
                      thumbSize: _thumbSize,
                    );
                  },
                ),
              ),
              CartSummaryFooter(
                cartState: cartState,
                onContinueShopping: () =>
                    Navigator.of(context).maybePop(),
                onCompleteSimulation: () =>
                    _onSimulationComplete(context),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onSimulationComplete(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppSpacing.lg),
        content: const Text(
          'Simülasyon tamamlandı. Ödeme adımı bu demoda kullanılmaz.',
        ),
      ),
    );
  }

  Future<void> _confirmClear(BuildContext context) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          title: const Text('Sepeti boşalt'),
          content: const Text(
            'Tüm ürünleri kaldırmak istediğinize emin misiniz?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('İptal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Boşalt'),
            ),
          ],
        );
      },
    );

    if (ok == true) {
      cartState.clear();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sepet temizlendi.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
