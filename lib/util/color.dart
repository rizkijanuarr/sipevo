import 'package:flutter/material.dart';

class AppColors {
  static const int primaryColor = 0xFFEB5E42;
  static const int secondaryColor = 0xFF2E86AB; // Contoh warna sekunder

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryColor,
    const <int, Color>{
      50: const Color(0xFFFFF3F2),
      100: const Color(0xFFFFE0D9),
      200: const Color(0xFFFFCBBF),
      300: const Color(0xFFFFB5A5),
      400: const Color(0xFFFFA292),
      500: const Color(primaryColor),
      600: const Color(0xFFFF7D6E),
      700: const Color(0xFFFF7263),
      800: const Color(0xFFFF6758),
      900: const Color(0xFFFF5444),
    },
  );

  static const MaterialColor secondarySwatch = const MaterialColor(
    secondaryColor,
    const <int, Color>{
      50: const Color(0xFFD4E6F1),
      100: const Color(0xFFA9CCE3),
      200: const Color(0xFF7FB3D5),
      300: const Color(0xFF5499C7),
      400: const Color(0xFF3182BD),
      500: const Color(secondaryColor),
      600: const Color(0xFF2E7CBF),
      700: const Color(0xFF2B76BF),
      800: const Color(0xFF2871BF),
      900: const Color(0xFF2269BF),
    },
  );
}
