import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/models/soul_revelation_models.dart';
import '../widgets/soul_revelation_starfield_background.dart';
import '../widgets/soul_revelation_tabs.dart';
import 'enneagram_intro_page.dart';
import 'soul_revelation_intro_page.dart';

class SoulRevelationResultPage extends StatelessWidget {
  const SoulRevelationResultPage({super.key, required this.scores});

  final Map<BigFiveTrait, double> scores;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 56.0 : width < 900 ? 76.0 : 90.0;

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
                const SizedBox(height: 24),
                Text(
                  l10n.soulSignatureFound,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold,
                    fontSize: titleSize,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: _gold.withOpacity(0.35),
                        blurRadius: 14,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'BFI-44',
                  style: GoogleFonts.cinzel(
                    color: _gold.withOpacity(0.55),
                    fontSize: 12,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 24),
                _buildPanels(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPanels(BuildContext context) {
    final rows = _traitRows(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 980) {
          return Column(
            children: [
              _MetricsPanel(rows: rows),
              const SizedBox(height: 16),
              _ProfilePanel(rows: rows),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _MetricsPanel(rows: rows)),
            const SizedBox(width: 16),
            Expanded(child: _ProfilePanel(rows: rows)),
          ],
        );
      },
    );
  }

  List<_TraitRow> _traitRows(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return BigFiveTrait.values
        .map(
          (trait) => _TraitRow(
            trait: trait,
            label: trait.label(locale),
            score: scores[trait] ?? 0.0,
            level: bigFiveLevelOf(bigFiveAverageFrom100(scores[trait] ?? 0.0)),
          ),
        )
        .toList();
  }
}

class _MetricsPanel extends StatelessWidget {
  const _MetricsPanel({required this.rows});

  final List<_TraitRow> rows;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B5E).withOpacity(0.95),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: _gold.withOpacity(0.38)),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.16),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          ...rows.map((row) => _MetricBar(row: row)),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(
                    builder: (_) => const SoulRevelationIntroPage(),
                  ),
                  (route) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: _gold,
                side: BorderSide(color: _gold.withOpacity(0.65)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.rotate_left_rounded),
              label: Text(
                AppLocalizations.of(context)!.soulPurify,
                style: GoogleFonts.cinzel(
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricBar extends StatelessWidget {
  const _MetricBar({required this.row});

  final _TraitRow row;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final scoreText = _formatScore(row.score);
    final progress = ((row.score / 100).clamp(0.0, 1.0) as num).toDouble();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  row.label,
                  style: GoogleFonts.cinzel(
                    color: _gold,
                    fontSize: 13,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$scoreText / 100',
                    style: GoogleFonts.cinzel(
                      color: _gold,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    row.level.label(Localizations.localeOf(context)),
                    style: GoogleFonts.cormorantGaramond(
                      color: _gold.withOpacity(0.82),
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: progress,
              backgroundColor: const Color(0xFF1A184C),
              color: _gold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilePanel extends StatelessWidget {
  const _ProfilePanel({required this.rows});

  final List<_TraitRow> rows;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final profileTitleSize = width < 430 ? 22.0 : 32.0;
    final descriptionSize = width < 430 ? 20.0 : 26.0;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B5E).withOpacity(0.95),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: _gold.withOpacity(0.38)),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.16),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.filter_none_rounded, color: _gold, size: 32),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.soulSpiritualProfile,
                style: GoogleFonts.cinzel(
                  color: _gold,
                  fontSize: profileTitleSize,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...rows.map((row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${row.label}: ${_formatScore(row.score)} / 100',
                    style: GoogleFonts.cinzel(
                      color: _gold,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _traitDescription(context, row.trait, row.level),
                    style: GoogleFonts.cormorantGaramond(
                      color: _gold.withOpacity(0.95),
                      fontSize: descriptionSize,
                      height: 1.3,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _traitDescription(
    BuildContext context,
    BigFiveTrait trait,
    BigFiveLevel level,
  ) {
    final vi = Localizations.localeOf(context).languageCode == 'vi';

    switch (trait) {
      case BigFiveTrait.extraversion:
        if (vi) {
          switch (level) {
            case BigFiveLevel.low:
              return 'Bạn có xu hướng hướng nội hơn, ưu tiên không gian riêng và chỉ mở rộng khi thấy thực sự thoải mái.';
            case BigFiveLevel.medium:
              return 'Bạn cân bằng khá tốt giữa giao tiếp và khoảng riêng, linh hoạt theo ngữ cảnh và mức độ kết nối.';
            case BigFiveLevel.high:
              return 'Bạn có xu hướng hướng ngoại, dễ mang năng lượng đến nhóm, nhưng vẫn cần những lúc giảm nhịp để phục hồi.';
          }
        }
        switch (level) {
          case BigFiveLevel.low:
            return 'You lean more introverted, often preferring private space and opening up selectively.';
          case BigFiveLevel.medium:
            return 'You balance sociability and privacy well, adjusting based on context and trust.';
          case BigFiveLevel.high:
            return 'You tend toward extraversion and energize people easily, while still benefiting from quiet reset time.';
        }
      case BigFiveTrait.agreeableness:
        if (vi) {
          switch (level) {
            case BigFiveLevel.low:
              return 'Bạn thẳng thắn và dè phòng hơn trong quan hệ, ưu tiên sự rõ ràng hơn việc làm vừa lòng tất cả mọi người.';
            case BigFiveLevel.medium:
              return 'Bạn khá hòa hợp nhưng vẫn biết giữ ranh giới, vừa hợp tác vừa bảo vệ quan điểm của mình.';
            case BigFiveLevel.high:
              return 'Bạn có xu hướng ấm áp, hợp tác và dễ đồng cảm, nhưng vẫn cần giữ giới hạn để tránh quá chiều ý người khác.';
          }
        }
        switch (level) {
          case BigFiveLevel.low:
            return 'You are more direct and guarded in relationships, often valuing clarity over pleasing everyone.';
          case BigFiveLevel.medium:
            return 'You balance kindness with boundaries, staying cooperative without losing your own position.';
          case BigFiveLevel.high:
            return 'You tend to be warm, cooperative, and compassionate, while still needing boundaries to avoid overgiving.';
        }
      case BigFiveTrait.conscientiousness:
        if (vi) {
          switch (level) {
            case BigFiveLevel.low:
              return 'Bạn linh hoạt và tự phát hơn, nhưng dễ mất nhịp nếu thiếu cấu trúc rõ ràng và mốc thời gian cụ thể.';
            case BigFiveLevel.medium:
              return 'Bạn có mức kỷ luật ổn, đủ để hoàn thành việc quan trọng nhưng vẫn để lại cho mình khoảng thở để điều chỉnh.';
            case BigFiveLevel.high:
              return 'Bạn có xu hướng tận tâm và có tổ chức, theo đuổi mục tiêu tốt, nhưng cũng nên tránh tự tạo áp lực quá mức.';
          }
        }
        switch (level) {
          case BigFiveLevel.low:
            return 'You are more spontaneous and flexible, but may lose momentum without clear structure and deadlines.';
          case BigFiveLevel.medium:
            return 'You show steady discipline, enough to complete important goals while keeping room to adapt.';
          case BigFiveLevel.high:
            return 'You tend to be organized and dependable, strong at follow-through, though you may need to watch self-imposed pressure.';
        }
      case BigFiveTrait.neuroticism:
        if (vi) {
          switch (level) {
            case BigFiveLevel.low:
              return 'Bạn khá vững vàng về cảm xúc, thường giữ được sự bình tĩnh ngay cả khi môi trường xung quanh biến động.';
            case BigFiveLevel.medium:
              return 'Bạn có độ nhạy cảm cảm xúc vừa phải, vẫn cảm nhận được áp lực nhưng thường có khả năng tự cân bằng lại.';
            case BigFiveLevel.high:
              return 'Bạn nhạy với áp lực và biến động cảm xúc hơn người khác, nhưng điều đó cũng đi kèm khả năng nhận biết tình huống rất sớm.';
          }
        }
        switch (level) {
          case BigFiveLevel.low:
            return 'You are relatively emotionally steady and often stay calm even when circumstances shift around you.';
          case BigFiveLevel.medium:
            return 'You show a moderate level of emotional sensitivity, feeling pressure but often regaining balance on your own.';
          case BigFiveLevel.high:
            return 'You are more sensitive to stress and emotional shifts, though that can also come with early awareness of tension.';
        }
      case BigFiveTrait.openness:
        if (vi) {
          switch (level) {
            case BigFiveLevel.low:
              return 'Bạn thực tế và ưu tiên điều quen thuộc, thường muốn thấy sự rõ ràng trước khi mở rộng sang cái mới.';
            case BigFiveLevel.medium:
              return 'Bạn cân bằng giữa sự ổn định và khám phá, sẵn sàng thử điều mới khi nó thực sự có ý nghĩa hoặc hữu ích.';
            case BigFiveLevel.high:
              return 'Bạn có xu hướng cởi mở với ý tưởng, nghệ thuật và trải nghiệm mới, nhưng vẫn cần điểm neo thực tế để biến cảm hứng thành hành động.';
          }
        }
        switch (level) {
          case BigFiveLevel.low:
            return 'You are more practical and familiar-grounded, often preferring clarity before exploring something new.';
          case BigFiveLevel.medium:
            return 'You balance stability with curiosity, opening to new ideas when they feel meaningful or useful.';
          case BigFiveLevel.high:
            return 'You tend to be open to ideas, aesthetics, and new experiences, while still needing practical grounding to turn inspiration into action.';
        }
    }
  }
}

class _TraitRow {
  const _TraitRow({
    required this.trait,
    required this.label,
    required this.score,
    required this.level,
  });

  final BigFiveTrait trait;
  final String label;
  final double score;
  final BigFiveLevel level;
}

String _formatScore(double score) {
  if (score == score.roundToDouble()) {
    return score.toStringAsFixed(0);
  }
  return score.toStringAsFixed(1);
}
