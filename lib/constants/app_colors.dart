import 'package:flutter/material.dart';

/// Shared application color palette used across Auth, Directory, and shared UI.
///
/// Individual member bio screens intentionally define their own distinct
/// palettes to satisfy the CA 02 unique design requirement.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1E3A8A);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color secondary = Color(0xFF0D9488);
  static const Color accent = Color(0xFFF59E0B);

  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);

  static const Color darkBackground = Color(0xFF0B1120);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
}
