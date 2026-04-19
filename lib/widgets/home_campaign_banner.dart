import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

/// Ana sayfa kampanya alanı — koyu lacivert gradient, chip’ler, dekoratif ikon.
class HomeCampaignBanner extends StatelessWidget {
  const HomeCampaignBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Material(
        color: Colors.transparent,
        elevation: 2,
        shadowColor: AppPalette.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.lg),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints c) {
              final bool showAccent = c.maxWidth > 400;
              return Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 124,
                  maxHeight: 152,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.lg,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      AppPalette.primary,
                      AppPalette.primarySoft,
                      AppPalette.bannerEdge,
                    ],
                    stops: <double>[0.0, 0.52, 1.0],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Teknolojide kampanya',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.15,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Seçili ürünlerde şeffaf fiyatlar ve güvenli alışveriş.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.94),
                              height: 1.38,
                              fontSize: 13.5,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          const Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: <Widget>[
                              _BannerChip(
                                icon: Icons.local_shipping_outlined,
                                label: 'Hızlı kargo',
                              ),
                              _BannerChip(
                                icon: Icons.verified_user_outlined,
                                label: 'Güvenli ödeme',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (showAccent) ...<Widget>[
                      const SizedBox(width: AppSpacing.md),
                      Icon(
                        Icons.devices_other_rounded,
                        size: 56,
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BannerChip extends StatelessWidget {
  const _BannerChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 15, color: Colors.white.withValues(alpha: 0.95)),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
