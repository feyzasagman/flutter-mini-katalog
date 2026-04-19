import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Ana sayfa — çok açık gri-mavi katmanlı zemin (saf beyaz değil).
class HomePageBackdrop extends StatelessWidget {
  const HomePageBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          stops: const <double>[0.0, 0.38, 1.0],
          colors: <Color>[
            AppPalette.backgroundWash,
            AppPalette.background,
            Color.lerp(
              AppPalette.background,
              AppPalette.surfaceAlt,
              0.28,
            )!,
          ],
        ),
      ),
    );
  }
}

/// Banner ile arama arasında çok hafif soğuk ton geçişi.
class HomeBannerSoftFade extends StatelessWidget {
  const HomeBannerSoftFade({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 36,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  AppPalette.accent.withValues(alpha: 0.055),
                  AppPalette.accent.withValues(alpha: 0.02),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
