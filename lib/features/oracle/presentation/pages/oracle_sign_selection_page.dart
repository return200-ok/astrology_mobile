import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

import '../../domain/models/oracle_sign.dart';
import 'oracle_sign_reading_page.dart';

// ─── Palette (same constants as main.dart / reading page) ───────────────────
abstract final class _P {
  static const ink    = Color(0xFF1A1A1A);
  static const mid    = Color(0xFF5C5C5C);
  static const red    = Color(0xFF8B3A3A);
  static const card   = Color(0xFFFBF8F3);
  static const border = Color(0xFFCDC5B8);
  static const iconBg = Color(0xFFEAE3D8);
}

class OracleSignSelectionPage extends StatelessWidget {
  const OracleSignSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                      ),
                      color: _P.ink,
                      tooltip: l10n.backTooltip,
                    ),
                    // Red-tinted sparkle — single accent icon
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 15,
                      color: _P.red.withValues(alpha: 0.70),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.oracleTitle,
                            style: GoogleFonts.cinzel(
                              color: _P.ink,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.8,
                            ),
                          ),
                          Text(
                            l10n.oracleSelectPrompt,
                            style: GoogleFonts.inter(
                              color: _P.mid,
                              fontSize: 9,
                              letterSpacing: 1.0,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ── 3×4 Sign grid ────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const cols = 3;
                      const rows = 4;
                      const spacing = 9.0;
                      final tileW = (constraints.maxWidth  - spacing * (cols - 1)) / cols;
                      final tileH = (constraints.maxHeight - spacing * (rows - 1)) / rows;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: oracleSigns.map((sign) {
                          return SizedBox(
                            width: tileW,
                            height: tileH,
                            child: _SignTile(
                              sign: sign,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      OracleSignReadingPage(sign: sign),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Sign tile ───────────────────────────────────────────────────────────────

class _SignTile extends StatelessWidget {
  const _SignTile({required this.sign, required this.onTap});

  final OracleSign sign;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _P.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _P.border, width: 0.8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Symbol in warm square
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _P.iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                sign.symbol,
                style: TextStyle(
                  // Muted red for zodiac symbols — the key visual accent
                  color: _P.red.withValues(alpha: 0.85),
                  fontSize: 24,
                  height: 1,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Sign name — Cinzel, near-black
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _titleCase(ZodiacLocalization.name(context, sign.id)),
                  style: GoogleFonts.cinzel(
                    color: _P.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 3),

            // Date range — Inter, mid-grey
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  ZodiacLocalization.range(context, sign.id),
                  style: GoogleFonts.inter(
                    color: _P.mid,
                    fontSize: 9,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _titleCase(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1).toLowerCase();
}
