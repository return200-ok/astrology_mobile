import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

import '../widgets/soul_revelation_tabs.dart';
import 'enneagram_quiz_page.dart';
import 'soul_revelation_intro_page.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

class EnneagramIntroPage extends StatelessWidget {
  const EnneagramIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AstroColors.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                    color: AstroColors.ink,
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
                  style: AstroText.pageTitle(AstroSize.title(width)),
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
    final quoteSize = width < 430 ? 22.0 : 28.0;
    final buttonSize = width < 430 ? 18.0 : 24.0;

    return Container(
      width: 920,
      constraints: const BoxConstraints(maxWidth: 920),
      padding: const EdgeInsets.fromLTRB(18, 26, 18, 28),
      decoration: BoxDecoration(
        color: AstroColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AstroColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            l10n.soulQuote,
            textAlign: TextAlign.center,
            style: AstroText.quote(quoteSize),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const EnneagramQuizPage(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AstroColors.red,
              side: const BorderSide(color: AstroColors.red, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            icon: const Icon(Icons.auto_awesome_rounded),
            label: Text(
              l10n.soulBeginRevelation,
              style: AstroText.buttonFilled(size: buttonSize),
            ),
          ),
        ],
      ),
    );
  }
}
