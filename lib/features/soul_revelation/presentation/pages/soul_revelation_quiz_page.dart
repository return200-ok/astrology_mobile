import 'package:flutter/material.dart';
import 'package:astroweb_mobile/core/widgets/astro_page_scaffold.dart';

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
          _selected = _answers[bfi44Questions[_index].id];
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

  void _goBack() {
    if (_index == 0) return;
    setState(() {
      _index -= 1;
      _selected = _answers[bfi44Questions[_index].id];
    });
    _fadeCtrl
      ..reset()
      ..forward();
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
    final tapToEdit = vi ? 'Chạm để sửa câu trước' : 'Tap to edit previous';

    final hasPrev = _index > 0;
    final prevQuestion = hasPrev ? bfi44Questions[_index - 1] : null;

    return AstroPageScaffold(
      scrollable: false,
      horizontalPadding: 0,
      topPadding: 0,
      bottomPadding: 0,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Previous question preview (tap to go back) ───────────────
          if (hasPrev && prevQuestion != null)
            _PreviousPreview(
              text: prevQuestion.promptFor(Localizations.localeOf(context)),
              hint: tapToEdit,
              onTap: _goBack,
            ),

          // ── Current question area ────────────────────────────────────
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

                    // ── Circle selector (V-shape: big ends, small middle)
                    _CircleRow(
                      count: bfiScaleOptions.length,
                      selected: _selected,
                      onSelect: _selectAnswer,
                    ),

                    const SizedBox(height: 14),

                    // ── Disagree / Agree labels ──────────────────────────
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

          // ── Bottom bar ───────────────────────────────────────────────
          _QuizBottomBar(
            current: _index + 1,
            total: total,
            progress: progress,
            channeling: channeling,
          ),
        ],
      ),
    );
  }
}

// ─── Previous question preview ──────────────────────────────────────────────
class _PreviousPreview extends StatelessWidget {
  const _PreviousPreview({
    required this.text,
    required this.hint,
    required this.onTap,
  });

  final String text;
  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AstroColors.border.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_upward_rounded,
                  size: 12,
                  color: AstroColors.gold.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 6),
                Text(
                  hint,
                  style: AstroText.micro(),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Opacity(
              opacity: 0.45,
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AstroText.body(size: 13, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Circle row selector (V-shape sizing) ──────────────────────────────────
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
    // V-shape: largest at the two ends, smallest in the middle.
    // Each step away from center adds a fixed size increment.
    final mid = (count - 1) / 2.0;
    final maxDist = mid; // farthest index from center

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(count, (i) {
        final value = i + 1;
        final isSelected = selected == value;
        final dist = (i - mid).abs();
        final t = maxDist == 0 ? 0.0 : dist / maxDist; // 0=middle, 1=end
        final size = 33.0 + t * 11.0; // 33 (middle) → 44 (ends)

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
                  width: isSelected ? 0 : 2.2,
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
