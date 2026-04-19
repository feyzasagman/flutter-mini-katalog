import 'package:flutter/material.dart';

import '../theme/app_colors.dart' show AppPalette;
import '../theme/design_tokens.dart';

/// Bölüm başlığı — isteğe bağlı alt açıklama ile güçlü hiyerarşi.
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.lg,
      AppSpacing.lg,
      AppSpacing.sm,
    ),
  });

  final String title;
  final String? subtitle;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 4,
                  height: 22,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        AppPalette.accent,
                        AppPalette.accent.withValues(alpha: 0.65),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.35,
                      fontSize: 19,
                      color: AppPalette.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            if (subtitle != null && subtitle!.isNotEmpty) ...<Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.md + 4,
                  top: AppSpacing.sm + 2,
                ),
                child: Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppPalette.textSecondary,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
