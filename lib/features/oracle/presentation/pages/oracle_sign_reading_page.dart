import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

import '../../domain/models/oracle_sign.dart';

// ─── Palette ─────────────────────────────────────────────────────────────────
abstract final class _P {
  static const ink     = Color(0xFF1A1A1A);
  static const mid     = Color(0xFF5C5C5C);
  static const light   = Color(0xFF8A8A8A);
  static const red     = Color(0xFF8B3A3A);
  static const card    = Color(0xFFFBF8F3);
  static const border  = Color(0xFFCDC5B8);
  static const iconBg  = Color(0xFFEAE3D8);
  static const divider = Color(0xFFD8D0C6);
}

class OracleSignReadingPage extends StatelessWidget {
  const OracleSignReadingPage({super.key, required this.sign});

  final OracleSign sign;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 36),
            child: Column(
              children: [
                _buildHeader(context, l10n),
                const SizedBox(height: 16),
                _buildMainCard(context, l10n),
                const SizedBox(height: 14),
                _buildSoulPanel(context, l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Header: back arrow + centred symbol bubble ───────────────────────────

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            color: _P.ink,
            tooltip: l10n.backTooltip,
          ),
          const Spacer(),
          // Zodiac symbol — red accent on warm square
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: _P.iconBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _P.border, width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              sign.symbol,
              style: TextStyle(
                color: _P.red.withValues(alpha: 0.85),
                fontSize: 26,
                height: 1,
              ),
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48), // balances back button
        ],
      ),
    );
  }

  // ── Main oracle card ─────────────────────────────────────────────────────

  Widget _buildMainCard(BuildContext context, AppLocalizations l10n) {
    final w = MediaQuery.sizeOf(context).width;
    final titleSize    = w < 430 ? 34.0 : 40.0;
    final guidanceSize = w < 430 ? 16.0 : 19.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _P.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _P.border, width: 0.8),
      ),
      // Clip the pine-branch decor to the card's rounded corners.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Pine branch — top-right decorative layer
            const Positioned(
              top: 0,
              right: 0,
              child: _PineBranchDecor(),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 30),
              child: Column(
                children: [
                  // Sign name
                  Text(
                    _titleCase(ZodiacLocalization.name(context, sign.id)),
                    style: GoogleFonts.cinzel(
                      color: _P.ink,
                      fontSize: titleSize,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.0,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Red divider line
                  Container(
                    width: 80,
                    height: 1,
                    color: _P.red.withValues(alpha: 0.55),
                  ),
                  const SizedBox(height: 28),

                  // Guidance text — Inter italic, near-black
                  Text(
                    '"${sign.guidance}"',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: _P.ink,
                      fontSize: guidanceSize,
                      height: 1.65,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Reset Stars button
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _P.red,
                      side: BorderSide(
                        color: _P.red.withValues(alpha: 0.65),
                        width: 1,
                      ),
                      backgroundColor: _P.card,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 13,
                      ),
                    ),
                    icon: Icon(Icons.refresh_rounded,
                        size: 17, color: _P.red.withValues(alpha: 0.80)),
                    label: Text(
                      l10n.oracleResetStars,
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Soul insight panel ───────────────────────────────────────────────────

  Widget _buildSoulPanel(BuildContext context, AppLocalizations l10n) {
    final sections = [
      (l10n.oracleEssence,       sign.essence),
      (l10n.oracleSpiritualFlow, sign.spiritualFlow),
      (l10n.oracleDrawnTo,       sign.drawnTo),
      (l10n.oracleRadiatesTo,    sign.radiatesTo),
      (l10n.oracleDharmaPath,    sign.dharmaPath),
      (l10n.oracleSacredNeeds,   sign.sacredNeeds),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _P.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _P.border, width: 0.8),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Panel header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                child: Text(
                  l10n.oracleSoulPanelHeader,
                  style: GoogleFonts.cinzel(
                    color: _P.mid,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.0,
                  ),
                ),
              ),

              // Sections
              ...sections.asMap().entries.map((e) => _InsightSection(
                title: e.value.$1,
                items: e.value.$2,
              )),

              const SizedBox(height: 18),
            ],
          ),

          // Chinese seal stamp — purely decorative, low opacity
          Positioned(
            right: 12,
            bottom: 12,
            child: Opacity(
              opacity: 0.65,
              child: _ChineseSeal(),
            ),
          ),
        ],
      ),
    );
  }

  String _titleCase(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1).toLowerCase();
}

// ─── Insight section ─────────────────────────────────────────────────────────

class _InsightSection extends StatelessWidget {
  const _InsightSection({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: _P.divider, thickness: 0.8, height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section label — Cinzel small-caps feel
              Text(
                title.toUpperCase(),
                style: GoogleFonts.cinzel(
                  color: _P.ink,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.8,
                ),
              ),
              const SizedBox(height: 10),
              // Items — Inter italic, mid-grey
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '- $item',
                    style: GoogleFonts.inter(
                      color: _P.mid,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Pine branch decor (top-right corner of main card) ───────────────────────

class _PineBranchDecor extends StatelessWidget {
  const _PineBranchDecor();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(120, 110),
      painter: _PinePainter(),
    );
  }
}

class _PinePainter extends CustomPainter {
  static const _ink = Color(0xFF1A1A1A);

  @override
  void paint(Canvas canvas, Size size) {
    // Main branch — very low opacity
    final branchPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.3
      ..color = _ink.withValues(alpha: 0.09);

    final trunk = Path()
      ..moveTo(size.width, 0)
      ..quadraticBezierTo(
        size.width * 0.62, size.height * 0.28,
        size.width * 0.28, size.height * 0.60,
      );
    canvas.drawPath(trunk, branchPaint);

    // Sub-branches
    branchPaint.strokeWidth = 0.8;
    branchPaint.color = _ink.withValues(alpha: 0.07);
    final subs = <(double, double, double, double)>[
      (0.88, 0.08, 0.76, 0.04),
      (0.76, 0.16, 0.86, 0.24),
      (0.62, 0.28, 0.50, 0.22),
      (0.50, 0.38, 0.60, 0.46),
      (0.38, 0.48, 0.28, 0.42),
    ];
    for (final (x1, y1, x2, y2) in subs) {
      canvas.drawLine(
        Offset(size.width * x1, size.height * y1),
        Offset(size.width * x2, size.height * y2),
        branchPaint,
      );
    }

    // Needle clusters
    final needlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.6
      ..color = _ink.withValues(alpha: 0.06);

    final clusters = [
      (size.width * 0.76, size.height * 0.04, 8.0),
      (size.width * 0.86, size.height * 0.24, 7.0),
      (size.width * 0.50, size.height * 0.22, 7.0),
      (size.width * 0.60, size.height * 0.46, 6.0),
      (size.width * 0.28, size.height * 0.42, 6.0),
    ];
    for (final (cx, cy, r) in clusters) {
      for (var i = 0; i < 8; i++) {
        final angle = i / 8 * 2 * 3.14159;
        canvas.drawLine(
          Offset(cx, cy),
          Offset(cx + r * _cos(angle), cy + r * _sin(angle)),
          needlePaint,
        );
      }
    }
  }

  double _cos(double a) {
    // Simple approximation via dart:math — avoid import duplication.
    return _sin(a + 3.14159 / 2);
  }

  double _sin(double a) {
    // Taylor series sin(a) ≈ a - a³/6 + a⁵/120, sufficient for 0–2π.
    a = a % (2 * 3.14159);
    if (a > 3.14159) a -= 2 * 3.14159;
    final a3 = a * a * a;
    final a5 = a3 * a * a;
    final a7 = a5 * a * a;
    return a - a3 / 6 + a5 / 120 - a7 / 5040;
  }

  @override
  bool shouldRepaint(_PinePainter old) => false;
}

// ─── Chinese seal stamp ───────────────────────────────────────────────────────

class _ChineseSeal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: _P.red,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        '禮',
        style: GoogleFonts.inter(
          color: const Color(0xFFFBF8F3),
          fontSize: 20,
          fontWeight: FontWeight.w300,
          height: 1,
        ),
      ),
    );
  }
}
