import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

import '../../domain/models/soul_revelation_models.dart';
import 'soul_revelation_intro_page.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

class SoulRevelationResultPage extends StatelessWidget {
  const SoulRevelationResultPage({super.key, required this.scores});

  final Map<BigFiveTrait, double> scores;

  @override
  Widget build(BuildContext context) {
    final vi = Localizations.localeOf(context).languageCode == 'vi';
    final locale = Localizations.localeOf(context);
    final rows = BigFiveTrait.values
        .map((t) => _TraitRow(
              trait: t,
              label: t.label(locale),
              score: scores[t] ?? 0.0,
              level: bigFiveLevelOf(bigFiveAverageFrom100(scores[t] ?? 0.0)),
            ))
        .toList();

    return Scaffold(
      backgroundColor: AstroColors.parchment,
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
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                    ),
                    color: AstroColors.ink,
                  ),
                ),
              ),

              // ── Scrollable content ───────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 8, 28, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ResultHeader(vi: vi),
                      const SizedBox(height: 40),
                      ...rows.map((row) => _TraitSection(row: row, vi: vi)),
                      const SizedBox(height: 40),
                      _RetakeButton(vi: vi),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),

              // ── Bottom bar ───────────────────────────────────────────────
              _BottomBar(vi: vi),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Header ─────────────────────────────────────────────────────────────────
class _ResultHeader extends StatelessWidget {
  const _ResultHeader({required this.vi});
  final bool vi;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final title = 'BIG FIVE TEST';
    final subtitle = l10n.soulBfiResultSubtitle;

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AstroText.pageTitle(AstroSize.title(width)),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AstroText.pageSubtitle(),
        ),
      ],
    );
  }
}

// ─── Trait section (bar + description) ──────────────────────────────────────
class _TraitSection extends StatelessWidget {
  const _TraitSection({required this.row, required this.vi});
  final _TraitRow row;
  final bool vi;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final progress = (row.score / 100).clamp(0.0, 1.0);
    final scoreText = _fmt(row.score);
    final levelText = row.level.label(locale);
    final desc = _desc(row.trait, row.level, vi);

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label row
          Row(
            children: [
              Expanded(
                child: Text(
                  row.label,
                  style: AstroText.resultLabel(),
                ),
              ),
              Text(
                '$scoreText / 100',
                style: AstroText.score(),
              ),
              const SizedBox(width: 8),
              Text(
                '· $levelText',
                style: AstroText.caption(),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: AstroColors.border.withValues(alpha: 0.3),
              color: AstroColors.red,
            ),
          ),

          const SizedBox(height: 10),

          // Description
          Text(
            desc,
            style: AstroText.bodyMuted(size: 12, height: 1.65),
          ),

          const SizedBox(height: 10),

          // Thin separator
          Container(height: 0.5, color: AstroColors.divider),
        ],
      ),
    );
  }
}

// ─── Retake button ──────────────────────────────────────────────────────────
class _RetakeButton extends StatelessWidget {
  const _RetakeButton({required this.vi});
  final bool vi;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final label = l10n.soulBfiRetake;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (_) => const SoulRevelationIntroPage(),
          ),
          (route) => false,
        ),
        borderRadius: BorderRadius.circular(999),
        splashColor: AstroColors.red.withValues(alpha: 0.08),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AstroColors.red.withValues(alpha: 0.5), width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AstroText.buttonOutline(size: 13),
          ),
        ),
      ),
    );
  }
}

// ─── Bottom bar ─────────────────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.vi});
  final bool vi;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rightLabel = l10n.soulQuestionsFixed;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('100%', style: AstroText.caption()),
              const Spacer(),
              Text(rightLabel, style: AstroText.caption()),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 1.0,
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

// ─── Data ───────────────────────────────────────────────────────────────────
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

String _fmt(double v) =>
    v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);

String _desc(BigFiveTrait trait, BigFiveLevel level, bool vi) {
  switch (trait) {
    case BigFiveTrait.extraversion:
      if (vi) {
        switch (level) {
          case BigFiveLevel.low: return 'Bạn có xu hướng hướng nội, ưu tiên không gian riêng và mở rộng khi thực sự thoải mái.';
          case BigFiveLevel.medium: return 'Bạn cân bằng tốt giữa giao tiếp và khoảng riêng, linh hoạt theo ngữ cảnh.';
          case BigFiveLevel.high: return 'Bạn hướng ngoại, dễ mang năng lượng đến nhóm nhưng vẫn cần những lúc giảm nhịp.';
        }
      }
      switch (level) {
        case BigFiveLevel.low: return 'You lean introverted, preferring private space and opening up selectively.';
        case BigFiveLevel.medium: return 'You balance sociability and privacy well, adjusting to context.';
        case BigFiveLevel.high: return 'You tend toward extraversion and energize others easily.';
      }
    case BigFiveTrait.agreeableness:
      if (vi) {
        switch (level) {
          case BigFiveLevel.low: return 'Bạn thẳng thắn và dè phòng trong quan hệ, ưu tiên sự rõ ràng hơn việc làm vừa lòng.';
          case BigFiveLevel.medium: return 'Bạn khá hòa hợp nhưng vẫn biết giữ ranh giới, vừa hợp tác vừa bảo vệ quan điểm.';
          case BigFiveLevel.high: return 'Bạn ấm áp và dễ đồng cảm, nhưng cần giữ giới hạn để tránh quá chiều ý người khác.';
        }
      }
      switch (level) {
        case BigFiveLevel.low: return 'You are direct and guarded in relationships, valuing clarity over pleasing everyone.';
        case BigFiveLevel.medium: return 'You balance kindness with boundaries, cooperative without losing your stance.';
        case BigFiveLevel.high: return 'You tend to be warm and compassionate, while needing boundaries to avoid overgiving.';
      }
    case BigFiveTrait.conscientiousness:
      if (vi) {
        switch (level) {
          case BigFiveLevel.low: return 'Bạn linh hoạt và tự phát, nhưng dễ mất nhịp nếu thiếu cấu trúc rõ ràng.';
          case BigFiveLevel.medium: return 'Bạn có mức kỷ luật ổn, đủ để hoàn thành việc quan trọng và vẫn giữ khoảng thở.';
          case BigFiveLevel.high: return 'Bạn tận tâm và có tổ chức, nhưng cũng nên tránh tự tạo áp lực quá mức.';
        }
      }
      switch (level) {
        case BigFiveLevel.low: return 'You are spontaneous and flexible, but may lose momentum without structure.';
        case BigFiveLevel.medium: return 'You show steady discipline while keeping room to adapt.';
        case BigFiveLevel.high: return 'You are organized and dependable, though watch for self-imposed pressure.';
      }
    case BigFiveTrait.neuroticism:
      if (vi) {
        switch (level) {
          case BigFiveLevel.low: return 'Bạn khá vững vàng về cảm xúc, thường giữ bình tĩnh ngay cả khi xung quanh biến động.';
          case BigFiveLevel.medium: return 'Bạn có độ nhạy cảm vừa phải, cảm nhận áp lực nhưng thường tự cân bằng lại được.';
          case BigFiveLevel.high: return 'Bạn nhạy với áp lực hơn người khác, nhưng điều đó cũng cho phép bạn nhận biết tình huống sớm.';
        }
      }
      switch (level) {
        case BigFiveLevel.low: return 'You are emotionally steady and calm even when circumstances shift.';
        case BigFiveLevel.medium: return 'You feel pressure but often regain balance on your own.';
        case BigFiveLevel.high: return 'You are sensitive to stress, though that can come with early awareness of tension.';
      }
    case BigFiveTrait.openness:
      if (vi) {
        switch (level) {
          case BigFiveLevel.low: return 'Bạn thực tế và ưu tiên điều quen thuộc, muốn thấy sự rõ ràng trước khi mở rộng.';
          case BigFiveLevel.medium: return 'Bạn cân bằng giữa ổn định và khám phá, sẵn sàng thử điều mới khi nó thực sự hữu ích.';
          case BigFiveLevel.high: return 'Bạn cởi mở với ý tưởng và trải nghiệm mới, nhưng cần điểm neo thực tế để biến cảm hứng thành hành động.';
        }
      }
      switch (level) {
        case BigFiveLevel.low: return 'You are practical and familiar-grounded, preferring clarity before exploring.';
        case BigFiveLevel.medium: return 'You balance stability with curiosity, opening when ideas feel meaningful.';
        case BigFiveLevel.high: return 'You are open to ideas and new experiences, while needing grounding to act on inspiration.';
      }
  }
}
