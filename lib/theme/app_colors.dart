import 'package:flutter/material.dart';

/// Premium teknoloji mağazası — merkezi renk paleti (tek kaynak).
abstract final class AppPalette {
  static const Color primary = Color(0xFF0F172A);
  static const Color primarySoft = Color(0xFF1E293B);
  static const Color accent = Color(0xFF3B82F6);
  static const Color accentSoft = Color(0xFF60A5FA);
  static const Color background = Color(0xFFF8FAFC);
  /// Ana sayfa üst bandı — kırık gri-mavi (gradient başlangıcı).
  static const Color backgroundWash = Color(0xFFF5F7FB);
  /// Ürün bölümü iç zemin — kartlardan hafif ayrım.
  static const Color surfaceSection = Color(0xFFFAFBFE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF1F5F9);
  static const Color textPrimary = Color(0xFF0B1220);
  static const Color textSecondary = Color(0xFF475569);
  static const Color border = Color(0xFFE2E8F0);
  static const Color priceHighlight = Color(0xFF1D4ED8);
  static const Color success = Color(0xFF10B981);
  static const Color danger = Color(0xFFEF4444);

  /// Kategori chip (ürün kartı).
  static const Color categoryChipBg = Color(0xFFEFF6FF);
  static const Color categoryChipFg = Color(0xFF1E3A8A);

  /// Fiyat kutusu (ürün kartı / liste).
  static const Color priceBlockBg = Color(0xFFEFF6FF);
  static const Color priceBlockBorder = Color(0xFFBFDBFE);

  /// Kampanya banner sağ gradient ucu.
  static const Color bannerEdge = Color(0xFF334155);
}

/// Geriye dönük kısayollar — yeni kod `AppPalette` tercih etmeli.
abstract final class AppColors {
  static const Color ink = AppPalette.textPrimary;
  static const Color slate = AppPalette.primarySoft;
  static const Color slateMuted = AppPalette.textSecondary;
}
