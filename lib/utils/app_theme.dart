import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

/// Premium koyu lacivert + mavi vurgu; tüm uygulama tek tasarım dili.
abstract final class AppTheme {
  static const double _buttonRadius = 12;
  static const EdgeInsets _buttonPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
    vertical: AppSpacing.md + 2,
  );

  static ColorScheme get _lightScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: AppPalette.primary,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: AppPalette.categoryChipBg,
      onPrimaryContainer: AppPalette.categoryChipFg,
      secondary: AppPalette.accent,
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: AppPalette.surfaceAlt,
      onSecondaryContainer: AppPalette.primary,
      tertiary: AppPalette.accentSoft,
      onTertiary: AppPalette.primary,
      error: AppPalette.danger,
      onError: Color(0xFFFFFFFF),
      surface: AppPalette.surface,
      onSurface: AppPalette.textPrimary,
      onSurfaceVariant: AppPalette.textSecondary,
      surfaceContainerHighest: AppPalette.surfaceAlt,
      outline: AppPalette.border,
      outlineVariant: Color(0xFFCBD5E1),
      shadow: AppPalette.primary,
      scrim: Color(0xFF0B1220),
      inverseSurface: AppPalette.primary,
      onInverseSurface: Color(0xFFFFFFFF),
      surfaceTint: AppPalette.accent,
    );
  }

  static ButtonStyle _primaryFilledStyle() {
    return FilledButton.styleFrom(
      backgroundColor: AppPalette.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: AppPalette.border,
      disabledForegroundColor: AppPalette.textSecondary,
      padding: _buttonPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonRadius),
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.white.withValues(alpha: 0.16);
        }
        if (states.contains(WidgetState.hovered)) {
          return Colors.white.withValues(alpha: 0.10);
        }
        if (states.contains(WidgetState.focused)) {
          return Colors.white.withValues(alpha: 0.12);
        }
        return null;
      }),
    );
  }

  static ButtonStyle _outlinedStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: AppPalette.primary,
      side: const BorderSide(color: AppPalette.border, width: 1.2),
      padding: _buttonPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonRadius),
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.pressed)) {
          return AppPalette.accent.withValues(alpha: 0.08);
        }
        return null;
      }),
    );
  }

  static ButtonStyle _textButtonStyle() {
    return TextButton.styleFrom(
      foregroundColor: AppPalette.accent,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.hovered)) {
          return AppPalette.accent.withValues(alpha: 0.10);
        }
        return null;
      }),
    );
  }

  static ThemeData get light {
    final ColorScheme scheme = _lightScheme;

    final ThemeData base = ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: AppPalette.background,
      shadowColor: AppPalette.primary.withValues(alpha: 0.08),
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: AppPalette.primary.withValues(alpha: 0.06),
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppPalette.surface,
        foregroundColor: AppPalette.textPrimary,
        toolbarHeight: 52,
        titleSpacing: AppSpacing.lg,
        actionsPadding: const EdgeInsets.only(right: AppSpacing.sm),
        iconTheme: const IconThemeData(
          color: AppPalette.primary,
          size: 22,
        ),
        actionsIconTheme: const IconThemeData(
          color: AppPalette.primary,
          size: 22,
        ),
        shape: Border(
          bottom: BorderSide(
            color: AppPalette.border.withValues(alpha: 0.95),
          ),
        ),
        titleTextStyle: base.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.15,
          color: AppPalette.textPrimary,
          fontSize: 17,
        ),
      ),
      textTheme: base.textTheme.copyWith(
        titleLarge: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
          color: AppPalette.textPrimary,
        ),
        titleMedium: base.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.1,
          color: AppPalette.primarySoft,
        ),
        titleSmall: base.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppPalette.primarySoft,
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(
          height: 1.45,
          color: AppPalette.textSecondary,
        ),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(
          height: 1.4,
          color: AppPalette.textSecondary,
        ),
        bodySmall: base.textTheme.bodySmall?.copyWith(
          height: 1.35,
          color: AppPalette.textSecondary,
        ),
        labelLarge: base.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.12,
          color: AppPalette.primary,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        color: AppPalette.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppPalette.primary.withValues(alpha: 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          side: const BorderSide(color: AppPalette.border),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppPalette.surface,
        hintStyle: TextStyle(
          color: AppPalette.textSecondary.withValues(alpha: 0.85),
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(color: AppPalette.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppPalette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppPalette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppPalette.accent, width: 1.6),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: _primaryFilledStyle(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: _buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.white.withValues(alpha: 0.10);
            }
            return null;
          }),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _outlinedStyle(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: _textButtonStyle(),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppPalette.categoryChipBg,
        deleteIconColor: AppPalette.categoryChipFg,
        disabledColor: AppPalette.surfaceAlt,
        selectedColor: AppPalette.accent.withValues(alpha: 0.15),
        secondarySelectedColor: AppPalette.surfaceAlt,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          side: BorderSide.none,
        ),
        labelStyle: TextStyle(
          color: AppPalette.categoryChipFg,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        secondaryLabelStyle: TextStyle(
          color: AppPalette.textSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        brightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(
        color: AppPalette.primary,
        size: 24,
      ),
      dividerTheme: DividerThemeData(
        color: AppPalette.border.withValues(alpha: 0.9),
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppPalette.primary,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
      ),
    );
  }
}
