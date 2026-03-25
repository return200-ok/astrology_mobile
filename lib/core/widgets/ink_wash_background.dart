import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Shared ink-wash parchment background used across all redesigned screens.
///
/// Renders three layered elements at very low opacity so content always reads
/// first:
///   1. Soft ink-wash blob areas (organic watercolour washes)
///   2. A delicate pine-branch silhouette (top-right quadrant)
///   3. A faint crescent moon accent (top-centre)
///
/// Performance: uses [RepaintBoundary] internally so the static background
/// is composited once and never redrawn during scrolling.
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
          // Static painted layer — composited once.
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
  // Deep muted red at near-invisible opacity for structural hints.
  static const Color _red   = Color(0xFF8B3A3A);
  // Near-black ink for branch / wash areas.
  static const Color _ink   = Color(0xFF1A1A1A);

  @override
  void paint(Canvas canvas, Size size) {
    _drawWashBlobs(canvas, size);
    _drawPineBranch(canvas, size);
    _drawMoonHint(canvas, size);
  }

  // ── 1. Ink-wash blobs ────────────────────────────────────────────────────

  void _drawWashBlobs(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Large bottom-left wash
    paint.color = _ink.withValues(alpha: 0.04);
    final blobPath = Path();
    blobPath.moveTo(size.width * 0.0, size.height * 0.72);
    blobPath.cubicTo(
      size.width * 0.12, size.height * 0.68,
      size.width * 0.22, size.height * 0.80,
      size.width * 0.15, size.height * 0.90,
    );
    blobPath.cubicTo(
      size.width * 0.08, size.height * 1.0,
      size.width * 0.0,  size.height * 0.95,
      size.width * 0.0,  size.height * 0.72,
    );
    canvas.drawPath(blobPath, paint);

    // Medium top-right wash (complements pine branch)
    paint.color = _ink.withValues(alpha: 0.03);
    final blob2 = Path();
    blob2.moveTo(size.width * 0.78, 0);
    blob2.cubicTo(
      size.width * 0.90, size.height * 0.08,
      size.width * 1.0,  size.height * 0.12,
      size.width * 1.0,  0,
    );
    canvas.drawPath(blob2, paint);

    // Small centre-right mid-page wash
    paint.color = _red.withValues(alpha: 0.025);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.82, size.height * 0.55),
        width: size.width * 0.28,
        height: size.height * 0.14,
      ),
      paint,
    );
  }

  // ── 2. Pine branch (top-right) ───────────────────────────────────────────

  void _drawPineBranch(Canvas canvas, Size size) {
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = _ink.withValues(alpha: 0.10);

    // Main curving trunk
    final trunk = Path()
      ..moveTo(size.width * 0.98, 0)
      ..quadraticBezierTo(
        size.width * 0.82, size.height * 0.08,
        size.width * 0.68, size.height * 0.18,
      )
      ..quadraticBezierTo(
        size.width * 0.58, size.height * 0.25,
        size.width * 0.52, size.height * 0.30,
      );
    stroke.strokeWidth = 1.4;
    canvas.drawPath(trunk, stroke);

    // Sub-branches
    final branches = <(double, double, double, double)>[
      (0.90, 0.04,  0.84, 0.10),
      (0.82, 0.09,  0.72, 0.06),
      (0.75, 0.13,  0.68, 0.20),
      (0.68, 0.18,  0.78, 0.22),
      (0.60, 0.23,  0.52, 0.18),
      (0.55, 0.27,  0.62, 0.32),
    ];
    stroke.strokeWidth = 0.9;
    stroke.color = _ink.withValues(alpha: 0.08);
    for (final (x1, y1, x2, y2) in branches) {
      canvas.drawLine(
        Offset(size.width * x1, size.height * y1),
        Offset(size.width * x2, size.height * y2),
        stroke,
      );
    }

    // Needle clusters at branch tips
    final needlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.7
      ..color = _ink.withValues(alpha: 0.07);

    final clusters = <(double, double, double)>[
      (0.84, 0.10, 9),
      (0.72, 0.06, 8),
      (0.78, 0.22, 8),
      (0.52, 0.18, 7),
      (0.62, 0.32, 7),
    ];
    for (final (rx, ry, r) in clusters) {
      final cx = size.width * rx;
      final cy = size.height * ry;
      for (var i = 0; i < 8; i++) {
        final angle = (i / 8) * math.pi * 2;
        canvas.drawLine(
          Offset(cx, cy),
          Offset(cx + math.cos(angle) * r, cy + math.sin(angle) * r),
          needlePaint,
        );
      }
    }
  }

  // ── 3. Moon accent (top-centre, very faint) ──────────────────────────────

  void _drawMoonHint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = _ink.withValues(alpha: 0.045);

    final cx = size.width * 0.50;
    final cy = size.height * 0.03;
    const r = 18.0;

    // Full circle
    canvas.drawCircle(Offset(cx, cy), r, paint);
    // Overlay to carve crescent
    paint.color = InkWashBackground.parchment;
    canvas.drawCircle(Offset(cx + r * 0.55, cy), r * 0.88, paint);
  }

  @override
  bool shouldRepaint(_InkWashPainter old) => false;
}
