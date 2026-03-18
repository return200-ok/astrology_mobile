import 'package:flutter/material.dart';

class AstroTheme {
  // Dark astrology colors (same as web)
  static const Color darkBg = Color(0xFF0a0e27);
  static const Color cosmicPurple = Color(0xFF3d1a5c);
  static const Color navyDeep = Color(0xFF1a2f4d);
  static const Color accentGold = Color(0xFFd4af37);
  static const Color glowPurple = Color(0xFF8b5cf6);
  static const Color glowCyan = Color(0xFF06b6d4);
  static const Color starYellow = Color(0xFFfbbf24);

  // Element colors (ngũ hành)
  static const Map<String, Color> elementColors = {
    'kim': accentGold,      // gold
    'thuy': glowCyan,       // cyan
    'hoa': Color(0xFFf87171), // red
    'moc': Color(0xFF34d399), // green
    'tho': Color(0xFFfca5a5), // beige
  };

  // Theme data
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: glowPurple,
        background: darkBg,
        surface: cosmicPurple,
      ),
      scaffoldBackgroundColor: darkBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: navyDeep,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: cosmicPurple.withOpacity(0.5),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: glowPurple.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: Colors.white70,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: Colors.white60,
          fontSize: 14,
        ),
      ),
    );
  }

  // Glass card decoration (matching web)
  static BoxDecoration glassCardStyle({Color? glow}) {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      border: Border.all(
        color: (glow ?? glowPurple).withOpacity(0.3),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: (glow ?? glowPurple).withOpacity(0.1),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ],
    );
  }

  // Chart gradient (matching web)
  static Decoration chartGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          darkBg,
          cosmicPurple.withOpacity(0.4),
          navyDeep,
        ],
      ),
    );
  }
}
