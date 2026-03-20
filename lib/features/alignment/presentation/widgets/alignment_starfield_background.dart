import 'package:flutter/material.dart';

class AlignmentStarfieldBackground extends StatelessWidget {
  const AlignmentStarfieldBackground({super.key, required this.child});

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
              colors: [Color(0xFF2E2B7E), Color(0xFF2A2771), Color(0xFF252266)],
            ),
          ),
        ),
        CustomPaint(painter: _AlignmentStarPainter()),
        child,
      ],
    );
  }
}

class _AlignmentStarPainter extends CustomPainter {
  final List<Offset> _stars = const [
    Offset(0.03, 0.05),
    Offset(0.14, 0.11),
    Offset(0.24, 0.07),
    Offset(0.36, 0.12),
    Offset(0.47, 0.08),
    Offset(0.58, 0.13),
    Offset(0.69, 0.09),
    Offset(0.8, 0.12),
    Offset(0.92, 0.07),
    Offset(0.06, 0.25),
    Offset(0.18, 0.22),
    Offset(0.3, 0.28),
    Offset(0.41, 0.24),
    Offset(0.53, 0.29),
    Offset(0.65, 0.23),
    Offset(0.76, 0.28),
    Offset(0.88, 0.24),
    Offset(0.04, 0.42),
    Offset(0.15, 0.48),
    Offset(0.27, 0.44),
    Offset(0.39, 0.49),
    Offset(0.5, 0.46),
    Offset(0.62, 0.5),
    Offset(0.73, 0.45),
    Offset(0.86, 0.51),
    Offset(0.95, 0.44),
    Offset(0.09, 0.63),
    Offset(0.2, 0.71),
    Offset(0.31, 0.66),
    Offset(0.44, 0.72),
    Offset(0.55, 0.68),
    Offset(0.66, 0.74),
    Offset(0.78, 0.67),
    Offset(0.89, 0.73),
    Offset(0.04, 0.9),
    Offset(0.17, 0.86),
    Offset(0.29, 0.92),
    Offset(0.42, 0.88),
    Offset(0.54, 0.93),
    Offset(0.67, 0.89),
    Offset(0.79, 0.94),
    Offset(0.91, 0.9),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final bright =
        Paint()
          ..color = Colors.white.withOpacity(0.22)
          ..style = PaintingStyle.fill;
    final dim =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..style = PaintingStyle.fill;

    for (int i = 0; i < _stars.length; i++) {
      final star = _stars[i];
      final offset = Offset(star.dx * size.width, star.dy * size.height);
      final isBright = i % 4 == 0;
      canvas.drawCircle(offset, isBright ? 1.4 : 0.9, isBright ? bright : dim);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
