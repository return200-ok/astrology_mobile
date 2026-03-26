import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/models/soul_revelation_models.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';
import 'soul_revelation_result_page.dart';

// ─── Ink Wash palette ────────────────────────────────────────────────────────
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

class SoulRevelationQuizPage extends StatefulWidget {
  const SoulRevelationQuizPage({super.key});

  @override
  State<SoulRevelationQuizPage> createState() => _SoulRevelationQuizPageState();
}

class _SoulRevelationQuizPageState extends State<SoulRevelationQuizPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  int? _selected; // currently highlighted circle (1-5)
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

    // Short delay then advance
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
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Back button ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: _P.ink,
                    ),
                  ),
                ),
              ),

              // ── Question area (Expanded — vertically centered) ─────────
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Question text
                        Text(
                          question.promptFor(
                            Localizations.localeOf(context),
                          ),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: _P.ink,
                            fontSize: 16,
                            height: 1.65,
                            letterSpacing: 0.2,
                          ),
                        ),

                        const SizedBox(height: 48),

                        // ── Circle selector ───────────────────────────────
                        _CircleRow(
                          count: bfiScaleOptions.length,
                          selected: _selected,
                          onSelect: _selectAnswer,
                        ),

                        const SizedBox(height: 14),

                        // ── Disagree / Agree labels ───────────────────────
                        Row(
                          children: [
                            Text(
                              disagree,
                              style: GoogleFonts.inter(
                                color: _P.light,
                                fontSize: 11,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              agree,
                              style: GoogleFonts.inter(
                                color: _P.light,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Bottom bar ────────────────────────────────────────────────
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

// ─── Circle row selector ──────────────────────────────────────────────────────
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
        // Scale: first circle smallest, last largest
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
                color: isSelected ? _P.red : Colors.transparent,
                border: Border.all(
                  color: isSelected ? _P.red : _P.border,
                  width: isSelected ? 0 : 1.5,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ─── Quiz bottom bar ──────────────────────────────────────────────────────────
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
                style: GoogleFonts.inter(
                  color: _P.light,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              Text(
                channeling,
                style: GoogleFonts.inter(
                  color: _P.light,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 3,
              backgroundColor: _P.iconBg,
              color: _P.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'BFI-44',
            style: GoogleFonts.cinzel(
              color: _P.light,
              fontSize: 10,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
