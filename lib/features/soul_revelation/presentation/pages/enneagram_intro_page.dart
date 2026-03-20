import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/soul_revelation_starfield_background.dart';
import '../widgets/soul_revelation_tabs.dart';
import 'enneagram_quiz_page.dart';
import 'soul_revelation_intro_page.dart';

class EnneagramIntroPage extends StatelessWidget {
  const EnneagramIntroPage({super.key});

  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 64.0 : width < 900 ? 90.0 : 104.0;

    return Scaffold(
      body: SoulRevelationStarfieldBackground(
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
                const SizedBox(height: 6),
                SoulRevelationTabs(
                  selectedIndex: 1,
                  onTabSelected: (index) {
                    if (index == 0) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (_) => const SoulRevelationIntroPage(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 22),
                Text(
                  l10n.enneagramTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold,
                    fontSize: titleSize,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.7,
                    shadows: [
                      Shadow(
                        color: _gold.withOpacity(0.35),
                        blurRadius: 14,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                _buildHeroCard(context, l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, AppLocalizations l10n) {
    final width = MediaQuery.sizeOf(context).width;
    final quoteSize = width < 430 ? 26.0 : 34.0;
    final buttonSize = width < 430 ? 20.0 : 28.0;

    return Container(
      width: 920,
      constraints: const BoxConstraints(maxWidth: 920),
      padding: const EdgeInsets.fromLTRB(18, 26, 18, 28),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B5E).withOpacity(0.95),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: _gold.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.16),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            l10n.soulQuote,
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              color: _gold,
              fontSize: quoteSize,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const EnneagramQuizPage(),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: _gold,
              foregroundColor: const Color(0xFF1E1A57),
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            icon: const Icon(Icons.auto_awesome_rounded),
            label: Text(
              l10n.soulBeginRevelation,
              style: GoogleFonts.cinzel(
                fontSize: buttonSize,
                letterSpacing: 1.8,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
