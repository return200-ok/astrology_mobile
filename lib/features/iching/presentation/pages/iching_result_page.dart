import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

abstract final class _P {
  static const ink    = Color(0xFF1A1A1A);
  static const mid    = Color(0xFF5C5C5C);
  static const light  = Color(0xFF8A8A8A);
  static const red    = Color(0xFF8B3A3A);
  static const card   = Color(0xFFFBF8F3);
  static const border = Color(0xFFCDC5B8);
  static const iconBg = Color(0xFFEAE3D8);
  static const divider = Color(0xFFD8D0C6);
  static const sheet  = Color(0xFFF2EDE4);
}

class IChingResultPage extends StatelessWidget {
  const IChingResultPage({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reading = _buildReading(query, l10n);
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 52.0 : width < 900 ? 72.0 : 84.0;
    final subtitleSize = width < 430 ? 12.0 : 16.0;

    return Scaffold(
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
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
                    color: _P.ink,
                  ),
                ),
                Text(
                  l10n.ichingTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _P.ink,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.ichingSubtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _P.mid,
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
        color: _P.card,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _P.border, width: 0.8),
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
                      style: GoogleFonts.cinzel(
                        color: _P.ink,
                        fontSize: headingSize,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 96,
                      height: 1,
                      color: _P.divider,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 4,
                top: 2,
                child: Icon(
                  Icons.filter_none_rounded,
                  color: _P.border.withValues(alpha: 0.35),
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
              style: GoogleFonts.inter(
                color: _P.ink,
                fontSize: quoteSize,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle(l10n.ichingCosmicAnalysis),
          const SizedBox(height: 8),
          Container(height: 1, color: _P.divider),
          const SizedBox(height: 12),
          Text(
            reading.analysis,
            style: GoogleFonts.inter(
              color: _P.ink,
              fontSize: bodySize,
              height: 1.38,
            ),
          ),
          const SizedBox(height: 18),
          _sectionTitle(l10n.ichingSacredGuidance),
          const SizedBox(height: 8),
          Container(height: 1, color: _P.divider),
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
                      border: Border.all(color: _P.red),
                    ),
                    child: Text(
                      number,
                      style: GoogleFonts.cinzel(
                        color: _P.ink,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.inter(
                        color: _P.ink,
                        fontSize: bodySize,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          Container(height: 1, color: _P.divider),
          const SizedBox(height: 14),
          Center(
            child: TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.rotate_left_rounded, color: _P.red),
              label: Text(
                l10n.commonReturnToSilence,
                style: GoogleFonts.cinzel(
                  color: _P.red,
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
        color: _P.mid,
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
