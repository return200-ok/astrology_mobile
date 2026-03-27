import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Shared ink-wash parchment background used across all redesigned screens.
///
/// Renders layered elements that evoke traditional Vietnamese/Chinese ink wash
/// (tranh thủy mặc) painting on parchment.
class InkWashBackground extends StatelessWidget {
  const InkWashBackground({super.key, required this.child});

  final Widget child;

  /// Off-white parchment — the one source of truth for the background colour.
  static const Color parchment = Color(0xFFF8F4EE);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: parchment,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              painter: _InkWashPainter(),
              child: const SizedBox.expand(),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _InkWashPainter extends CustomPainter {
  static const Color _red = Color(0xFFCC3333);
  static const Color _ink = Color(0xFF2A2A2A);
  static const Color _sepia = Color(0xFF4A3C2A);
  static const Color _bg = InkWashBackground.parchment;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    _drawDistantMountains(canvas, w, h);
    _drawMistBands(canvas, w, h);
    _drawMidMountains(canvas, w, h);
    _drawPlumBranch(canvas, w, h);
    _drawPlumBlossoms(canvas, w, h);
    _drawMoonCrescent(canvas, w, h);
    _drawScatteredPetals(canvas, w, h);
    _drawInkSplatters(canvas, w, h);
  }

  // ── Distant mountains (light, misty, layered) ──────────────────────────

  void _drawDistantMountains(Canvas canvas, double w, double h) {
    // Layer 1 — furthest, very faint
    _drawMountainLayer(
      canvas, w, h,
      baseY: 0.38,
      peaks: [
        (0.00, 0.34), (0.04, 0.30), (0.08, 0.32),
        (0.13, 0.26), (0.16, 0.28), (0.19, 0.24),
        (0.23, 0.27), (0.26, 0.22), (0.30, 0.25),
        (0.35, 0.20), (0.38, 0.23), (0.40, 0.21),
        (0.44, 0.25), (0.48, 0.19), (0.52, 0.22),
        (0.55, 0.24), (0.58, 0.20), (0.62, 0.23),
        (0.66, 0.18), (0.70, 0.22), (0.74, 0.20),
        (0.78, 0.24), (0.82, 0.21), (0.86, 0.25),
        (0.90, 0.22), (0.94, 0.26), (0.97, 0.28),
        (1.00, 0.32),
      ],
      alpha: 0.07,
    );

    // Layer 2 — slightly closer
    _drawMountainLayer(
      canvas, w, h,
      baseY: 0.42,
      peaks: [
        (0.00, 0.38), (0.05, 0.34), (0.10, 0.36),
        (0.15, 0.30), (0.18, 0.33), (0.22, 0.28),
        (0.27, 0.32), (0.32, 0.26), (0.36, 0.30),
        (0.40, 0.28), (0.44, 0.32), (0.48, 0.27),
        (0.53, 0.30), (0.58, 0.26), (0.62, 0.29),
        (0.67, 0.24), (0.72, 0.28), (0.76, 0.26),
        (0.80, 0.30), (0.85, 0.27), (0.90, 0.32),
        (0.95, 0.30), (1.00, 0.34),
      ],
      alpha: 0.10,
    );
  }

  void _drawMountainLayer(
    Canvas canvas, double w, double h, {
    required double baseY,
    required List<(double, double)> peaks,
    required double alpha,
  }) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = _ink.withValues(alpha: alpha);

    final path = Path()..moveTo(0, h * baseY);

    for (var i = 0; i < peaks.length; i++) {
      final (px, py) = peaks[i];
      if (i == 0) {
        path.lineTo(w * px, h * py);
      } else {
        // Use short segments with slight cubic control for rocky feel
        final (prevX, prevY) = peaks[i - 1];
        final midX = (prevX + px) / 2;
        // Offset control points slightly for jagged rocky edges
        final cpY1 = (prevY + py) / 2 - 0.008;
        final cpY2 = (prevY + py) / 2 + 0.005;
        path.cubicTo(
          w * midX, h * cpY1,
          w * midX, h * cpY2,
          w * px, h * py,
        );
      }
    }

    path.lineTo(w, h * baseY);
    path.lineTo(w, h * (baseY + 0.06));
    path.lineTo(0, h * (baseY + 0.06));
    path.close();

    canvas.drawPath(path, paint);

    // Add a gradient fade at the bottom for mist effect
    final fadePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          _ink.withValues(alpha: alpha * 0.5),
          _ink.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, h * baseY, w, h * 0.06));
    canvas.drawRect(Rect.fromLTWH(0, h * baseY, w, h * 0.06), fadePaint);
  }

  // ── Mist bands ──────────────────────────────────────────────────────────

  void _drawMistBands(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Wide mist band
    paint.shader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        _ink.withValues(alpha: 0.0),
        _ink.withValues(alpha: 0.05),
        _ink.withValues(alpha: 0.08),
        _ink.withValues(alpha: 0.05),
        _ink.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    ).createShader(Rect.fromLTWH(0, h * 0.38, w, h * 0.08));
    canvas.drawRect(Rect.fromLTWH(0, h * 0.38, w, h * 0.08), paint);

    // Lower mist
    paint.shader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        _ink.withValues(alpha: 0.04),
        _ink.withValues(alpha: 0.0),
        _ink.withValues(alpha: 0.06),
        _ink.withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromLTWH(0, h * 0.56, w, h * 0.06));
    canvas.drawRect(Rect.fromLTWH(0, h * 0.56, w, h * 0.06), paint);
    paint.shader = null;
  }

  // ── Mid-ground rocky mountains ──────────────────────────────────────────

  void _drawMidMountains(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // ── Left mountain cluster ──
    paint.color = _ink.withValues(alpha: 0.14);
    final leftMtn = Path()..moveTo(0, h);

    // Rocky left edge going up
    leftMtn.lineTo(0, h * 0.72);
    leftMtn.cubicTo(w * 0.02, h * 0.70, w * 0.03, h * 0.68, w * 0.05, h * 0.66);
    leftMtn.cubicTo(w * 0.06, h * 0.64, w * 0.07, h * 0.65, w * 0.08, h * 0.62);
    leftMtn.cubicTo(w * 0.09, h * 0.59, w * 0.10, h * 0.61, w * 0.12, h * 0.58);
    // Peak area — jagged rocks
    leftMtn.cubicTo(w * 0.13, h * 0.56, w * 0.14, h * 0.57, w * 0.15, h * 0.55);
    leftMtn.cubicTo(w * 0.16, h * 0.53, w * 0.165, h * 0.54, w * 0.17, h * 0.52);
    leftMtn.cubicTo(w * 0.18, h * 0.54, w * 0.19, h * 0.53, w * 0.20, h * 0.55);
    leftMtn.cubicTo(w * 0.21, h * 0.57, w * 0.215, h * 0.56, w * 0.22, h * 0.58);
    // Descend with rocky texture
    leftMtn.cubicTo(w * 0.24, h * 0.62, w * 0.25, h * 0.61, w * 0.26, h * 0.64);
    leftMtn.cubicTo(w * 0.27, h * 0.66, w * 0.28, h * 0.65, w * 0.29, h * 0.68);
    leftMtn.cubicTo(w * 0.31, h * 0.72, w * 0.33, h * 0.75, w * 0.35, h * 0.78);
    leftMtn.cubicTo(w * 0.37, h * 0.82, w * 0.38, h * 0.85, w * 0.40, h * 0.88);
    leftMtn.lineTo(w * 0.40, h);
    leftMtn.close();
    canvas.drawPath(leftMtn, paint);

    // Rock texture strokes on left mountain
    _drawRockTexture(canvas, w, h, leftMtn, 0.05, 0.60, 0.20, 0.75, 0.10);

    // ── Right mountain cluster ──
    paint.color = _ink.withValues(alpha: 0.12);
    final rightMtn = Path()..moveTo(w, h);

    rightMtn.lineTo(w, h * 0.68);
    rightMtn.cubicTo(w * 0.97, h * 0.66, w * 0.96, h * 0.64, w * 0.95, h * 0.62);
    rightMtn.cubicTo(w * 0.94, h * 0.60, w * 0.93, h * 0.61, w * 0.92, h * 0.58);
    rightMtn.cubicTo(w * 0.91, h * 0.56, w * 0.905, h * 0.57, w * 0.90, h * 0.55);
    // Peak
    rightMtn.cubicTo(w * 0.89, h * 0.53, w * 0.885, h * 0.54, w * 0.88, h * 0.52);
    rightMtn.cubicTo(w * 0.875, h * 0.50, w * 0.87, h * 0.51, w * 0.865, h * 0.49);
    rightMtn.cubicTo(w * 0.86, h * 0.51, w * 0.855, h * 0.50, w * 0.85, h * 0.52);
    rightMtn.cubicTo(w * 0.84, h * 0.54, w * 0.83, h * 0.53, w * 0.82, h * 0.55);
    // Descend
    rightMtn.cubicTo(w * 0.80, h * 0.58, w * 0.78, h * 0.60, w * 0.76, h * 0.63);
    rightMtn.cubicTo(w * 0.74, h * 0.66, w * 0.72, h * 0.68, w * 0.70, h * 0.72);
    rightMtn.cubicTo(w * 0.68, h * 0.76, w * 0.66, h * 0.80, w * 0.64, h * 0.84);
    rightMtn.cubicTo(w * 0.62, h * 0.88, w * 0.61, h * 0.92, w * 0.60, h);
    rightMtn.close();
    canvas.drawPath(rightMtn, paint);

    _drawRockTexture(canvas, w, h, rightMtn, 0.80, 0.55, 0.94, 0.72, 0.08);
  }

  /// Draw faint brush-like strokes to simulate rock texture on mountains.
  void _drawRockTexture(
    Canvas canvas, double w, double h, Path clip,
    double x1, double y1, double x2, double y2, double alpha,
  ) {
    canvas.save();
    canvas.clipPath(clip);

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = _ink.withValues(alpha: alpha);

    final rng = math.Random(x1.hashCode ^ y1.hashCode);

    // Vertical-ish brush strokes to simulate rock crevices
    for (var i = 0; i < 15; i++) {
      final sx = w * (x1 + rng.nextDouble() * (x2 - x1));
      final sy = h * (y1 + rng.nextDouble() * (y2 - y1));
      final len = h * (0.02 + rng.nextDouble() * 0.05);
      final drift = w * (rng.nextDouble() * 0.02 - 0.01);

      stroke.strokeWidth = 0.5 + rng.nextDouble() * 1.5;
      stroke.color = _ink.withValues(alpha: alpha * (0.3 + rng.nextDouble() * 0.7));

      final p = Path()
        ..moveTo(sx, sy)
        ..cubicTo(
          sx + drift * 0.3, sy + len * 0.3,
          sx + drift * 0.7, sy + len * 0.6,
          sx + drift, sy + len,
        );
      canvas.drawPath(p, stroke);
    }

    canvas.restore();
  }

  // ── Bottom ink wash (dark, dramatic) ────────────────────────────────────

  void _drawBottomInkWash(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Outermost soft wash
    paint.color = _ink.withValues(alpha: 0.12);
    final outer = Path()
      ..moveTo(0, h)
      ..cubicTo(w * 0.10, h * 0.88, w * 0.25, h * 0.84, w * 0.50, h * 0.86)
      ..cubicTo(w * 0.75, h * 0.84, w * 0.90, h * 0.88, w, h)
      ..close();
    canvas.drawPath(outer, paint);

    // Middle wash
    paint.color = _ink.withValues(alpha: 0.22);
    final mid = Path()
      ..moveTo(w * 0.08, h)
      ..cubicTo(w * 0.15, h * 0.90, w * 0.32, h * 0.87, w * 0.50, h * 0.88)
      ..cubicTo(w * 0.68, h * 0.87, w * 0.85, h * 0.90, w * 0.92, h)
      ..close();
    canvas.drawPath(mid, paint);

    // Darkest centre blob
    paint.color = _ink.withValues(alpha: 0.35);
    final dark = Path()
      ..moveTo(w * 0.20, h)
      ..cubicTo(w * 0.28, h * 0.92, w * 0.40, h * 0.90, w * 0.50, h * 0.91)
      ..cubicTo(w * 0.60, h * 0.90, w * 0.72, h * 0.92, w * 0.80, h)
      ..close();
    canvas.drawPath(dark, paint);

    // Top feather gradient
    paint.shader = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        _ink.withValues(alpha: 0.10),
        _ink.withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromLTWH(0, h * 0.82, w, h * 0.08));
    canvas.drawRect(Rect.fromLTWH(0, h * 0.82, w, h * 0.08), paint);
    paint.shader = null;
  }

  // ── Plum blossom branch (organic, gnarled) ──────────────────────────────

  void _drawPlumBranch(Canvas canvas, double w, double h) {
    // Main branch — enters from top-right, curves organically
    // Draw multiple overlapping strokes for natural brush thickness variation.

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Thick under-stroke (wider, lighter — simulates ink bleed)
    paint.color = _ink.withValues(alpha: 0.15);
    paint.strokeWidth = 7.0;
    final mainBranch = Path()
      ..moveTo(w * 1.02, h * 0.02)
      ..cubicTo(w * 0.92, h * 0.06, w * 0.84, h * 0.10, w * 0.78, h * 0.14)
      ..cubicTo(w * 0.74, h * 0.16, w * 0.70, h * 0.19, w * 0.66, h * 0.17)
      ..cubicTo(w * 0.62, h * 0.15, w * 0.58, h * 0.18, w * 0.55, h * 0.22)
      ..cubicTo(w * 0.52, h * 0.26, w * 0.50, h * 0.30, w * 0.48, h * 0.33);
    canvas.drawPath(mainBranch, paint);

    // Main stroke — darker, thinner
    paint.color = _ink.withValues(alpha: 0.40);
    paint.strokeWidth = 3.5;
    canvas.drawPath(mainBranch, paint);

    // Dark core for woodiness
    paint.color = _ink.withValues(alpha: 0.55);
    paint.strokeWidth = 1.8;
    canvas.drawPath(mainBranch, paint);

    // ── Sub-branches — thinner, organic ──
    void _branch(
      double x1, double y1,
      double cx1, double cy1,
      double cx2, double cy2,
      double x2, double y2,
      double thick,
    ) {
      final p = Path()
        ..moveTo(w * x1, h * y1)
        ..cubicTo(w * cx1, h * cy1, w * cx2, h * cy2, w * x2, h * y2);

      // Under-stroke
      paint.color = _ink.withValues(alpha: 0.12);
      paint.strokeWidth = thick + 3.0;
      canvas.drawPath(p, paint);

      // Main
      paint.color = _ink.withValues(alpha: 0.38);
      paint.strokeWidth = thick;
      canvas.drawPath(p, paint);

      // Core
      paint.color = _ink.withValues(alpha: 0.50);
      paint.strokeWidth = thick * 0.5;
      canvas.drawPath(p, paint);
    }

    // Upper-right sub-branches
    _branch(0.90, 0.07, 0.87, 0.04, 0.84, 0.02, 0.80, 0.01, 2.2);
    _branch(0.84, 0.10, 0.80, 0.06, 0.76, 0.04, 0.72, 0.02, 2.0);
    _branch(0.78, 0.14, 0.82, 0.16, 0.84, 0.20, 0.86, 0.22, 1.8);
    _branch(0.70, 0.18, 0.72, 0.14, 0.75, 0.10, 0.78, 0.08, 1.6);

    // Lower sub-branches
    _branch(0.62, 0.16, 0.58, 0.12, 0.54, 0.10, 0.50, 0.08, 1.8);
    _branch(0.56, 0.21, 0.60, 0.24, 0.62, 0.28, 0.64, 0.30, 1.6);
    _branch(0.52, 0.27, 0.48, 0.24, 0.44, 0.22, 0.40, 0.20, 1.4);
    _branch(0.50, 0.30, 0.54, 0.33, 0.56, 0.36, 0.58, 0.38, 1.4);

    // Tiny twigs
    paint.strokeWidth = 1.0;
    paint.color = _ink.withValues(alpha: 0.30);
    final twigs = <(double, double, double, double)>[
      (0.80, 0.01, 0.78, -0.02),
      (0.72, 0.02, 0.70, -0.01),
      (0.86, 0.22, 0.89, 0.25),
      (0.50, 0.08, 0.48, 0.05),
      (0.64, 0.30, 0.66, 0.33),
      (0.40, 0.20, 0.37, 0.18),
      (0.58, 0.38, 0.60, 0.40),
    ];
    for (final (x1, y1, x2, y2) in twigs) {
      canvas.drawLine(Offset(w * x1, h * y1), Offset(w * x2, h * y2), paint);
    }

    // ── Small bottom-left branch for balance ──
    paint.color = _ink.withValues(alpha: 0.12);
    paint.strokeWidth = 5.0;
    final leftBranch = Path()
      ..moveTo(-w * 0.02, h * 0.55)
      ..cubicTo(w * 0.04, h * 0.52, w * 0.10, h * 0.50, w * 0.16, h * 0.52)
      ..cubicTo(w * 0.20, h * 0.53, w * 0.24, h * 0.50, w * 0.28, h * 0.48);
    canvas.drawPath(leftBranch, paint);

    paint.color = _ink.withValues(alpha: 0.30);
    paint.strokeWidth = 2.5;
    canvas.drawPath(leftBranch, paint);

    paint.color = _ink.withValues(alpha: 0.42);
    paint.strokeWidth = 1.2;
    canvas.drawPath(leftBranch, paint);

    // Sub-branches from left
    _branch(0.10, 0.51, 0.08, 0.48, 0.06, 0.45, 0.04, 0.43, 1.4);
    _branch(0.20, 0.52, 0.22, 0.55, 0.24, 0.58, 0.26, 0.60, 1.2);
    _branch(0.26, 0.49, 0.28, 0.46, 0.30, 0.44, 0.32, 0.42, 1.2);
  }

  // ── Plum blossoms (5-petal flowers at branch tips) ──────────────────────

  void _drawPlumBlossoms(Canvas canvas, double w, double h) {
    final positions = <(double, double, double)>[
      // (x%, y%, size) — positions near branch tips
      // Top-right branch blossoms
      (0.80, 0.01, 7.0),
      (0.78, 0.03, 6.0),
      (0.82, 0.04, 5.5),
      (0.72, 0.02, 6.5),
      (0.74, 0.04, 5.0),
      (0.70, 0.05, 6.0),
      (0.86, 0.22, 6.5),
      (0.88, 0.24, 5.5),
      (0.84, 0.21, 5.0),
      (0.50, 0.08, 6.0),
      (0.48, 0.06, 5.5),
      (0.52, 0.09, 5.0),
      (0.64, 0.30, 5.5),
      (0.66, 0.32, 5.0),
      (0.62, 0.29, 6.0),
      (0.40, 0.20, 5.5),
      (0.38, 0.19, 5.0),
      (0.58, 0.38, 5.5),
      (0.60, 0.40, 5.0),
      (0.56, 0.37, 4.5),
      // Left branch blossoms
      (0.04, 0.43, 5.5),
      (0.06, 0.44, 5.0),
      (0.26, 0.60, 5.5),
      (0.28, 0.59, 5.0),
      (0.24, 0.58, 4.5),
      (0.32, 0.42, 5.5),
      (0.30, 0.43, 5.0),
    ];

    for (final (rx, ry, size) in positions) {
      _drawSingleBlossom(canvas, w * rx, h * ry, size);
    }
  }

  /// Draws a single 5-petal plum blossom flower.
  void _drawSingleBlossom(Canvas canvas, double cx, double cy, double r) {
    final petalPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = _red.withValues(alpha: 0.55);

    final petalStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = _red.withValues(alpha: 0.30);

    // 5 petals arranged in a circle
    for (var i = 0; i < 5; i++) {
      final angle = (i / 5) * math.pi * 2 - math.pi / 2;
      final px = cx + math.cos(angle) * r * 0.55;
      final py = cy + math.sin(angle) * r * 0.55;

      // Each petal is an oval
      canvas.save();
      canvas.translate(px, py);
      canvas.rotate(angle);

      final petalPath = Path()
        ..addOval(Rect.fromCenter(
          center: Offset.zero,
          width: r * 0.75,
          height: r * 0.55,
        ));

      canvas.drawPath(petalPath, petalPaint);
      canvas.drawPath(petalPath, petalStroke);
      canvas.restore();
    }

    // Centre — darker dot with tiny stamens
    final centrePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = _ink.withValues(alpha: 0.50);
    canvas.drawCircle(Offset(cx, cy), r * 0.18, centrePaint);

    // Tiny stamen dots around centre
    final stamenPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = _ink.withValues(alpha: 0.35);
    for (var i = 0; i < 5; i++) {
      final angle = (i / 5) * math.pi * 2;
      final sx = cx + math.cos(angle) * r * 0.28;
      final sy = cy + math.sin(angle) * r * 0.28;
      canvas.drawCircle(Offset(sx, sy), r * 0.06, stamenPaint);
    }
  }

  // ── Moon crescent ────────────────────────────────────────────────────────

  void _drawMoonCrescent(Canvas canvas, double w, double h) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = _ink.withValues(alpha: 0.16);

    final cx = w * 0.40;
    final cy = h * 0.06;
    const r = 22.0;

    canvas.drawCircle(Offset(cx, cy), r, paint);
    paint.color = _bg;
    canvas.drawCircle(Offset(cx + r * 0.50, cy - r * 0.10), r * 0.85, paint);
  }

  // ── Scattered petals (falling red/pink dots) ────────────────────────────

  void _drawScatteredPetals(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Falling petals — small ovals scattered across canvas
    final petals = <(double, double, double, double, double)>[
      // (x%, y%, width, height, rotation)
      (0.35, 0.35, 3.5, 2.0, 0.4),
      (0.42, 0.42, 3.0, 1.8, 1.2),
      (0.55, 0.32, 2.8, 1.6, 2.1),
      (0.62, 0.48, 3.2, 1.8, 0.8),
      (0.28, 0.52, 3.0, 1.6, 1.5),
      (0.75, 0.38, 2.5, 1.5, 2.8),
      (0.45, 0.58, 3.0, 1.8, 0.3),
      (0.68, 0.55, 2.8, 1.6, 1.9),
      (0.32, 0.44, 2.5, 1.5, 2.5),
      (0.58, 0.65, 3.0, 1.6, 0.7),
      (0.22, 0.62, 2.8, 1.5, 1.8),
      (0.80, 0.45, 2.5, 1.4, 2.2),
      (0.48, 0.72, 2.8, 1.6, 0.5),
      (0.15, 0.35, 2.5, 1.5, 1.1),
      (0.70, 0.68, 2.5, 1.4, 2.6),
    ];

    for (final (rx, ry, pw, ph, rot) in petals) {
      paint.color = _red.withValues(alpha: 0.25 + (rx * 0.15));
      canvas.save();
      canvas.translate(w * rx, h * ry);
      canvas.rotate(rot);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: pw, height: ph),
        paint,
      );
      canvas.restore();
    }
  }

  // ── Ink splatters ────────────────────────────────────────────────────────

  void _drawInkSplatters(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;
    final rng = math.Random(42);

    // Small ink splatters
    for (var i = 0; i < 35; i++) {
      final x = rng.nextDouble() * w;
      final y = rng.nextDouble() * h;
      final r = 0.4 + rng.nextDouble() * 1.5;
      paint.color = _ink.withValues(alpha: 0.03 + rng.nextDouble() * 0.06);
      canvas.drawCircle(Offset(x, y), r, paint);
    }

    // Larger splatters near bottom
    for (var i = 0; i < 8; i++) {
      final x = rng.nextDouble() * w;
      final y = h * 0.75 + rng.nextDouble() * h * 0.25;
      final r = 2.0 + rng.nextDouble() * 4.0;
      paint.color = _ink.withValues(alpha: 0.05 + rng.nextDouble() * 0.08);
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(_InkWashPainter old) => false;
}
