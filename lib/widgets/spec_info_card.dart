import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

/// Teknik özellik — surfaceAlt zemin, ince border, sade tipografi.
class SpecInfoCard extends StatelessWidget {
  const SpecInfoCard({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(
          color: AppPalette.border,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppPalette.primary.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md + 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppPalette.textSecondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.15,
              ),
            ),
            const SizedBox(height: AppSpacing.xs + 2),
            Text(
              value,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.3,
                color: AppPalette.primarySoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
