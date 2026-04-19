import 'package:flutter/material.dart';

import '../models/product.dart';

bool isAssetImagePath(String raw) {
  final String u = raw.trim();
  return u.startsWith('assets/');
}

/// Ürün kimliğine göre yer tutucu ikon — yanlış ürün görseli göstermek yerine tutarlı sembol.
IconData productImagePlaceholderIcon(String productId) {
  switch (productId) {
    case 'p01':
      return Icons.headphones_rounded;
    case 'p02':
      return Icons.watch_rounded;
    case 'p03':
      return Icons.speaker_rounded;
    case 'p04':
      return Icons.device_hub_rounded;
    case 'p05':
      return Icons.keyboard_rounded;
    case 'p06':
      return Icons.mouse_rounded;
    case 'p07':
      return Icons.battery_charging_full_rounded;
    case 'p08':
      return Icons.videocam_rounded;
    case 'p09':
      return Icons.tablet_mac_rounded;
    default:
      return Icons.photo_outlined;
  }
}

/// Yerel `assets/images/products/...` görselleri; dosya yoksa veya geçersiz yol ise kontrollü yer tutucu.
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
    required this.fit,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.filterQuality = FilterQuality.medium,
  });

  final Product product;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final String src = product.imageUrl.trim();

    final Widget child;
    if (src.isEmpty || !isAssetImagePath(src)) {
      child = ControlledProductImagePlaceholder(product: product, scheme: scheme);
    } else {
      child = Image.asset(
        src,
        fit: fit,
        width: width,
        height: height,
        gaplessPlayback: true,
        filterQuality: filterQuality,
        errorBuilder: (_, Object __, StackTrace? ___) =>
            ControlledProductImagePlaceholder(product: product, scheme: scheme),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}

/// Asset yok veya bozuk: ürün türüne uyumlu ikon + kısa metin (rastgele fotoğraf yok).
class ControlledProductImagePlaceholder extends StatelessWidget {
  const ControlledProductImagePlaceholder({
    super.key,
    required this.product,
    required this.scheme,
  });

  final Product product;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final IconData icon = productImagePlaceholderIcon(product.id);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: scheme.outline.withValues(alpha: 0.35),
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 44, color: scheme.primary.withValues(alpha: 0.72)),
              const SizedBox(height: 10),
              Text(
                'Görsel dosyası yok',
                textAlign: TextAlign.center,
                style: text.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                product.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: text.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant.withValues(alpha: 0.88),
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
