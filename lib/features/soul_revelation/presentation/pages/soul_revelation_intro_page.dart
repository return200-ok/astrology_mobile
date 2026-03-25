import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/soul_revelation_starfield_background.dart';
import 'soul_revelation_quiz_page.dart';

// ─── Colors ──────────────────────────────────────────────────────────────────
const Color _kBg = Color(0xFF070910);
const Color _kCard = Color(0xFF0E1020);
const Color _kGold = Color(0xFFD4AF37);
const Color _kTeal = Color(0xFF00BDA4);
const Color _kTealDark = Color(0xFF007A6B);
const Color _kCardBorder = Color(0xFFD4AF37);

class SoulRevelationIntroPage extends StatelessWidget {
  const SoulRevelationIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vi = Localizations.localeOf(context).languageCode == 'vi';
    final total = 44;

    return Scaffold(
      backgroundColor: _kBg,
      body: SoulRevelationStarfieldBackground(
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
                      Icons.chevron_left_rounded,
                      size: 32,
                      color: Colors.white60,
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
          style: GoogleFonts.cormorantGaramond(
            color: _kGold,
            fontSize: 42,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            height: 1.0,
            letterSpacing: 3.0,
            shadows: [
              Shadow(color: _kGold.withOpacity(0.45), blurRadius: 22),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Subtitle
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            color: _kGold.withOpacity(0.50),
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
            color: Colors.white.withOpacity(0.50),
            fontSize: 13,
            height: 1.7,
            fontStyle: FontStyle.italic,
          ),
        ),

        const SizedBox(height: 48),

        // Begin button
        _TealButton(
          label: btnLabel,
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

// ─── Teal gradient button ─────────────────────────────────────────────────────
class _TealButton extends StatelessWidget {
  const _TealButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: const LinearGradient(
              colors: [Color(0xFF00C9AE), Color(0xFF00897B)],
            ),
            boxShadow: [
              BoxShadow(
                color: _kTeal.withOpacity(0.40),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _Sparkle(size: 16, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.cinzel(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Sparkle (4-pointed star) ─────────────────────────────────────────────────
class _Sparkle extends StatelessWidget {
  const _Sparkle({this.size = 32, this.color = _kGold});

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
                  color: Colors.white24,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              Text(
                rightLabel,
                style: GoogleFonts.inter(
                  color: Colors.white24,
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
              backgroundColor: Colors.white.withOpacity(0.08),
              color: _kTeal,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'BFI-44',
            style: GoogleFonts.cinzel(
              color: _kGold.withOpacity(0.30),
              fontSize: 10,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
