import 'package:flutter/material.dart';

class ImperialStarfieldBackground extends StatelessWidget {
  const ImperialStarfieldBackground({super.key, required this.child});

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
              colors: [Color(0xFF2C2A78), Color(0xFF27236D), Color(0xFF1F1B58)],
            ),
          ),
        ),
        CustomPaint(painter: _ImperialStarPainter()),
        child,
      ],
    );
  }
}

class _ImperialStarPainter extends CustomPainter {
  final List<Offset> _stars = const [
    Offset(0.04, 0.05),
    Offset(0.12, 0.11),
    Offset(0.21, 0.07),
    Offset(0.31, 0.14),
    Offset(0.39, 0.08),
    Offset(0.48, 0.12),
    Offset(0.58, 0.06),
    Offset(0.66, 0.13),
    Offset(0.74, 0.08),
    Offset(0.85, 0.11),
    Offset(0.94, 0.07),
    Offset(0.06, 0.23),
    Offset(0.15, 0.29),
    Offset(0.25, 0.25),
    Offset(0.35, 0.31),
    Offset(0.44, 0.23),
    Offset(0.53, 0.30),
    Offset(0.64, 0.25),
    Offset(0.73, 0.29),
    Offset(0.82, 0.24),
    Offset(0.93, 0.3),
    Offset(0.08, 0.43),
    Offset(0.19, 0.49),
    Offset(0.27, 0.45),
    Offset(0.37, 0.51),
    Offset(0.47, 0.43),
    Offset(0.56, 0.5),
    Offset(0.67, 0.46),
    Offset(0.76, 0.52),
    Offset(0.87, 0.44),
    Offset(0.95, 0.5),
    Offset(0.05, 0.67),
    Offset(0.13, 0.74),
    Offset(0.24, 0.69),
    Offset(0.34, 0.76),
    Offset(0.43, 0.68),
    Offset(0.52, 0.74),
    Offset(0.62, 0.7),
    Offset(0.71, 0.78),
    Offset(0.82, 0.69),
    Offset(0.9, 0.76),
    Offset(0.03, 0.91),
    Offset(0.15, 0.87),
    Offset(0.23, 0.94),
    Offset(0.34, 0.89),
    Offset(0.45, 0.95),
    Offset(0.54, 0.88),
    Offset(0.65, 0.93),
    Offset(0.75, 0.9),
    Offset(0.86, 0.95),
    Offset(0.94, 0.89),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final bright =
        Paint()
          ..color = Colors.white.withOpacity(0.25)
          ..style = PaintingStyle.fill;
    final dim =
        Paint()
          ..color = Colors.white.withOpacity(0.12)
          ..style = PaintingStyle.fill;

    for (int i = 0; i < _stars.length; i++) {
      final p = _stars[i];
      final offset = Offset(p.dx * size.width, p.dy * size.height);
      final isBright = i % 4 == 0;
      canvas.drawCircle(offset, isBright ? 1.4 : 0.9, isBright ? bright : dim);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
