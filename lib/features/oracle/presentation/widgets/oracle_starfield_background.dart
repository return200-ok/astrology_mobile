import 'package:flutter/material.dart';

class OracleStarfieldBackground extends StatelessWidget {
  const OracleStarfieldBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2B2771), Color(0xFF211E63), Color(0xFF1B1A58)],
            ),
          ),
        ),
        CustomPaint(
          painter: _StarfieldPainter(),
        ),
        child,
      ],
    );
  }
}

class _StarfieldPainter extends CustomPainter {
  final List<Offset> _stars = const [
    Offset(0.03, 0.06),
    Offset(0.14, 0.13),
    Offset(0.28, 0.09),
    Offset(0.35, 0.17),
    Offset(0.49, 0.08),
    Offset(0.62, 0.13),
    Offset(0.77, 0.09),
    Offset(0.89, 0.14),
    Offset(0.95, 0.07),
    Offset(0.08, 0.22),
    Offset(0.2, 0.3),
    Offset(0.31, 0.26),
    Offset(0.44, 0.31),
    Offset(0.57, 0.24),
    Offset(0.68, 0.31),
    Offset(0.81, 0.28),
    Offset(0.91, 0.24),
    Offset(0.05, 0.44),
    Offset(0.14, 0.54),
    Offset(0.27, 0.45),
    Offset(0.38, 0.53),
    Offset(0.51, 0.47),
    Offset(0.63, 0.55),
    Offset(0.74, 0.46),
    Offset(0.86, 0.52),
    Offset(0.95, 0.42),
    Offset(0.09, 0.67),
    Offset(0.22, 0.74),
    Offset(0.34, 0.69),
    Offset(0.45, 0.79),
    Offset(0.57, 0.7),
    Offset(0.7, 0.76),
    Offset(0.83, 0.67),
    Offset(0.92, 0.79),
    Offset(0.04, 0.91),
    Offset(0.19, 0.88),
    Offset(0.29, 0.95),
    Offset(0.42, 0.9),
    Offset(0.53, 0.94),
    Offset(0.67, 0.89),
    Offset(0.79, 0.93),
    Offset(0.9, 0.9),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final brightStarPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.28)
          ..style = PaintingStyle.fill;
    final dimStarPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.14)
          ..style = PaintingStyle.fill;

    for (int i = 0; i < _stars.length; i++) {
      final star = _stars[i];
      final dx = star.dx * size.width;
      final dy = star.dy * size.height;
      final isBright = i % 3 == 0;
      final radius = isBright ? 1.4 : 0.9;
      canvas.drawCircle(Offset(dx, dy), radius, isBright ? brightStarPaint : dimStarPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
