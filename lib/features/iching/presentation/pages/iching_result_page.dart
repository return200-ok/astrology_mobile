import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/widgets/astro_page_scaffold.dart';
import 'package:astroweb_mobile/core/widgets/astro_card.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

class IChingResultPage extends StatelessWidget {
  const IChingResultPage({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reading = _buildReading(query, l10n);
    final width = MediaQuery.sizeOf(context).width;
    final subtitleSize = width < 430 ? 12.0 : 16.0;

    return AstroPageScaffold(
      horizontalPadding: 20,
      bottomPadding: 30,
      body: Column(
        children: [
          Text(
            l10n.ichingTitle,
            textAlign: TextAlign.center,
            style: AstroText.pageTitle(AstroSize.title(width)),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.ichingSubtitle,
            textAlign: TextAlign.center,
            style: AstroText.pageSubtitle(size: subtitleSize),
          ),
          const SizedBox(height: 26),
          _ResponseCard(reading: reading),
        ],
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
    final quoteSize = width < 430 ? 20.0 : width < 900 ? 26.0 : 34.0;
    final bodySize = width < 430 ? 16.0 : width < 900 ? 18.0 : 24.0;

    return AstroCard(
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 22),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 920),
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
                        style: AstroText.pageTitle(AstroSize.title(width)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 96,
                        height: 1,
                        color: AstroColors.red.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 2,
                  child: Icon(
                    Icons.filter_none_rounded,
                    color: AstroColors.border.withValues(alpha: 0.3),
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
                style: AstroText.quote(quoteSize),
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle(l10n.ichingCosmicAnalysis),
            const SizedBox(height: 8),
            Container(height: 1, color: AstroColors.divider),
            const SizedBox(height: 12),
            Text(
              reading.analysis,
              style: AstroText.body(size: bodySize, height: 1.38),
            ),
            const SizedBox(height: 18),
            _sectionTitle(l10n.ichingSacredGuidance),
            const SizedBox(height: 8),
            Container(height: 1, color: AstroColors.divider),
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
                        border: Border.all(color: AstroColors.red.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        number,
                        style: AstroText.resultLabel(size: 10),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item,
                        style: AstroText.body(size: bodySize, height: 1.25),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 10),
            Container(height: 1, color: AstroColors.divider),
            const SizedBox(height: 14),
            Center(
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.rotate_left_rounded, color: AstroColors.gold),
                label: Text(
                  l10n.commonReturnToSilence,
                  style: AstroText.link(size: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: AstroText.sectionLabel(size: 14, spacing: 1.6),
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
