import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/iching_starfield_background.dart';
import 'iching_result_page.dart';

class IChingInputPage extends StatefulWidget {
  const IChingInputPage({super.key});

  @override
  State<IChingInputPage> createState() => _IChingInputPageState();
}

class _IChingInputPageState extends State<IChingInputPage> {
  static const Color _gold = Color(0xFFFFD438);
  final TextEditingController _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 52.0 : width < 900 ? 72.0 : 84.0;
    final subtitleSize = width < 430 ? 12.0 : 16.0;
    final subtitleSpacing = width < 430 ? 2.2 : 4.4;

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
                    onPressed: () => Navigator.of(context).maybePop(),
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
                    letterSpacing: subtitleSpacing,
                  ),
                ),
                const SizedBox(height: 36),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 860;
        if (narrow) {
          return Column(
            children: [
              _InputCard(
                queryController: _queryController,
                onCast: _castYarrowStalks,
              ),
              const SizedBox(height: 16),
              const _AltarCard(),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _InputCard(
                queryController: _queryController,
                onCast: _castYarrowStalks,
              ),
            ),
            const SizedBox(width: 18),
            const Expanded(
              child: _AltarCard(),
            ),
          ],
        );
      },
    );
  }

  void _castYarrowStalks() {
    final l10n = AppLocalizations.of(context)!;
    final query = _queryController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.ichingQueryRequiredSnack)),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => IChingResultPage(query: query),
      ),
    );
  }
}

class _InputCard extends StatelessWidget {
  const _InputCard({
    required this.queryController,
    required this.onCast,
  });

  final TextEditingController queryController;
  final VoidCallback onCast;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final hintSize = width < 430 ? 24.0 : 28.0;
    final buttonSize = width < 430 ? 18.0 : 22.0;

    return Container(
      constraints: const BoxConstraints(minHeight: 260),
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1A59).withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.ichingWhisperQueryLabel,
            style: GoogleFonts.cinzel(
              color: _gold.withOpacity(0.72),
              fontSize: 15,
              letterSpacing: 2.1,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: queryController,
            style: GoogleFonts.cormorantGaramond(
              color: _gold,
              fontSize: 26,
              fontStyle: FontStyle.italic,
            ),
            decoration: InputDecoration(
              hintText: l10n.ichingWhisperQueryHint,
              hintStyle: GoogleFonts.cormorantGaramond(
                color: _gold.withOpacity(0.48),
                fontSize: hintSize,
                fontStyle: FontStyle.italic,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: _gold.withOpacity(0.75)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: _gold, width: 1.2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onCast,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF9E8B2D),
                foregroundColor: const Color(0xFF1D184C),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              icon: const Icon(Icons.auto_awesome_rounded, size: 20),
              label: Text(
                l10n.ichingCastYarrowStalks,
                style: GoogleFonts.cinzel(
                  fontSize: buttonSize,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.w700,
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

class _AltarCard extends StatelessWidget {
  const _AltarCard();

  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      constraints: const BoxConstraints(minHeight: 420),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1A59).withOpacity(0.85),
        borderRadius: BorderRadius.circular(44),
        border: Border.all(color: _gold.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.1),
            blurRadius: 20,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _gold.withOpacity(0.12)),
            ),
          ),
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _gold.withOpacity(0.08)),
            ),
          ),
          Positioned(
            bottom: 14,
            child: Text(
              l10n.ichingAltarReady,
              style: GoogleFonts.cinzel(
                color: _gold.withOpacity(0.35),
                fontSize: 16,
                letterSpacing: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
