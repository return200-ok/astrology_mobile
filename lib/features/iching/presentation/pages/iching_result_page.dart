import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/iching_starfield_background.dart';

class IChingResultPage extends StatelessWidget {
  const IChingResultPage({super.key, required this.query});

  final String query;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reading = _buildReading(query, l10n);
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 52.0 : width < 900 ? 72.0 : 84.0;
    final subtitleSize = width < 430 ? 12.0 : 16.0;

    return Scaffold(
      body: IChingStarfieldBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white70,
                  ),
                ),
                Text(
                  l10n.ichingTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(color: _gold.withOpacity(0.4), blurRadius: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.ichingSubtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _gold.withOpacity(0.62),
                    fontSize: subtitleSize,
                    letterSpacing: 4.3,
                  ),
                ),
                const SizedBox(height: 26),
                _ResponseCard(reading: reading),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _IChingReading _buildReading(String rawQuery, AppLocalizations l10n) {
    final q = rawQuery.toLowerCase();
    if (q.contains('love') || q.contains('tình') || q.contains('relationship')) {
      return _IChingReading(
        quote: l10n.ichingQuoteLove,
        analysis: l10n.ichingAnalysisLove,
        guidance: [
          l10n.ichingGuidanceLove1,
          l10n.ichingGuidanceLove2,
          l10n.ichingGuidanceLove3,
        ],
      );
    }

    if (q.contains('work') || q.contains('career') || q.contains('job')) {
      return _IChingReading(
        quote: l10n.ichingQuoteWork,
        analysis: l10n.ichingAnalysisWork,
        guidance: [
          l10n.ichingGuidanceWork1,
          l10n.ichingGuidanceWork2,
          l10n.ichingGuidanceWork3,
        ],
      );
    }

    return _IChingReading(
      quote: l10n.ichingQuoteDefault,
      analysis: l10n.ichingAnalysisDefault,
      guidance: [
        l10n.ichingGuidanceDefault1,
        l10n.ichingGuidanceDefault2,
        l10n.ichingGuidanceDefault3,
      ],
    );
  }
}

class _ResponseCard extends StatelessWidget {
  const _ResponseCard({required this.reading});

  final _IChingReading reading;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final headingSize = width < 430 ? 42.0 : width < 900 ? 52.0 : 64.0;
    final quoteSize = width < 430 ? 24.0 : width < 900 ? 30.0 : 44.0;
    final bodySize = width < 430 ? 18.0 : width < 900 ? 22.0 : 30.0;

    return Container(
      width: 920,
      constraints: const BoxConstraints(maxWidth: 920),
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 22),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1A59).withOpacity(0.95),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _gold.withOpacity(0.42)),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.18),
            blurRadius: 22,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      l10n.ichingOracleResponse,
                      style: GoogleFonts.cormorantGaramond(
                        color: _gold,
                        fontSize: headingSize,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2.0,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 96,
                      height: 1,
                      color: _gold.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 4,
                top: 2,
                child: Icon(
                  Icons.filter_none_rounded,
                  color: _gold.withOpacity(0.18),
                  size: 88,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              '"${reading.quote}"',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                color: _gold,
                fontSize: quoteSize,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle(l10n.ichingCosmicAnalysis),
          const SizedBox(height: 8),
          Container(height: 1, color: _gold.withOpacity(0.24)),
          const SizedBox(height: 12),
          Text(
            reading.analysis,
            style: GoogleFonts.cormorantGaramond(
              color: _gold,
              fontSize: bodySize,
              height: 1.38,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 18),
          _sectionTitle(l10n.ichingSacredGuidance),
          const SizedBox(height: 8),
          Container(height: 1, color: _gold.withOpacity(0.24)),
          const SizedBox(height: 12),
          ...List.generate(reading.guidance.length, (index) {
            final item = reading.guidance[index];
            final number = (index + 1).toString().padLeft(2, '0');
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: _gold.withOpacity(0.5)),
                    ),
                    child: Text(
                      number,
                      style: GoogleFonts.cinzel(
                        color: _gold,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.cormorantGaramond(
                        color: _gold,
                        fontSize: bodySize,
                        height: 1.25,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          Container(height: 1, color: _gold.withOpacity(0.24)),
          const SizedBox(height: 14),
          Center(
            child: TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.rotate_left_rounded, color: _gold.withOpacity(0.7)),
              label: Text(
                l10n.commonReturnToSilence,
                style: GoogleFonts.cinzel(
                  color: _gold.withOpacity(0.7),
                  letterSpacing: 1.3,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.cinzel(
        color: _gold.withOpacity(0.75),
        fontSize: 14,
        letterSpacing: 1.6,
      ),
    );
  }
}

class _IChingReading {
  const _IChingReading({
    required this.quote,
    required this.analysis,
    required this.guidance,
  });

  final String quote;
  final String analysis;
  final List<String> guidance;
}
