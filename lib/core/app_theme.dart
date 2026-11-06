import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color deep = Color(0xFF3F2B96);
  static const Color mid = Color(0xFF6A4CE0);
  static const Color soft = Color(0xFF9B7BFF);
  static const Color tint = Color(0xFFF1ECFF);
  static const Color border = Color(0xFFE6DFF8);
  static const Color violet = Color(0xFF6A4CE0);

  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deep, mid, soft],
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.deep,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.deep,
          onPrimary: Colors.white,
          primaryContainer: AppColors.tint,
          onPrimaryContainer: AppColors.deep,
          secondary: AppColors.mid,
          secondaryContainer: AppColors.tint,
          onSecondaryContainer: AppColors.deep,
          tertiary: AppColors.soft,
          surface: Colors.white,
          onSurface: const Color(0xFF1D1A2F),
          onSurfaceVariant: const Color(0xFF6B6585),
          surfaceTint: Colors.transparent,
          surfaceContainerLowest: Colors.white,
          surfaceContainerLow: Colors.white,
          surfaceContainer: Colors.white,
          surfaceContainerHigh: Colors.white,
          surfaceContainerHighest: AppColors.tint,
          outline: const Color(0xFF9A93B5),
          outlineVariant: AppColors.border,
        );
    final radius = BorderRadius.circular(14);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.deep,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.border),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.tint,
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: AppColors.deep, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.error, width: 1.6),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.deep,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: radius),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.deep,
          side: const BorderSide(color: AppColors.border),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.deep,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        backgroundColor: Colors.white,
        elevation: 8,
        shadowColor: AppColors.deep.withValues(alpha: 0.3),
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.tint,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            color: s.contains(WidgetState.selected)
                ? AppColors.deep
                : scheme.outline,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => TextStyle(
            fontSize: 12,
            fontWeight: s.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: s.contains(WidgetState.selected)
                ? AppColors.deep
                : scheme.outline,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.deep,
        contentTextStyle: const TextStyle(color: Colors.white),
        actionTextColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
    );
  }
}
