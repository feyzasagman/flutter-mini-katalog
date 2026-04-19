import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Sepet ikonu üzerinde sayaç rozeti — vurgulu kırmızı.
class ShoppingCartBadge extends StatelessWidget {
  const ShoppingCartBadge({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    final String label = count > 99 ? '99+' : '$count';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppPalette.danger,
        borderRadius: BorderRadius.circular(999),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppPalette.danger.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      constraints: const BoxConstraints(minWidth: 18),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 10,
            ),
      ),
    );
  }
}
