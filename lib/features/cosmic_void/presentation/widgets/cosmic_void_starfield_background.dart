import 'package:flutter/material.dart';

class CosmicVoidStarfieldBackground extends StatelessWidget {
  const CosmicVoidStarfieldBackground({super.key, required this.child});

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
              colors: [Color(0xFF2E2A7F), Color(0xFF2A2574), Color(0xFF252067)],
            ),
          ),
        ),
        CustomPaint(painter: _CosmicVoidStarPainter()),
        child,
      ],
    );
  }
}

class _CosmicVoidStarPainter extends CustomPainter {
  final List<Offset> _stars = const [
    Offset(0.03, 0.04),
    Offset(0.11, 0.08),
    Offset(0.21, 0.05),
    Offset(0.31, 0.09),
    Offset(0.4, 0.06),
    Offset(0.49, 0.1),
    Offset(0.59, 0.07),
    Offset(0.69, 0.11),
    Offset(0.79, 0.06),
    Offset(0.89, 0.1),
    Offset(0.96, 0.05),
    Offset(0.06, 0.2),
    Offset(0.16, 0.24),
    Offset(0.26, 0.21),
    Offset(0.37, 0.25),
    Offset(0.47, 0.2),
    Offset(0.58, 0.26),
    Offset(0.67, 0.22),
    Offset(0.78, 0.27),
    Offset(0.88, 0.23),
    Offset(0.95, 0.27),
    Offset(0.04, 0.39),
    Offset(0.15, 0.45),
    Offset(0.25, 0.4),
    Offset(0.36, 0.46),
    Offset(0.47, 0.41),
    Offset(0.57, 0.47),
    Offset(0.68, 0.42),
    Offset(0.79, 0.48),
    Offset(0.9, 0.43),
    Offset(0.08, 0.61),
    Offset(0.18, 0.67),
    Offset(0.28, 0.63),
    Offset(0.38, 0.69),
    Offset(0.48, 0.64),
    Offset(0.58, 0.7),
    Offset(0.68, 0.65),
    Offset(0.78, 0.71),
    Offset(0.88, 0.66),
    Offset(0.06, 0.84),
    Offset(0.16, 0.9),
    Offset(0.27, 0.85),
    Offset(0.39, 0.91),
    Offset(0.5, 0.86),
    Offset(0.61, 0.92),
    Offset(0.72, 0.87),
    Offset(0.83, 0.93),
    Offset(0.93, 0.88),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final bright =
        Paint()
          ..color = Colors.white.withOpacity(0.24)
          ..style = PaintingStyle.fill;
    final dim =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..style = PaintingStyle.fill;

    for (int i = 0; i < _stars.length; i++) {
      final star = _stars[i];
      final offset = Offset(star.dx * size.width, star.dy * size.height);
      final isBright = i % 4 == 0;
      canvas.drawCircle(offset, isBright ? 1.35 : 0.85, isBright ? bright : dim);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
