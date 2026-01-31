import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography styles using Inter font family
class AppTypography {
  // Inter Bold for major headings and numbers
  static TextStyle get heading1 => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        height: 1.2,
      );
  
  static TextStyle get heading2 => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
        height: 1.3,
      );
  
  static TextStyle get heading3 => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
        height: 1.4,
      );
  
  static TextStyle get heading4 => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.15,
        height: 1.4,
      );
  
  // Inter Bold for numbers
  static TextStyle get numberLarge => GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        letterSpacing: -1,
        height: 1.1,
      );
  
  static TextStyle get numberMedium => GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        height: 1.2,
      );
  
  static TextStyle get numberSmall => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
        height: 1.3,
      );
  
  // Inter Regular for body text
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.15,
        height: 1.5,
      );
  
  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
        height: 1.5,
      );
  
  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.4,
        height: 1.5,
      );
  
  // Button text
  static TextStyle get buttonLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.5,
      );
  
  static TextStyle get buttonMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.5,
      );
  
  // Label and caption
  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.4,
      );
  
  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.4,
      );
  
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.4,
        height: 1.4,
      );
  
  // Private constructor to prevent instantiation
  AppTypography._();
}
