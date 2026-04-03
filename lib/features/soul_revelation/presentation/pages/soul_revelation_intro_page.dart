import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/widgets/astro_page_scaffold.dart';
import 'package:astroweb_mobile/core/widgets/astro_button.dart';

import 'soul_revelation_quiz_page.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

class SoulRevelationIntroPage extends StatelessWidget {
  const SoulRevelationIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = 44;

    return AstroPageScaffold(
      scrollable: false,
      horizontalPadding: 0,
      topPadding: 0,
      bottomPadding: 0,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Content ─────────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 4, 28, 16),
              child: _IntroContent(l10n: l10n),
            ),
          ),

          // ── Bottom bar ──────────────────────────────────────────────
          _BottomBar(progress: 0, current: 0, total: total),
        ],
      ),
    );
  }
}

// ─── Intro content ──────────────────────────────────────────────────────────
class _IntroContent extends StatelessWidget {
  const _IntroContent({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final title = 'BIG FIVE TEST';
    final subtitle = l10n.soulBfiSubtitle;
    final btnLabel = l10n.soulBeginRevelation;
    final quote = l10n.soulBfiQuote;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: AstroText.pageTitle(AstroSize.title(width)),
        ),

        const SizedBox(height: 8),

        // Subtitle
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AstroText.pageSubtitle(),
        ),

        const SizedBox(height: 40),

        // Sparkle icon
        const _Sparkle(size: 32),

        const SizedBox(height: 32),

        // Quote
        Text(
          quote,
          textAlign: TextAlign.center,
          style: AstroText.bodyMuted(size: 13, height: 1.7),
        ),

        const SizedBox(height: 48),

        // Begin button
        AstroButton.outline(
          label: btnLabel,
          expanded: false,
          icon: const _Sparkle(size: 16, color: AstroColors.red),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const SoulRevelationQuizPage(),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Sparkle (4-pointed star) ────────────────────────────────────────────────
class _Sparkle extends StatelessWidget {
  const _Sparkle({this.size = 32, this.color = _defaultColor});

  static const _defaultColor = AstroColors.red;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _SparklePainter(color: color)),
    );
  }
}

class _SparklePainter extends CustomPainter {
  const _SparklePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    final path = Path();
    path.moveTo(cx, cy - r);
    path.quadraticBezierTo(cx + r * 0.12, cy - r * 0.12, cx + r, cy);
    path.quadraticBezierTo(cx + r * 0.12, cy + r * 0.12, cx, cy + r);
    path.quadraticBezierTo(cx - r * 0.12, cy + r * 0.12, cx - r, cy);
    path.quadraticBezierTo(cx - r * 0.12, cy - r * 0.12, cx, cy - r);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Bottom bar ─────────────────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.progress,
    required this.current,
    required this.total,
  });

  final double progress;
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final leftLabel = current == 0 ? '0%' : '$current / $total';
    final rightLabel = l10n.soulQuestionsCount(total);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                leftLabel,
                style: AstroText.caption(),
              ),
              const Spacer(),
              Text(
                rightLabel,
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
