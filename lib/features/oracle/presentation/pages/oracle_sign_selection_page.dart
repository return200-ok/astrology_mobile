import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

import '../../domain/models/oracle_sign.dart';
import '../widgets/oracle_starfield_background.dart';
import 'oracle_sign_reading_page.dart';

class OracleSignSelectionPage extends StatelessWidget {
  const OracleSignSelectionPage({super.key});

  static const Color _gold = AstroTheme.accentGold;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: OracleStarfieldBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header row ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                      color: Colors.white70,
                      tooltip: l10n.backTooltip,
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _gold.withOpacity(0.12),
                        border: Border.all(color: _gold.withOpacity(0.5), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: _gold.withOpacity(0.40),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: _gold,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.oracleTitle,
                            style: GoogleFonts.cinzel(
                              color: _gold,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              shadows: [
                                Shadow(
                                  color: _gold.withOpacity(0.6),
                                  blurRadius: 14,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            l10n.oracleSelectPrompt,
                            style: GoogleFonts.inter(
                              color: Colors.white38,
                              fontSize: 10,
                              letterSpacing: 1.4,
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

              const SizedBox(height: 10),

              // ── 3×4 Sign grid ────────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const cols = 3;
                      const rows = 4;
                      const spacing = 10.0;
                      final tileW =
                          (constraints.maxWidth - spacing * (cols - 1)) / cols;
                      final tileH =
                          (constraints.maxHeight - spacing * (rows - 1)) / rows;

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

// ─── Sign tile ─────────────────────────────────────────────────────────────

class _SignTile extends StatelessWidget {
  const _SignTile({required this.sign, required this.onTap});

  final OracleSign sign;
  final VoidCallback onTap;

  static const Color _gold = AstroTheme.accentGold;
  static const Color _purple = AstroTheme.glowPurple;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        splashColor: _purple.withOpacity(0.18),
        highlightColor: _purple.withOpacity(0.10),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white.withOpacity(0.06),
            border: Border.all(
              color: _purple.withOpacity(0.35),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _purple.withOpacity(0.12),
                blurRadius: 10,
                spreadRadius: -2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Symbol bubble ──────────────────────────────────────────
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFBC64FF), Color(0xFF7C3AED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9B59FF).withOpacity(0.50),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  sign.symbol,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    height: 1,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ── Sign name ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    ZodiacLocalization.name(context, sign.id),
                    style: GoogleFonts.cinzel(
                      color: _gold,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // ── Date range ─────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    ZodiacLocalization.range(context, sign.id),
                    style: GoogleFonts.inter(
                      color: Colors.white38,
                      fontSize: 9,
                      letterSpacing: 0.4,
                    ),
                    textAlign: TextAlign.center,
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
