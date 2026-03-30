import 'package:flutter/material.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

import '../../domain/models/soul_revelation_models.dart';
import 'soul_revelation_result_page.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

class SoulRevelationQuizPage extends StatefulWidget {
  const SoulRevelationQuizPage({super.key});

  @override
  State<SoulRevelationQuizPage> createState() => _SoulRevelationQuizPageState();
}

class _SoulRevelationQuizPageState extends State<SoulRevelationQuizPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  int? _selected;
  final Map<int, int> _answers = {};
  late final AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _selectAnswer(int value) {
    setState(() => _selected = value);

    Future.delayed(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _answers[bfi44Questions[_index].id] = value;

      if (_index < bfi44Questions.length - 1) {
        setState(() {
          _index += 1;
          _selected = null;
        });
        _fadeCtrl
          ..reset()
          ..forward();
      } else {
        final scores = calculateBfi44Scores(_answers);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (_) => SoulRevelationResultPage(scores: scores),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vi = Localizations.localeOf(context).languageCode == 'vi';
    final total = bfi44Questions.length;
    final question = bfi44Questions[_index];
    final progress = (_index + 1) / total;
    final disagree = vi ? 'Không đồng ý' : 'Disagree';
    final agree = vi ? 'Đồng ý' : 'Agree';
    final channeling = vi ? 'Đang kết nối...' : 'Channeling...';

    return Scaffold(
      backgroundColor: AstroColors.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Back button ────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                    ),
                    color: AstroColors.ink,
                  ),
                ),
              ),

              // ── Question area ──────────────────────────────────────────
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          question.promptFor(
                            Localizations.localeOf(context),
                          ),
                          textAlign: TextAlign.center,
                          style: AstroText.body(size: 16, height: 1.65),
                        ),

                        const SizedBox(height: 48),

                        // ── Circle selector ─────────────────────────────
                        _CircleRow(
                          count: bfiScaleOptions.length,
                          selected: _selected,
                          onSelect: _selectAnswer,
                        ),

                        const SizedBox(height: 14),

                        // ── Disagree / Agree labels ─────────────────────
                        Row(
                          children: [
                            Text(
                              disagree,
                              style: AstroText.caption(),
                            ),
                            const Spacer(),
                            Text(
                              agree,
                              style: AstroText.caption(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Bottom bar ─────────────────────────────────────────────
              _QuizBottomBar(
                current: _index + 1,
                total: total,
                progress: progress,
                channeling: channeling,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Circle row selector ────────────────────────────────────────────────────
class _CircleRow extends StatelessWidget {
  const _CircleRow({
    required this.count,
    required this.selected,
    required this.onSelect,
  });

  final int count;
  final int? selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final value = i + 1;
        final isSelected = selected == value;
        final scale = 0.72 + (i / (count - 1)) * 0.28;
        final size = 38.0 * scale + 6;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: GestureDetector(
            onTap: () => onSelect(value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AstroColors.red : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AstroColors.red : AstroColors.border,
                  width: isSelected ? 0 : 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AstroColors.red.withValues(alpha: 0.3),
                          blurRadius: 8,
                        )
                      ]
                    : null,
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ─── Quiz bottom bar ────────────────────────────────────────────────────────
class _QuizBottomBar extends StatelessWidget {
  const _QuizBottomBar({
    required this.current,
    required this.total,
    required this.progress,
    required this.channeling,
  });

  final int current;
  final int total;
  final double progress;
  final String channeling;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                '$current / $total',
                style: AstroText.caption(),
              ),
              const Spacer(),
              Text(
                channeling,
                style: AstroText.caption(),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 3,
              backgroundColor: AstroColors.border.withValues(alpha: 0.3),
              color: AstroColors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'BFI-44',
            style: AstroText.micro(),
          ),
        ],
      ),
    );
  }
}
