import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';

import '../../domain/models/oracle_sign.dart';
import '../widgets/oracle_starfield_background.dart';

class OracleSignReadingPage extends StatelessWidget {
  const OracleSignReadingPage({super.key, required this.sign});

  final OracleSign sign;

  static const Color _gold = Color(0xFFFFD438);
  static const Color _panel = Color(0xFF242062);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: OracleStarfieldBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white70,
                    tooltip: l10n.backTooltip,
                  ),
                ),
                const SizedBox(height: 8),
                _buildMainOraclePanel(context),
                const SizedBox(height: 18),
                _buildSoulPanel(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainOraclePanel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final signTitleSize = width < 430 ? 34.0 : 42.0;
    final guidanceSize = width < 430 ? 18.0 : 26.0;

    return Container(
      width: 920,
      constraints: const BoxConstraints(maxWidth: 920),
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 26),
      decoration: BoxDecoration(
        color: _panel.withOpacity(0.96),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _gold.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.22),
            blurRadius: 24,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 14,
            top: 10,
            child: Text(
              sign.symbol,
              style: TextStyle(
                color: _gold.withOpacity(0.10),
                fontSize: 56,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFBC64FF), Color(0xFF8E49DB)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD992FF).withOpacity(0.62),
                      blurRadius: 20,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  sign.symbol,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                ZodiacLocalization.name(context, sign.id),
                style: GoogleFonts.cinzel(
                  color: _gold,
                  fontSize: signTitleSize,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 120,
                height: 1,
                color: _gold.withOpacity(0.45),
              ),
              const SizedBox(height: 34),
              Text(
                '"${sign.guidance}"',
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  color: _gold,
                  fontSize: guidanceSize,
                  height: 1.4,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 34),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _gold,
                  side: BorderSide(color: _gold.withOpacity(0.8)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 14),
                ),
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: Text(
                  l10n.oracleResetStars,
                  style: GoogleFonts.cinzel(
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSoulPanel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sections = <_InsightGroup>[
      _InsightGroup(l10n.oracleEssence, sign.essence),
      _InsightGroup(l10n.oracleSpiritualFlow, sign.spiritualFlow),
      _InsightGroup(l10n.oracleDrawnTo, sign.drawnTo),
      _InsightGroup(l10n.oracleRadiatesTo, sign.radiatesTo),
      _InsightGroup(l10n.oracleDharmaPath, sign.dharmaPath),
      _InsightGroup(l10n.oracleSacredNeeds, sign.sacredNeeds),
    ];

    return Container(
      width: 920,
      constraints: const BoxConstraints(maxWidth: 920),
      decoration: BoxDecoration(
        color: _panel.withOpacity(0.98),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withOpacity(0.35)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            decoration: const BoxDecoration(
              color: _gold,
              borderRadius: BorderRadius.vertical(top: Radius.circular(19)),
            ),
            child: Text(
              l10n.oracleSoulPanelHeader,
              style: GoogleFonts.cinzel(
                color: const Color(0xFF1D184C),
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 760
                    ? 3
                    : constraints.maxWidth >= 520
                        ? 2
                        : 1;
                const spacing = 14.0;
                final itemWidth = columns == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - (spacing * (columns - 1))) / columns;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: sections
                      .map(
                        (section) => SizedBox(
                          width: itemWidth,
                          child: _InsightSection(
                            title: section.title,
                            items: section.items,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightSection extends StatelessWidget {
  const _InsightSection({required this.title, required this.items});

  final String title;
  final List<String> items;

  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: _gold.withOpacity(0.30),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.cinzel(
              color: _gold,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '- $item',
                style: GoogleFonts.cormorantGaramond(
                  color: _gold.withOpacity(0.88),
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightGroup {
  const _InsightGroup(this.title, this.items);

  final String title;
  final List<String> items;
}
