import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';

import '../../domain/models/oracle_sign.dart';
import '../widgets/oracle_starfield_background.dart';
import 'oracle_sign_reading_page.dart';

class OracleSignSelectionPage extends StatelessWidget {
  const OracleSignSelectionPage({super.key});

  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width >= 1280 ? 4 : width >= 860 ? 3 : width >= 560 ? 2 : 1;
    final tileHeight = width >= 1280 ? 190.0 : width >= 860 ? 182.0 : width >= 560 ? 174.0 : 164.0;

    return Scaffold(
      body: OracleStarfieldBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white70,
                    tooltip: l10n.backTooltip,
                  ),
                ),
                const SizedBox(height: 12),
                _buildHeader(context, l10n),
                const SizedBox(height: 22),
                GridView.builder(
                  itemCount: oracleSigns.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    mainAxisExtent: tileHeight,
                  ),
                  itemBuilder: (context, index) {
                    final sign = oracleSigns[index];
                    return _OracleSignTile(
                      sign: sign,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => OracleSignReadingPage(sign: sign),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 42.0 : width < 780 ? 56.0 : 64.0;
    final subtitleSize = width < 430 ? 11.0 : 16.0;
    final subtitleSpacing = width < 430 ? 2.2 : 5.0;

    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1D1B5E),
            border: Border.all(color: _gold.withOpacity(0.5), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: _gold.withOpacity(0.32),
                blurRadius: 22,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Icon(
            Icons.auto_awesome_rounded,
            color: _gold,
            size: 40,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          l10n.oracleTitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.cormorantGaramond(
            color: _gold,
            fontSize: titleSize,
            height: 1,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            letterSpacing: 3.0,
            shadows: [
              Shadow(
                color: _gold.withOpacity(0.45),
                blurRadius: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          l10n.oracleSelectPrompt,
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            color: _gold.withOpacity(0.55),
            fontSize: subtitleSize,
            letterSpacing: subtitleSpacing,
          ),
        ),
      ],
    );
  }
}

class _OracleSignTile extends StatelessWidget {
  const _OracleSignTile({required this.sign, required this.onTap});

  final OracleSign sign;
  final VoidCallback onTap;

  static const Color _gold = Color(0xFFFFD438);
  static const Color _cardBg = Color(0xFF262061);
  static const Color _cardBorder = Color(0xFF7B65C8);

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 430;
    final symbolSize = isNarrow ? 29.0 : 33.0;
    final titleSize = isNarrow ? 20.0 : 22.0;
    final dateSize = isNarrow ? 14.0 : 16.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: _cardBg.withOpacity(0.95),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _cardBorder.withOpacity(0.65)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7A5DDD).withOpacity(0.12),
                blurRadius: 18,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFBC64FF), Color(0xFF8E49DB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD992FF).withOpacity(0.65),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    sign.symbol,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: symbolSize,
                      height: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      ZodiacLocalization.name(context, sign.id),
                      style: GoogleFonts.cinzel(
                        color: _gold,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.7,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  ZodiacLocalization.range(context, sign.id),
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold.withOpacity(0.58),
                    fontSize: dateSize,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
