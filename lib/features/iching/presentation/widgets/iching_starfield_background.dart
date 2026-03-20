import 'package:flutter/material.dart';

class IChingStarfieldBackground extends StatelessWidget {
  const IChingStarfieldBackground({super.key, required this.child});

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
              colors: [Color(0xFF2E2B7B), Color(0xFF2A266E), Color(0xFF252264)],
            ),
          ),
        ),
        CustomPaint(painter: _IChingStarPainter()),
        child,
      ],
    );
  }
}

class _IChingStarPainter extends CustomPainter {
  final List<Offset> _stars = const [
    Offset(0.04, 0.06),
    Offset(0.13, 0.11),
    Offset(0.22, 0.07),
    Offset(0.31, 0.12),
    Offset(0.4, 0.08),
    Offset(0.49, 0.14),
    Offset(0.59, 0.09),
    Offset(0.69, 0.13),
    Offset(0.79, 0.08),
    Offset(0.88, 0.12),
    Offset(0.95, 0.07),
    Offset(0.06, 0.23),
    Offset(0.17, 0.29),
    Offset(0.27, 0.24),
    Offset(0.36, 0.3),
    Offset(0.47, 0.23),
    Offset(0.57, 0.29),
    Offset(0.66, 0.25),
    Offset(0.77, 0.31),
    Offset(0.87, 0.24),
    Offset(0.94, 0.29),
    Offset(0.05, 0.44),
    Offset(0.16, 0.5),
    Offset(0.25, 0.46),
    Offset(0.35, 0.52),
    Offset(0.46, 0.45),
    Offset(0.55, 0.51),
    Offset(0.67, 0.47),
    Offset(0.76, 0.53),
    Offset(0.86, 0.46),
    Offset(0.95, 0.52),
    Offset(0.07, 0.67),
    Offset(0.18, 0.73),
    Offset(0.28, 0.68),
    Offset(0.39, 0.75),
    Offset(0.5, 0.69),
    Offset(0.61, 0.74),
    Offset(0.7, 0.7),
    Offset(0.81, 0.76),
    Offset(0.91, 0.68),
    Offset(0.03, 0.9),
    Offset(0.14, 0.86),
    Offset(0.24, 0.93),
    Offset(0.34, 0.89),
    Offset(0.45, 0.95),
    Offset(0.56, 0.88),
    Offset(0.66, 0.93),
    Offset(0.76, 0.9),
    Offset(0.87, 0.95),
    Offset(0.95, 0.89),
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
