import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

import '../../domain/models/soul_revelation_models.dart';
import '../widgets/soul_revelation_tabs.dart';
import 'soul_revelation_intro_page.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

class EnneagramQuizPage extends StatefulWidget {
  const EnneagramQuizPage({super.key});

  @override
  State<EnneagramQuizPage> createState() => _EnneagramQuizPageState();
}

class _EnneagramQuizPageState extends State<EnneagramQuizPage> {
  int _index = 0;
  final Map<EnneagramType, int> _scores = {};

  @override
  Widget build(BuildContext context) {
    final total = enneagramQuestions.length;
    final question = enneagramQuestions[_index];
    final progress = (_index + 1) / total;

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
                    onPressed: () => Navigator.of(context).pop(),
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
                _buildProgress(context, progress, _index + 1, total),
                const SizedBox(height: 30),
                Text(
                  question.prompt,
                  textAlign: TextAlign.center,
                  style: AstroText.quote(26).copyWith(height: 1.3),
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
              style: AstroText.sectionLabel(size: 13, spacing: 1.4),
            ),
            const Spacer(),
            Text(
              l10n.soulChanneling,
              style: AstroText.sectionLabel(size: 13, spacing: 1.4),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            color: AstroColors.red,
            backgroundColor: AstroColors.border.withValues(alpha: 0.3),
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
          backgroundColor: AstroColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AstroColors.border),
          ),
          title: Text(
            l10n.soulArchetypeFound,
            style: AstroText.resultLabel(size: 18),
          ),
          content: Text(
            dominant.label,
            style: AstroText.quote(32),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                l10n.commonReturnToSilence,
                style: AstroText.link(),
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
          color: AstroColors.card,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AstroColors.border),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AstroText.body(size: optionSize),
        ),
      ),
    );
  }
}
