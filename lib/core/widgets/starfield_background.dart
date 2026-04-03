import 'package:flutter/material.dart';

/// Reusable starfield background with customizable gradient and star density.
///
/// Replaces the 5 per-feature starfield copies (Oracle, Imperial, I Ching,
/// Soul Revelation, Cosmic Void) with a single parameterized widget.
class StarfieldBackground extends StatelessWidget {
  const StarfieldBackground({
    super.key,
    required this.child,
    this.gradientColors = defaultGradient,
    this.brightOpacity = 0.24,
    this.dimOpacity = 0.11,
    this.stars = defaultStars,
  });

  final Widget child;
  final List<Color> gradientColors;
  final double brightOpacity;
  final double dimOpacity;
  final List<Offset> stars;

  // ── Presets ──────────────────────────────────────────────────────────────

  static const defaultGradient = [
    Color(0xFF2C2A78),
    Color(0xFF27236D),
    Color(0xFF1F1B58),
  ];

  static const oracleGradient = [
    Color(0xFF2B2771),
    Color(0xFF211E63),
    Color(0xFF1B1A58),
  ];

  static const ichingGradient = [
    Color(0xFF2E2B7B),
    Color(0xFF2A266E),
    Color(0xFF252264),
  ];

  static const soulGradient = [
    Color(0xFF2E2B7E),
    Color(0xFF2A276F),
    Color(0xFF252364),
  ];

  static const cosmicGradient = [
    Color(0xFF2E2A7F),
    Color(0xFF2A2574),
    Color(0xFF252067),
  ];

  /// 50 star positions — shared default set.
  static const defaultStars = [
    Offset(0.04, 0.05), Offset(0.12, 0.11), Offset(0.21, 0.07),
    Offset(0.31, 0.14), Offset(0.39, 0.08), Offset(0.48, 0.12),
    Offset(0.58, 0.06), Offset(0.66, 0.13), Offset(0.74, 0.08),
    Offset(0.85, 0.11), Offset(0.94, 0.07),
    Offset(0.06, 0.23), Offset(0.15, 0.29), Offset(0.25, 0.25),
    Offset(0.35, 0.31), Offset(0.44, 0.23), Offset(0.53, 0.30),
    Offset(0.64, 0.25), Offset(0.73, 0.29), Offset(0.82, 0.24),
    Offset(0.93, 0.30),
    Offset(0.08, 0.43), Offset(0.19, 0.49), Offset(0.27, 0.45),
    Offset(0.37, 0.51), Offset(0.47, 0.43), Offset(0.56, 0.50),
    Offset(0.67, 0.46), Offset(0.76, 0.52), Offset(0.87, 0.44),
    Offset(0.95, 0.50),
    Offset(0.05, 0.67), Offset(0.13, 0.74), Offset(0.24, 0.69),
    Offset(0.34, 0.76), Offset(0.43, 0.68), Offset(0.52, 0.74),
    Offset(0.62, 0.70), Offset(0.71, 0.78), Offset(0.82, 0.69),
    Offset(0.90, 0.76),
    Offset(0.03, 0.91), Offset(0.15, 0.87), Offset(0.23, 0.94),
    Offset(0.34, 0.89), Offset(0.45, 0.95), Offset(0.54, 0.88),
    Offset(0.65, 0.93), Offset(0.75, 0.90), Offset(0.86, 0.95),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
          ),
        ),
        CustomPaint(
          painter: _StarfieldPainter(
            stars: stars,
            brightOpacity: brightOpacity,
            dimOpacity: dimOpacity,
          ),
        ),
        child,
      ],
    );
  }
}

class _StarfieldPainter extends CustomPainter {
  const _StarfieldPainter({
    required this.stars,
    required this.brightOpacity,
    required this.dimOpacity,
  });

  final List<Offset> stars;
  final double brightOpacity;
  final double dimOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final bright = Paint()
      ..color = Colors.white.withValues(alpha: brightOpacity)
      ..style = PaintingStyle.fill;
    final dim = Paint()
      ..color = Colors.white.withValues(alpha: dimOpacity)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < stars.length; i++) {
      final s = stars[i];
      final offset = Offset(s.dx * size.width, s.dy * size.height);
      final isBright = i % 4 == 0;
      canvas.drawCircle(offset, isBright ? 1.4 : 0.9, isBright ? bright : dim);
    }
  }

  @override
  bool shouldRepaint(covariant _StarfieldPainter old) =>
      old.brightOpacity != brightOpacity || old.dimOpacity != dimOpacity;
}
