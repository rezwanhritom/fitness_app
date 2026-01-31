import 'package:flutter/material.dart';

/// App color constants following the design system
class AppColors {
  // Primary Color: Electric Cyan
  static const Color primary = Color(0xFF00F5FF);
  
  // Secondary Color: Deep Obsidian
  static const Color secondary = Color(0xFF121212);
  
  // Tertiary Color: Slate Grey
  static const Color tertiary = Color(0xFF8E8E93);
  
  // Accent Color: Acid Lime
  static const Color accent = Color(0xFFDFFF00);
  
  // Additional semantic colors for dark mode
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color surfaceVariant = Color(0xFF2C2C2C);
  static const Color onPrimary = Color(0xFF121212);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFCF6679);
  static const Color onError = Color(0xFF121212);
  
  // Disabled states
  static const Color disabled = Color(0xFF8E8E93);
  static const Color onDisabled = Color(0xFF4A4A4A);
  
  // Divider and borders
  static const Color divider = Color(0xFF2C2C2C);
  static const Color border = Color(0xFF3A3A3A);
  
  // Private constructor to prevent instantiation
  AppColors._();
}
