import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

import '../../domain/models/imperial_cast_request.dart';

// ─── Palette (Ink Wash / Parchment) ──────────────────────────────────────────
abstract final class _P {
  static const ink   = Color(0xFF1A1A1A);
  static const mid   = Color(0xFF5C5C5C);
  static const light = Color(0xFF8A8A8A);
  static const red   = Color(0xFF8B3A3A);
  static const card  = Color(0xFFFBF8F3);
  static const sheet = Color(0xFFF2EDE4);
}

// ─── Hour range map ───────────────────────────────────────────────────────────
const Map<String, String> _kHourRanges = {
  'Tý': '23H-1H',
  'Sửu': '1H-3H',
  'Dần': '3H-5H',
  'Mão': '5H-7H',
  'Thìn': '7H-9H',
  'Tỵ': '9H-11H',
  'Ngọ': '11H-13H',
  'Mùi': '13H-15H',
  'Thân': '15H-17H',
  'Dậu': '17H-19H',
  'Tuất': '19H-21H',
  'Hợi': '21H-23H',
};

// ─── Palace data model ────────────────────────────────────────────────────────
class _PalaceData {
  const _PalaceData({
    required this.row,
    required this.col,
    required this.name,
    required this.mainStars,
    required this.minorStars,
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.element,
  });

  final int row;
  final int col;
  final String name;
  final List<String> mainStars;
  final List<String> minorStars;
  final String topLeft;
  final String topRight;
  final String bottomLeft;
  final String element;
}

// ─── Palace dataset ───────────────────────────────────────────────────────────
const List<_PalaceData> _kPalaces = [
  _PalaceData(
    row: 0, col: 0, name: 'MỆNH',
    mainStars: ['TỬ VI', 'THIÊN PHỦ'],
    minorStars: ['HỒNG LOAN', 'HỈ THẦN', 'LỘC TỒN'],
    topLeft: '乙', topRight: '子', bottomLeft: '丁', element: '水',
  ),
  _PalaceData(
    row: 0, col: 1, name: 'PHỤ MẪU',
    mainStars: ['LIÊM TRINH'],
    minorStars: ['VĂN XƯƠNG', 'HOA CÁI', 'THIÊN PHÚ'],
    topLeft: '丁', topRight: '辰', bottomLeft: '甲', element: '木',
  ),
  _PalaceData(
    row: 0, col: 2, name: 'PHÚC ĐỨC',
    mainStars: ['THÁI ÂM', 'VŨ KHÚC'],
    minorStars: ['THIÊN VIỆT', 'THIÊN SỨ'],
    topLeft: '庚', topRight: '子', bottomLeft: '丁', element: '金',
  ),
  _PalaceData(
    row: 1, col: 0, name: 'TÀI BẠCH',
    mainStars: ['THIÊN LƯƠNG'],
    minorStars: ['HỒNG LOAN', 'PHI THẦN', 'LỘC TỒN'],
    topLeft: '乙', topRight: '未', bottomLeft: '丁', element: '水',
  ),
  _PalaceData(
    row: 1, col: 2, name: 'ĐIỀN TRẠCH',
    mainStars: ['THIÊN CƠ'],
    minorStars: ['LONG TRÌ', 'PHƯỢNG CÁC'],
    topLeft: '辛', topRight: '丑', bottomLeft: '丁', element: '金',
  ),
  _PalaceData(
    row: 2, col: 0, name: 'THIÊN DI',
    mainStars: ['THAM LANG'],
    minorStars: ['ĐÀ LA', 'LINH TINH'],
    topLeft: '甲', topRight: 'Tuất', bottomLeft: '乙', element: '土',
  ),
  _PalaceData(
    row: 2, col: 1, name: 'NÔ BỘC',
    mainStars: ['CỰ MÔN'],
    minorStars: ['KHÔ', 'HƯ', 'TANG MÔN'],
    topLeft: '甲', topRight: 'Thân', bottomLeft: '丙', element: '中',
  ),
  _PalaceData(
    row: 2, col: 2, name: 'QUAN LỘC',
    mainStars: ['THẤT SÁT', 'PHÁ QUÂN'],
    minorStars: ['QUỐC ẤN', 'TAM THAI'],
    topLeft: '辛', topRight: '午', bottomLeft: '丙', element: '水',
  ),
];

// ─── Main page ────────────────────────────────────────────────────────────────
class ImperialResultPage extends StatelessWidget {
  const ImperialResultPage({super.key, required this.request});

  final ImperialCastRequest request;

  @override
  Widget build(BuildContext context) {
    final hourRange = _kHourRanges[request.streamHour] ?? '';
    final dateStr = DateFormat('dd/MM/yyyy').format(request.arrivalDay);

    return Scaffold(
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Back button ───────────────────────────────────────
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: _P.ink,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // ── Seal emblem ───────────────────────────────────────
                Center(
                  child: SizedBox(
                    width: 96,
                    height: 96,
                    child: CustomPaint(
                      painter: _SealPainter(),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Title ─────────────────────────────────────────────
                Text(
                  'Imperial Chart',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _P.ink,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.6,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Eastern Celestial Mapping',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: _P.mid,
                    fontSize: 13,
                    letterSpacing: 0.3,
                  ),
                ),

                const SizedBox(height: 16),

                // ── Red divider ─────────────────────────────────────
                Center(
                  child: Container(
                    width: 80,
                    height: 1,
                    color: _P.red.withValues(alpha: 0.55),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Identity info lines ─────────────────────────────
                _InfoLine(label: 'IDENTITY', value: request.spiritId),
                const SizedBox(height: 4),
                _InfoLine(label: 'DATE', value: dateStr),
                const SizedBox(height: 4),
                _InfoLine(
                  label: 'HOUR',
                  value: '${request.streamHour} ($hourRange)',
                ),

                const SizedBox(height: 20),

                // ── 3×3 palace chart board ──────────────────────────
                const _PalaceBoard(),

                const SizedBox(height: 28),

                // ── Elements row ────────────────────────────────────
                const _ElementsRow(),

                const SizedBox(height: 28),

                // ── Detailed Analysis button ────────────────────────
                const _DetailedAnalysisButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Info line ────────────────────────────────────────────────────────────────
class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$label: $value',
        textAlign: TextAlign.center,
        style: GoogleFonts.cinzel(
          color: _P.ink,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.6,
        ),
      ),
    );
  }
}

// ─── Palace board (3×3) ───────────────────────────────────────────────────────
class _PalaceBoard extends StatelessWidget {
  const _PalaceBoard();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: _P.card,
          border: Border.all(
            color: _P.red.withValues(alpha: 0.45),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const border = 1.5;
            final cw = (constraints.maxWidth - border * 2) / 3;
            final ch = (constraints.maxHeight - border * 2) / 3;

            return Stack(
              children: [
                // 8 palace cells
                ..._kPalaces.map(
                  (p) => Positioned(
                    left: p.col * (cw + border / 1.5),
                    top: p.row * (ch + border / 1.5),
                    width: cw,
                    height: ch,
                    child: _PalaceCell(data: p),
                  ),
                ),

                // Center constellation cell (row=1, col=1)
                Positioned(
                  left: 1 * (cw + border / 1.5),
                  top: 1 * (ch + border / 1.5),
                  width: cw,
                  height: ch,
                  child: const _ConstellationCell(),
                ),

                // Grid border lines (horizontal)
                for (int i = 1; i < 3; i++)
                  Positioned(
                    left: 0,
                    top: i * (ch + border / 1.5) - border / 2,
                    right: 0,
                    height: border,
                    child: Container(
                      color: _P.red.withValues(alpha: 0.35),
                    ),
                  ),

                // Grid border lines (vertical)
                for (int i = 1; i < 3; i++)
                  Positioned(
                    left: i * (cw + border / 1.5) - border / 2,
                    top: 0,
                    width: border,
                    bottom: 0,
                    child: Container(
                      color: _P.red.withValues(alpha: 0.35),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─── Palace cell ──────────────────────────────────────────────────────────────
class _PalaceCell extends StatelessWidget {
  const _PalaceCell({required this.data});

  final _PalaceData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: _P.card,
      child: Stack(
        children: [
          // Top-left Chinese char
          Positioned(
            top: 2,
            left: 2,
            child: Text(
              data.topLeft,
              style: GoogleFonts.cinzel(
                color: _P.light,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Top-right Chinese char
          Positioned(
            top: 2,
            right: 2,
            child: Text(
              data.topRight,
              style: GoogleFonts.cinzel(
                color: _P.light,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Bottom-left Chinese char
          Positioned(
            bottom: 14,
            left: 2,
            child: Text(
              data.bottomLeft,
              style: GoogleFonts.cinzel(
                color: _P.light,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Bottom-right element char
          Positioned(
            bottom: 2,
            right: 2,
            child: Text(
              data.element,
              style: GoogleFonts.cinzel(
                color: _P.red.withValues(alpha: 0.70),
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Palace label
                Text(
                  data.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _P.mid,
                    fontSize: 7,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),

                // Main stars
                ...data.mainStars.map(
                  (s) => Text(
                    s,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzel(
                      color: _P.red,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                ),

                const SizedBox(height: 3),

                // Minor stars
                ...data.minorStars.map(
                  (s) => Text(
                    s,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: _P.mid,
                      fontSize: 6,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Constellation center cell ────────────────────────────────────────────────
class _ConstellationCell extends StatelessWidget {
  const _ConstellationCell();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _P.sheet,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Star label top
          Positioned(
            top: 6,
            left: 0,
            right: 0,
            child: Text(
              '\u2605 constellation \u2605',
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                color: _P.light,
                fontSize: 6,
                letterSpacing: 0.8,
              ),
            ),
          ),

          // Constellation drawing
          CustomPaint(
            size: const Size(80, 80),
            painter: _ConstellationPainter(),
          ),
        ],
      ),
    );
  }
}

// ─── Elements row ─────────────────────────────────────────────────────────────
class _ElementsRow extends StatelessWidget {
  const _ElementsRow();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ['火', '土', '\u2726', '成', '金'].map((ch) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                ch,
                style: GoogleFonts.cinzel(
                  color: _P.red,
                  fontSize: 32,
                  letterSpacing: 8,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Text(
          'PENTALITY ELEMENTS: METAL (Major), EARTH (Minor)',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: _P.mid,
            fontSize: 11,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

// ─── Detailed Analysis button ─────────────────────────────────────────────────
class _DetailedAnalysisButton extends StatelessWidget {
  const _DetailedAnalysisButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: _P.red,
        side: BorderSide(color: _P.red.withValues(alpha: 0.65), width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      icon: Icon(Icons.auto_awesome_rounded,
          size: 18, color: _P.red.withValues(alpha: 0.80)),
      label: Text(
        'DETAILED ANALYSIS',
        style: GoogleFonts.cinzel(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 3.0,
        ),
      ),
    );
  }
}

// ─── Seal painter ─────────────────────────────────────────────────────────────
class _SealPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(size.width, size.height) / 2 - 2;

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = _P.red.withValues(alpha: 0.65);

    final thinPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..color = _P.red.withValues(alpha: 0.45);

    // Outer circle
    canvas.drawCircle(Offset(cx, cy), r, strokePaint);

    // Inner ring
    canvas.drawCircle(Offset(cx, cy), r * 0.75, thinPaint);

    // 8 radial lines between rings
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4);
      final x1 = cx + r * 0.75 * math.cos(angle);
      final y1 = cy + r * 0.75 * math.sin(angle);
      final x2 = cx + r * math.cos(angle);
      final y2 = cy + r * math.sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), thinPaint);
    }

    // Small dots on inner ring
    final dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = _P.red.withValues(alpha: 0.55);

    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) + math.pi / 8;
      final dx = cx + r * 0.875 * math.cos(angle);
      final dy = cy + r * 0.875 * math.sin(angle);
      canvas.drawCircle(Offset(dx, dy), 2.5, dotPaint);
    }

    // Yin-yang S-curve (simplified)
    final sCurve = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _P.red.withValues(alpha: 0.55);

    final path = Path();
    path.moveTo(cx, cy - r * 0.50);
    path.cubicTo(
      cx + r * 0.30, cy - r * 0.50,
      cx + r * 0.30, cy,
      cx, cy,
    );
    path.cubicTo(
      cx - r * 0.30, cy,
      cx - r * 0.30, cy + r * 0.50,
      cx, cy + r * 0.50,
    );
    canvas.drawPath(path, sCurve);

    // Center dot
    canvas.drawCircle(Offset(cx, cy), 3.5, dotPaint);

    // Outer dots (8 positions)
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) - math.pi / 2;
      final dx = cx + r * 0.55 * math.cos(angle);
      final dy = cy + r * 0.55 * math.sin(angle);
      canvas.drawCircle(
        Offset(dx, dy),
        1.8,
        Paint()
          ..color = _P.red.withValues(alpha: 0.40)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Constellation painter ────────────────────────────────────────────────────
class _ConstellationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Star positions (normalized offsets from center)
    final starOffsets = <Offset>[
      Offset(cx - 28, cy - 22),
      Offset(cx - 10, cy - 30),
      Offset(cx + 14, cy - 26),
      Offset(cx + 28, cy - 10),
      Offset(cx + 24, cy + 16),
      Offset(cx + 6, cy + 28),
      Offset(cx - 18, cy + 24),
      Offset(cx - 30, cy + 6),
      Offset(cx - 8, cy + 4),
      Offset(cx + 10, cy - 6),
    ];

    // Connection lines (faint)
    final linePaint = Paint()
      ..color = _P.red.withValues(alpha: 0.20)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final connections = <List<int>>[
      [0, 1], [1, 2], [2, 3], [3, 4], [4, 5],
      [5, 6], [6, 7], [7, 0], [8, 9], [1, 8],
      [3, 9], [8, 6],
    ];

    for (final conn in connections) {
      canvas.drawLine(starOffsets[conn[0]], starOffsets[conn[1]], linePaint);
    }

    // Star dots
    for (int i = 0; i < starOffsets.length; i++) {
      final pos = starOffsets[i];
      final isMain = i < 8;
      final radius = isMain ? 2.8 : 2.0;

      // Subtle halo
      canvas.drawCircle(
        pos,
        radius * 2.5,
        Paint()
          ..color = _P.red.withValues(alpha: 0.08)
          ..style = PaintingStyle.fill,
      );

      // Core dot
      canvas.drawCircle(
        pos,
        radius,
        Paint()
          ..color = _P.red.withValues(alpha: 0.65)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
