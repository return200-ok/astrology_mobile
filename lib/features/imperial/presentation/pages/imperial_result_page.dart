import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/models/imperial_cast_request.dart';
import '../widgets/imperial_starfield_background.dart';

// ─── Color constants ──────────────────────────────────────────────────────────
const Color _kGold = Color(0xFFD4AF37);
const Color _kGoldBright = Color(0xFFEDD060);
const Color _kCell = Color(0xFF0C1128);
const Color _kBoard = Color(0xFF060C1E);
const Color _kBorderColor = Color(0xFFD4AF37);
const Color _kCloud = Color(0xFF2B2870);

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
      backgroundColor: const Color(0xFF040A18),
      body: ImperialStarfieldBackground(
        child: Stack(
          children: [
            // Cloud decoration layer
            const Positioned.fill(child: _CloudDecoration()),

            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Back button ───────────────────────────────────────
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(
                          Icons.chevron_left_rounded,
                          size: 32,
                          color: Colors.white60,
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
                      'IMPERIAL CELESTIAL CODEX',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        color: _kGold,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            color: _kGold.withOpacity(0.50),
                            blurRadius: 18,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Eastern Celestial Mapping',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        color: _kGold.withOpacity(0.75),
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2.5,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Identity info lines ───────────────────────────────
                    _InfoLine(label: 'IDENTITY', value: request.spiritId),
                    const SizedBox(height: 4),
                    _InfoLine(label: 'DATE', value: dateStr),
                    const SizedBox(height: 4),
                    _InfoLine(
                      label: 'HOUR',
                      value: '${request.streamHour} ($hourRange)',
                    ),

                    const SizedBox(height: 20),

                    // ── 3×3 palace chart board ────────────────────────────
                    const _PalaceBoard(),

                    const SizedBox(height: 28),

                    // ── Elements row ──────────────────────────────────────
                    _ElementsRow(),

                    const SizedBox(height: 28),

                    // ── Detailed Analysis button ──────────────────────────
                    _DetailedAnalysisButton(),
                  ],
                ),
              ),
            ),
          ],
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
          color: _kGold,
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
          color: _kBoard,
          border: Border.all(
            color: _kBorderColor.withOpacity(0.55),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _kGold.withOpacity(0.18),
              blurRadius: 24,
              spreadRadius: 2,
            ),
          ],
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
                  child: _ConstellationCell(),
                ),

                // Grid border lines (horizontal)
                for (int i = 1; i < 3; i++)
                  Positioned(
                    left: 0,
                    top: i * (ch + border / 1.5) - border / 2,
                    right: 0,
                    height: border,
                    child: Container(
                      color: _kBorderColor.withOpacity(0.55),
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
                      color: _kBorderColor.withOpacity(0.55),
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
      decoration: BoxDecoration(
        color: _kCell,
      ),
      child: Stack(
        children: [
          // Top-left Chinese char
          Positioned(
            top: 2,
            left: 2,
            child: Text(
              data.topLeft,
              style: GoogleFonts.cinzel(
                color: _kGold.withOpacity(0.70),
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
                color: _kGold.withOpacity(0.70),
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
                color: _kGold.withOpacity(0.70),
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
                color: _kGold.withOpacity(0.60),
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
                    color: _kGold.withOpacity(0.70),
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
                      color: _kGoldBright,
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
                      color: Colors.white60,
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCell.withOpacity(0.85),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Star label top
          Positioned(
            top: 6,
            left: 0,
            right: 0,
            child: Text(
              '★ constellation ★',
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                color: _kGold.withOpacity(0.55),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ['火', '土', '✦', '成', '金'].map((ch) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                ch,
                style: GoogleFonts.cinzel(
                  color: _kGold,
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
            color: _kGold.withOpacity(0.65),
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
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(999),
        splashColor: Colors.white.withOpacity(0.12),
        child: Ink(
          height: 62,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFA8832A),
                Color(0xFFD4AF37),
                Color(0xFFEDD060),
                Color(0xFFD4AF37),
                Color(0xFF8E6E1A),
              ],
              stops: [0.0, 0.25, 0.50, 0.75, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: _kGold.withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Bagua watermark
              CustomPaint(
                size: const Size(52, 52),
                painter: _BaguaPainter(),
              ),
              // Label
              Text(
                'DETAILED ANALYSIS',
                style: GoogleFonts.cinzel(
                  color: const Color(0xFF2A1E06),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3.0,
                ),
              ),
            ],
          ),
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
      ..color = _kGold.withOpacity(0.85);

    final thinPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..color = _kGold.withOpacity(0.70);

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
      ..color = _kGold.withOpacity(0.75);

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
      ..color = _kGold.withOpacity(0.80);

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
        dotPaint..color = _kGold.withOpacity(0.55),
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
      ..color = _kGold.withOpacity(0.20)
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

    // Star dots with glow
    for (int i = 0; i < starOffsets.length; i++) {
      final pos = starOffsets[i];
      final isMain = i < 8;
      final radius = isMain ? 2.8 : 2.0;

      // Glow
      canvas.drawCircle(
        pos,
        radius * 2.5,
        Paint()
          ..color = _kGoldBright.withOpacity(0.15)
          ..style = PaintingStyle.fill,
      );

      // Core dot
      canvas.drawCircle(
        pos,
        radius,
        Paint()
          ..color = _kGoldBright.withOpacity(0.90)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Bagua watermark painter ──────────────────────────────────────────────────
class _BaguaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2A1E06).withOpacity(0.18)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    // Outer circle
    canvas.drawCircle(Offset(cx, cy), r * 0.98, paint);
    // Inner circle
    canvas.drawCircle(Offset(cx, cy), r * 0.52, paint);

    // 8 trigram lines
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) - math.pi / 2;
      for (int line = 0; line < 3; line++) {
        final lineR = r * 0.60 + line * r * 0.11;
        final lineLen = r * 0.14;
        final cosA = math.cos(angle);
        final sinA = math.sin(angle);
        final isBroken = (i + line) % 2 == 1;
        if (isBroken) {
          canvas.drawLine(
            Offset(cx + cosA * lineR - sinA * lineLen * 0.4,
                cy + sinA * lineR + cosA * lineLen * 0.4),
            Offset(cx + cosA * lineR - sinA * lineLen * 0.05,
                cy + sinA * lineR + cosA * lineLen * 0.05),
            paint,
          );
          canvas.drawLine(
            Offset(cx + cosA * lineR + sinA * lineLen * 0.05,
                cy + sinA * lineR - cosA * lineLen * 0.05),
            Offset(cx + cosA * lineR + sinA * lineLen * 0.4,
                cy + sinA * lineR - cosA * lineLen * 0.4),
            paint,
          );
        } else {
          canvas.drawLine(
            Offset(cx + cosA * lineR - sinA * lineLen * 0.4,
                cy + sinA * lineR + cosA * lineLen * 0.4),
            Offset(cx + cosA * lineR + sinA * lineLen * 0.4,
                cy + sinA * lineR - cosA * lineLen * 0.4),
            paint,
          );
        }
      }
    }

    // Yin-yang circle
    canvas.drawCircle(Offset(cx, cy), r * 0.22, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Cloud decoration ──────────────────────────────────────────────────────────
class _CloudDecoration extends StatelessWidget {
  const _CloudDecoration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _CloudPainter());
  }
}

class _CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kCloud.withOpacity(0.55)
      ..style = PaintingStyle.fill;

    // Right side cloud scroll
    _drawCloudScroll(
        canvas, paint, Offset(size.width + 10, size.height * 0.48),
        scale: 1.2);

    // Bottom-right cloud
    _drawCloudScroll(canvas, paint, Offset(size.width - 10, size.height - 20),
        scale: 0.9, flip: true);

    // Bottom-left cloud (partial)
    _drawCloudScroll(canvas, paint, Offset(-20, size.height - 30), scale: 0.75);
  }

  void _drawCloudScroll(Canvas canvas, Paint paint, Offset origin,
      {double scale = 1.0, bool flip = false}) {
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    if (flip) canvas.scale(-1, -1);
    canvas.scale(scale, scale);

    final path = Path();
    path.moveTo(-80, 20);
    path.quadraticBezierTo(-90, -10, -60, -20);
    path.quadraticBezierTo(-50, -40, -20, -35);
    path.quadraticBezierTo(-10, -55, 20, -45);
    path.quadraticBezierTo(50, -55, 55, -30);
    path.quadraticBezierTo(80, -25, 75, 0);
    path.quadraticBezierTo(85, 20, 60, 25);
    path.quadraticBezierTo(40, 30, 20, 22);
    path.quadraticBezierTo(0, 38, -20, 28);
    path.quadraticBezierTo(-40, 42, -60, 30);
    path.quadraticBezierTo(-75, 38, -80, 25);
    path.close();
    canvas.drawPath(path, paint);

    final curlPaint = Paint()
      ..color = _kCloud.withOpacity(0.30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final curl = Path();
    curl.moveTo(-30, 10);
    curl.quadraticBezierTo(-10, -5, 10, 5);
    curl.quadraticBezierTo(30, 15, 20, 30);
    curl.quadraticBezierTo(5, 42, -10, 35);
    canvas.drawPath(curl, curlPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
