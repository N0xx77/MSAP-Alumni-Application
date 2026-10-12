import 'package:flutter/material.dart';

/// Centralized color tokens for MSAP Alumni Application.
/// These placeholder values can be updated when final brand guidelines are established.
abstract class AppColors {
  // Brand Palette
  static const Color primary = Color(0xFF1E3A8A); // Deep Navy Blue
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1E293B);

  static const Color secondary = Color(0xFFD97706); // Warm Amber/Gold
  static const Color secondaryLight = Color(0xFFFBBF24);

  static const Color accent = Color(0xFF0D9488); // Teal Accent
  static const Color purpleAccent = Color(0xFF6B21A8); // Deep Royal Purple Accent
  static const Color purpleLight = Color(0xFFFAF5FF); // Light Purple Tint

  // Neutral Colors
  static const Color background = Color(0xFFF8FAFC); // Very light slate gray
  static const Color creamBackground = Color(0xFFFBFBFA); // Warm cream/off-white background
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Border & Divider
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFCBD5E1);

  // Typography Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status & Feedback
  static const Color success = Color(0xFF10B981);
  static const Color successBackground = Color(0xFFECFDF5);
  
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningBackground = Color(0xFFFFFBEB);

  static const Color error = Color(0xFFEF4444);
  static const Color errorBackground = Color(0xFFFEF2F2);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoBackground = Color(0xFFEFF6FF);

  // Card & Elevation
  static const Color cardShadow = Color(0x0F000000);
}
