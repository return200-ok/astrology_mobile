import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/models/soul_revelation_models.dart';
import '../widgets/soul_revelation_starfield_background.dart';
import '../widgets/soul_revelation_tabs.dart';
import 'enneagram_intro_page.dart';
import 'soul_revelation_result_page.dart';

class SoulRevelationQuizPage extends StatefulWidget {
  const SoulRevelationQuizPage({super.key});

  @override
  State<SoulRevelationQuizPage> createState() => _SoulRevelationQuizPageState();
}

class _SoulRevelationQuizPageState extends State<SoulRevelationQuizPage> {
  static const Color _gold = Color(0xFFFFD438);
  int _index = 0;
  final Map<int, int> _answers = <int, int>{};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final total = bfi44Questions.length;
    final question = bfi44Questions[_index];
    final progress = (_index + 1) / total;

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
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 6),
                SoulRevelationTabs(
                  selectedIndex: 0,
                  onTabSelected: (index) {
                    if (index == 1) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (_) => const EnneagramIntroPage(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 22),
                _buildProgress(context, progress, _index + 1, total),
                const SizedBox(height: 30),
                Text(
                  question.promptFor(locale),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 30),
                ...bfiScaleOptions.map((option) {
                  final label = option.labelFor(locale);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _ScaleChoiceButton(
                      label: label,
                      onTap: () => _answer(question.id, option.value),
                    ),
                  );
                }),
                const SizedBox(height: 6),
                Text(
                  'BFI-44',
                  style: GoogleFonts.cinzel(
                    color: _gold.withOpacity(0.55),
                    fontSize: 12,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgress(BuildContext context, double progress, int current, int total) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            Text(
              l10n.soulEssenceProgress(current, total),
              style: GoogleFonts.cinzel(
                color: _gold.withOpacity(0.85),
                fontSize: 13,
                letterSpacing: 1.4,
              ),
            ),
            const Spacer(),
            Text(
              l10n.soulChanneling,
              style: GoogleFonts.cinzel(
                color: _gold.withOpacity(0.85),
                fontSize: 13,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            color: _gold,
            backgroundColor: const Color(0xFF1B1953),
          ),
        ),
      ],
    );
  }

  void _answer(int questionId, int value) {
    _answers[questionId] = value;
    if (_index < bfi44Questions.length - 1) {
      setState(() {
        _index += 1;
      });
      return;
    }

    final scores = calculateBfi44Scores(_answers);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => SoulRevelationResultPage(scores: scores),
      ),
    );
  }
}

class _ScaleChoiceButton extends StatelessWidget {
  const _ScaleChoiceButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final optionSize = width < 430 ? 20.0 : 26.0;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 760,
        constraints: const BoxConstraints(maxWidth: 760),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF1D1B5E).withOpacity(0.95),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: _gold.withOpacity(0.45)),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            color: _gold,
            fontSize: optionSize,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
