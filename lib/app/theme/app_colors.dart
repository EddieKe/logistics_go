import 'package:flutter/material.dart';

class AppColors {
  // This class is not meant to be instantiated
  AppColors._(); 

  // Primary and Secondary Colors from PRD
  static const Color primary = Color(0xFF0D47A1); // Corporate Blue
  static const Color secondary = Color(0xFFFFA000); // Vibrant Orange/Yellow

  // Neutral Colors from PRD
  static const Color background = Color(0xFFF5F5F5); // Off-white/light gray
  static const Color text = Color(0xFF212121); // Dark charcoal/black

  // Status Colors from PRD
  static const Color success = Color(0xFF388E3C); // Green
  static const Color error = Color(0xFFD32F2F); // Red

  // Other common colors
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color(0xFFBDBDBD);
}