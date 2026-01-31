import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import 'typography.dart';

/// App theme configuration with dark-mode-first design
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        surface: AppColors.surface,
        surfaceVariant: AppColors.surfaceVariant,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurface,
        onBackground: AppColors.onBackground,
        onError: AppColors.onError,
      ),
      
      // Scaffold background
      scaffoldBackgroundColor: AppColors.background,
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.heading3.copyWith(
          color: AppColors.onBackground,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.onBackground,
          size: 24,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.buttonLarge,
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: AppTypography.buttonMedium,
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.buttonLarge,
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.tertiary,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.tertiary,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.onBackground,
        size: 24,
      ),
      
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.heading1.copyWith(color: AppColors.onBackground),
        displayMedium: AppTypography.heading2.copyWith(color: AppColors.onBackground),
        displaySmall: AppTypography.heading3.copyWith(color: AppColors.onBackground),
        headlineMedium: AppTypography.heading4.copyWith(color: AppColors.onBackground),
        titleLarge: AppTypography.heading3.copyWith(color: AppColors.onBackground),
        titleMedium: AppTypography.heading4.copyWith(color: AppColors.onBackground),
        titleSmall: AppTypography.labelLarge.copyWith(color: AppColors.onBackground),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColors.onBackground),
        bodyMedium: AppTypography.bodyMedium.copyWith(color: AppColors.onBackground),
        bodySmall: AppTypography.bodySmall.copyWith(color: AppColors.tertiary),
        labelLarge: AppTypography.labelLarge.copyWith(color: AppColors.onBackground),
        labelMedium: AppTypography.labelMedium.copyWith(color: AppColors.tertiary),
        labelSmall: AppTypography.caption.copyWith(color: AppColors.tertiary),
      ),
      
      // Default font family
      fontFamily: GoogleFonts.inter().fontFamily,
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.tertiary,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 4,
      ),
    );
  }
  
  // Private constructor to prevent instantiation
  AppTheme._();
}
