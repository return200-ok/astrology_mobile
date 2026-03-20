import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/models/soul_revelation_models.dart';
import '../widgets/soul_revelation_starfield_background.dart';
import '../widgets/soul_revelation_tabs.dart';
import 'soul_revelation_intro_page.dart';

class EnneagramQuizPage extends StatefulWidget {
  const EnneagramQuizPage({super.key});

  @override
  State<EnneagramQuizPage> createState() => _EnneagramQuizPageState();
}

class _EnneagramQuizPageState extends State<EnneagramQuizPage> {
  static const Color _gold = Color(0xFFFFD438);
  int _index = 0;
  final Map<EnneagramType, int> _scores = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = enneagramQuestions.length;
    final question = enneagramQuestions[_index];
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
                _buildProgress(context, progress, _index + 1, total),
                const SizedBox(height: 30),
                Text(
                  question.prompt,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 30),
                ...List.generate(soulScaleOptions.length, (i) {
                  final label = soulScaleOptions[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _ScaleChoiceButton(
                      label: label,
                      onTap: () => _answer(question.type, i),
                    ),
                  );
                }),
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

  Future<void> _answer(EnneagramType type, int optionIndex) async {
    final l10n = AppLocalizations.of(context)!;
    _scores[type] = soulScalePercent[optionIndex];
    if (_index < enneagramQuestions.length - 1) {
      setState(() {
        _index += 1;
      });
      return;
    }

    final dominant = _dominantType();
    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1D1B5E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: _gold.withOpacity(0.5)),
          ),
          title: Text(
            l10n.soulArchetypeFound,
            style: GoogleFonts.cinzel(
              color: _gold,
              fontSize: 18,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            dominant.label,
            style: GoogleFonts.cormorantGaramond(
              color: _gold,
              fontSize: 32,
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                l10n.commonReturnToSilence,
                style: GoogleFonts.cinzel(color: _gold),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }

  EnneagramType _dominantType() {
    EnneagramType bestType = EnneagramType.one;
    int bestScore = -1;

    for (final type in EnneagramType.values) {
      final score = _scores[type] ?? 0;
      if (score > bestScore) {
        bestScore = score;
        bestType = type;
      }
    }
    return bestType;
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
    final optionSize = width < 430 ? 24.0 : 30.0;

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
