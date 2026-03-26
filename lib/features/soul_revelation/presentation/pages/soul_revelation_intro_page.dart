import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';
import 'soul_revelation_quiz_page.dart';

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

class SoulRevelationIntroPage extends StatelessWidget {
  const SoulRevelationIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vi = Localizations.localeOf(context).languageCode == 'vi';
    final total = 44;

    return Scaffold(
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: _P.ink,
                    ),
                  ),
                ),
              ),

              // ── Content (no card) ─────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 4, 28, 16),
                  child: _IntroContent(l10n: l10n, vi: vi),
                ),
              ),

              // ── Bottom bar ────────────────────────────────────────────────
              _BottomBar(progress: 0, current: 0, total: total, vi: vi),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Intro content (no card frame) ───────────────────────────────────────────
class _IntroContent extends StatelessWidget {
  const _IntroContent({required this.l10n, required this.vi});

  final AppLocalizations l10n;
  final bool vi;

  @override
  Widget build(BuildContext context) {
    final title = 'Big Five';
    final subtitle = vi ? 'KHÁM PHÁ CĂN TÂM BFI-44' : 'EXPLORE YOUR SOUL · BFI-44';
    final btnLabel = vi ? 'BẮT ĐẦU KIỂM TRA' : 'BEGIN TEST';
    final quote = vi
        ? '"Bắt đầu hành trình khám phá tâm hồn.\nTrả lời 44 câu hỏi trắc nghiệm."'
        : '"Begin the journey of soul discovery.\nAnswer 44 questions."';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title — single line
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            color: _P.ink,
            fontSize: 42,
            fontWeight: FontWeight.w700,
            height: 1.0,
            letterSpacing: 3.0,
          ),
        ),

        const SizedBox(height: 10),

        // Subtitle
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            color: _P.mid,
            fontSize: 10,
            letterSpacing: 2.6,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 40),

        // Sparkle icon
        const _Sparkle(size: 32),

        const SizedBox(height: 32),

        // Quote
        Text(
          quote,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: _P.light,
            fontSize: 13,
            height: 1.7,
            fontStyle: FontStyle.italic,
          ),
        ),

        const SizedBox(height: 48),

        // Begin button
        OutlinedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const SoulRevelationQuizPage(),
            ),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: _P.red,
            side: BorderSide(color: _P.red.withValues(alpha: 0.65)),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _Sparkle(size: 16, color: _P.red),
              const SizedBox(width: 10),
              Text(
                btnLabel,
                style: GoogleFonts.cinzel(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Sparkle (4-pointed star) ─────────────────────────────────────────────────
class _Sparkle extends StatelessWidget {
  const _Sparkle({this.size = 32, this.color = _P.red});

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
    // 4-pointed star
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

// ─── Bottom bar ───────────────────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.progress,
    required this.current,
    required this.total,
    required this.vi,
  });

  final double progress;
  final int current;
  final int total;
  final bool vi;

  @override
  Widget build(BuildContext context) {
    final leftLabel = current == 0 ? '0%' : '$current / $total';
    final rightLabel =
        vi ? '$total câu hỏi' : '$total questions';

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                leftLabel,
                style: GoogleFonts.inter(
                  color: _P.light,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              Text(
                rightLabel,
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
