import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:astroweb_mobile/core/widgets/astro_page_scaffold.dart';
import 'package:astroweb_mobile/core/widgets/astro_button.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';

import '../../domain/models/imperial_cast_request.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

// ─── Hour range map ─────────────────────────────────────────────────────────
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

// ─── Palace data model ──────────────────────────────────────────────────────
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

// ─── Palace dataset ─────────────────────────────────────────────────────────
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

// ─── Main page ──────────────────────────────────────────────────────────────
class ImperialResultPage extends StatelessWidget {
  const ImperialResultPage({super.key, required this.request});

  final ImperialCastRequest request;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hourRange = _kHourRanges[request.streamHour] ?? '';
    final dateStr = DateFormat('dd/MM/yyyy').format(request.arrivalDay);

    return AstroPageScaffold(
      horizontalPadding: 16,
      topPadding: 8,
      body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // ── Seal emblem ─────────────────────────────────────────
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

                // ── Title ───────────────────────────────────────────────
                Text(
                  l10n.imperialResultTitle,
                  textAlign: TextAlign.center,
                  style: AstroText.resultLabel(size: 22),
                ),

                const SizedBox(height: 6),

                Text(
                  l10n.imperialResultSubtitle,
                  textAlign: TextAlign.center,
                  style: AstroText.pageSubtitle(size: 13),
                ),

                const SizedBox(height: 16),

                // ── Identity info lines ─────────────────────────────────
                _InfoLine(label: l10n.imperialResultIdentity, value: request.spiritId),
                const SizedBox(height: 4),
                _InfoLine(label: l10n.imperialResultDate, value: dateStr),
                const SizedBox(height: 4),
                _InfoLine(
                  label: l10n.imperialResultHour,
                  value: '${request.streamHour} ($hourRange)',
                ),

                const SizedBox(height: 20),

                // ── 3×3 palace chart board ──────────────────────────────
                const _PalaceBoard(),

                const SizedBox(height: 28),

                // ── Elements row ────────────────────────────────────────
                _ElementsRow(),

                const SizedBox(height: 28),

                // ── Detailed Analysis button ────────────────────────────
                AstroButton.filled(
                  label: 'DETAILED ANALYSIS',
                  onTap: () {},
                  fontSize: 16,
                ),
              ],
            ),
    );
  }
}

// ─── Info line ──────────────────────────────────────────────────────────────
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
        style: AstroText.resultLabel(size: 13).copyWith(color: AstroColors.gold),
      ),
    );
  }
}

// ─── Palace board (3×3) ─────────────────────────────────────────────────────
class _PalaceBoard extends StatelessWidget {
  const _PalaceBoard();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: AstroColors.board,
          border: Border.all(
            color: AstroColors.red.withValues(alpha: 0.4),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
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
                      color: AstroColors.red.withValues(alpha: 0.3),
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
                      color: AstroColors.red.withValues(alpha: 0.3),
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

// ─── Palace cell ────────────────────────────────────────────────────────────
class _PalaceCell extends StatelessWidget {
  const _PalaceCell({required this.data});

  final _PalaceData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AstroColors.cardAlt,
      ),
      child: Stack(
        children: [
          // Top-left Chinese char
          Positioned(
            top: 2,
            left: 2,
            child: Text(
              data.topLeft,
              style: AstroText.hanzi(size: 9),
            ),
          ),

          // Top-right Chinese char
          Positioned(
            top: 2,
            right: 2,
            child: Text(
              data.topRight,
              style: AstroText.hanzi(size: 9),
            ),
          ),

          // Bottom-left Chinese char
          Positioned(
            bottom: 14,
            left: 2,
            child: Text(
              data.bottomLeft,
              style: AstroText.hanzi(size: 9),
            ),
          ),

          // Bottom-right element char
          Positioned(
            bottom: 2,
            right: 2,
            child: Text(
              data.element,
              style: AstroText.resultLabel(size: 9).copyWith(color: AstroColors.red.withValues(alpha: 0.6)),
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
                  style: AstroText.micro(size: 7, spacing: 0.5),
                ),
                const SizedBox(height: 2),

                // Main stars
                ...data.mainStars.map(
                  (s) => Text(
                    s,
                    textAlign: TextAlign.center,
                    style: AstroText.resultLabel(size: 8).copyWith(height: 1.3),
                  ),
                ),

                const SizedBox(height: 3),

                // Minor stars
                ...data.minorStars.map(
                  (s) => Text(
                    s,
                    textAlign: TextAlign.center,
                    style: AstroText.caption(size: 6).copyWith(height: 1.3),
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

// ─── Constellation center cell ──────────────────────────────────────────────
class _ConstellationCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AstroColors.cardAlt,
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
              style: AstroText.micro(size: 6, spacing: 0.8),
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

// ─── Elements row ───────────────────────────────────────────────────────────
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
                style: AstroText.resultLabel(size: 32).copyWith(letterSpacing: 8),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Text(
          'PENTALITY ELEMENTS: METAL (Major), EARTH (Minor)',
          textAlign: TextAlign.center,
          style: AstroText.caption(size: 11).copyWith(color: AstroColors.gold),
        ),
      ],
    );
  }
}

// ─── Seal painter ───────────────────────────────────────────────────────────
class _SealPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(size.width, size.height) / 2 - 2;

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = AstroColors.red.withValues(alpha: 0.7);

    final thinPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..color = AstroColors.red.withValues(alpha: 0.5);

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
      ..color = AstroColors.red.withValues(alpha: 0.6);

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
      ..color = AstroColors.red.withValues(alpha: 0.65);

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
        dotPaint..color = AstroColors.red.withValues(alpha: 0.4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Constellation painter ──────────────────────────────────────────────────
class _ConstellationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

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

    // Connection lines
    final linePaint = Paint()
      ..color = AstroColors.gold.withValues(alpha: 0.3)
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

      // Glow
      canvas.drawCircle(
        pos,
        radius * 2.5,
        Paint()
          ..color = AstroColors.gold.withValues(alpha: 0.15)
          ..style = PaintingStyle.fill,
      );

      // Core dot
      canvas.drawCircle(
        pos,
        radius,
        Paint()
          ..color = AstroColors.red.withValues(alpha: 0.75)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

