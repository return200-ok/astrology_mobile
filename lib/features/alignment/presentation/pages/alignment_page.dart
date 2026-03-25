import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';

import '../widgets/alignment_starfield_background.dart';

// ─── Colors ──────────────────────────────────────────────────────────────────
const Color _kGold = Color(0xFFD4AF37);
const Color _kGoldDim = Color(0xFFB8942D);
const Color _kCard = Color(0xFF1E1C52);
const Color _kCardDeep = Color(0xFF171545);
const Color _kDivider = Color(0xFFD4AF37);

// ─── Data ─────────────────────────────────────────────────────────────────────
class _SignOption {
  const _SignOption({required this.id, required this.symbol});
  final String id;
  final String symbol;
}

const List<_SignOption> _kSigns = [
  _SignOption(id: 'aries', symbol: '♈'),
  _SignOption(id: 'taurus', symbol: '♉'),
  _SignOption(id: 'gemini', symbol: '♊'),
  _SignOption(id: 'cancer', symbol: '♋'),
  _SignOption(id: 'leo', symbol: '♌'),
  _SignOption(id: 'virgo', symbol: '♍'),
  _SignOption(id: 'libra', symbol: '♎'),
  _SignOption(id: 'scorpio', symbol: '♏'),
  _SignOption(id: 'sagittarius', symbol: '♐'),
  _SignOption(id: 'capricorn', symbol: '♑'),
  _SignOption(id: 'aquarius', symbol: '♒'),
  _SignOption(id: 'pisces', symbol: '♓'),
];

const List<String> _kBondTypes = [
  'Romantic Connection',
  'Friendship Bond',
  'Soul Resonance',
  'Celestial Kinship',
];

enum _Element { fire, earth, air, water }

// ─── Page ─────────────────────────────────────────────────────────────────────
class AlignmentPage extends StatefulWidget {
  const AlignmentPage({super.key});

  @override
  State<AlignmentPage> createState() => _AlignmentPageState();
}

class _AlignmentPageState extends State<AlignmentPage> {
  _SignOption _origin = _kSigns.firstWhere((s) => s.id == 'gemini');
  _SignOption? _distant;
  String _bondType = _kBondTypes.first;
  int? _score;
  String? _message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: AlignmentStarfieldBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Back button
                Align(
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

                const SizedBox(height: 4),

                // Overlapping rings icon
                Center(
                  child: SizedBox(
                    width: 60,
                    height: 36,
                    child: CustomPaint(painter: _RingsPainter()),
                  ),
                ),

                const SizedBox(height: 16),

                // Title
                Text(
                  l10n.alignmentTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _kGold,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.6,
                    shadows: [
                      Shadow(
                        color: _kGold.withOpacity(0.45),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    l10n.alignmentSubtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: _kGold.withOpacity(0.65),
                      fontSize: 13,
                      height: 1.5,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Thin gold divider
                Container(
                  height: 0.5,
                  color: _kGold.withOpacity(0.30),
                ),

                const SizedBox(height: 24),

                // ── Main card ────────────────────────────────────────────────
                _MainCard(
                  origin: _origin,
                  distant: _distant,
                  bondType: _bondType,
                  onOriginTap: () => _pickSign(isOrigin: true),
                  onDistantTap: () => _pickSign(isOrigin: false),
                  onBondTypeTap: _pickBondType,
                  onViewBond: _seekAlignment,
                  l10n: l10n,
                ),

                // ── Result card ──────────────────────────────────────────────
                if (_score != null && _message != null) ...[
                  const SizedBox(height: 28),
                  _ResultCard(score: _score!, message: _message!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Sign picker ─────────────────────────────────────────────────────────────
  Future<void> _pickSign({required bool isOrigin}) async {
    var selected = isOrigin ? _origin : (_distant ?? _kSigns.first);
    var idx = _kSigns.indexOf(selected).clamp(0, _kSigns.length - 1);

    final picked = await showModalBottomSheet<_SignOption>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 320,
          decoration: BoxDecoration(
            color: _kCard.withOpacity(0.98),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: _kGold.withOpacity(0.25)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: _kCardDeep,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(
                    bottom: BorderSide(color: _kGold.withOpacity(0.20)),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      isOrigin ? 'ORIGIN SOUL' : 'DISTANT SOUL',
                      style: GoogleFonts.cinzel(
                        color: _kGold.withOpacity(0.80),
                        fontSize: 12,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          Navigator.of(context).pop(_kSigns[idx]),
                      child: Text(
                        'Xong',
                        style: GoogleFonts.cinzel(
                          color: _kGold,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Picker
              Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(brightness: Brightness.dark),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 44,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: _kGold.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _kGold.withOpacity(0.20)),
                        ),
                      ),
                      CupertinoPicker(
                        itemExtent: 44,
                        scrollController:
                            FixedExtentScrollController(initialItem: idx),
                        onSelectedItemChanged: (i) => idx = i,
                        children: _kSigns.map((sign) {
                          return Center(
                            child: Text(
                              '${sign.symbol}  ${ZodiacLocalization.name(context, sign.id)}',
                              style: GoogleFonts.cinzel(
                                color: _kGold.withOpacity(0.95),
                                fontSize: 18,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (picked == null) return;
    setState(() {
      if (isOrigin) {
        _origin = picked;
      } else {
        _distant = picked;
      }
      _score = null;
      _message = null;
    });
  }

  // ── Bond type picker ────────────────────────────────────────────────────────
  Future<void> _pickBondType() async {
    var idx = _kBondTypes.indexOf(_bondType).clamp(0, _kBondTypes.length - 1);

    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 280,
          decoration: BoxDecoration(
            color: _kCard.withOpacity(0.98),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: _kGold.withOpacity(0.25)),
          ),
          child: Column(
            children: [
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: _kCardDeep,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(
                    bottom: BorderSide(color: _kGold.withOpacity(0.20)),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'BOND TYPE',
                      style: GoogleFonts.cinzel(
                        color: _kGold.withOpacity(0.80),
                        fontSize: 12,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          Navigator.of(context).pop(_kBondTypes[idx]),
                      child: Text(
                        'Xong',
                        style: GoogleFonts.cinzel(
                          color: _kGold,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(brightness: Brightness.dark),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 44,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: _kGold.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _kGold.withOpacity(0.20)),
                        ),
                      ),
                      CupertinoPicker(
                        itemExtent: 44,
                        scrollController:
                            FixedExtentScrollController(initialItem: idx),
                        onSelectedItemChanged: (i) => idx = i,
                        children: _kBondTypes.map((type) {
                          return Center(
                            child: Text(
                              type,
                              style: GoogleFonts.cinzel(
                                color: _kGold.withOpacity(0.95),
                                fontSize: 17,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (picked == null) return;
    setState(() => _bondType = picked);
  }

  // ── Seek alignment ──────────────────────────────────────────────────────────
  void _seekAlignment() {
    final l10n = AppLocalizations.of(context)!;
    if (_distant == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.alignmentPickExternalSnack),
          backgroundColor: _kCard,
        ),
      );
      return;
    }
    final score = _calculateScore(_origin.id, _distant!.id);
    setState(() {
      _score = score;
      _message = _buildMessage(context, score);
    });
  }

  int _calculateScore(String a, String b) {
    if (a == b) return 96;
    if ((a == 'gemini' && b == 'virgo') || (a == 'virgo' && b == 'gemini'))
      return 99;
    if (_sameElement(a, b)) return 90;
    if (_isComplement(a, b)) return 84;
    return 68;
  }

  String _buildMessage(BuildContext context, int score) {
    final l10n = AppLocalizations.of(context)!;
    if (score >= 95) return l10n.alignmentMessageOptimized;
    if (score >= 85) return l10n.alignmentMessageHarmonic;
    if (score >= 75) return l10n.alignmentMessageGrowth;
    return l10n.alignmentMessageChallenging;
  }

  bool _sameElement(String a, String b) => _elementOf(a) == _elementOf(b);

  bool _isComplement(String a, String b) {
    final e1 = _elementOf(a);
    final e2 = _elementOf(b);
    return (e1 == _Element.fire && e2 == _Element.air) ||
        (e1 == _Element.air && e2 == _Element.fire) ||
        (e1 == _Element.water && e2 == _Element.earth) ||
        (e1 == _Element.earth && e2 == _Element.water);
  }

  _Element _elementOf(String id) {
    switch (id) {
      case 'aries':
      case 'leo':
      case 'sagittarius':
        return _Element.fire;
      case 'taurus':
      case 'virgo':
      case 'capricorn':
        return _Element.earth;
      case 'gemini':
      case 'libra':
      case 'aquarius':
        return _Element.air;
      default:
        return _Element.water;
    }
  }
}

// ─── Main card ────────────────────────────────────────────────────────────────
class _MainCard extends StatelessWidget {
  const _MainCard({
    required this.origin,
    required this.distant,
    required this.bondType,
    required this.onOriginTap,
    required this.onDistantTap,
    required this.onBondTypeTap,
    required this.onViewBond,
    required this.l10n,
  });

  final _SignOption origin;
  final _SignOption? distant;
  final String bondType;
  final VoidCallback onOriginTap;
  final VoidCallback onDistantTap;
  final VoidCallback onBondTypeTap;
  final VoidCallback onViewBond;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCard.withOpacity(0.90),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kGold.withOpacity(0.35), width: 1),
        boxShadow: [
          BoxShadow(
            color: _kGold.withOpacity(0.12),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      child: Column(
        children: [
          // ── Two avatars ───────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _AvatarPicker(
                sign: origin,
                label: l10n.alignmentOriginSoul,
                onTap: onOriginTap,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: Text(
                  '  &  ',
                  style: GoogleFonts.cinzel(
                    color: _kGold,
                    fontSize: 26,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              _AvatarPicker(
                sign: distant,
                label: l10n.alignmentDistantSoul,
                onTap: onDistantTap,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Bond type picker ──────────────────────────────────────────────
          GestureDetector(
            onTap: onBondTypeTap,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: _kGold.withOpacity(0.45), width: 1),
                color: Colors.white.withOpacity(0.04),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.link_rounded, color: _kGold, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    bondType,
                    style: GoogleFonts.cinzel(
                      color: _kGold,
                      fontSize: 15,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: _kGold.withOpacity(0.70),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Divider
          Container(height: 0.5, color: _kDivider.withOpacity(0.25)),

          const SizedBox(height: 18),

          // ── View Bond button ──────────────────────────────────────────────
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            child: InkWell(
              onTap: onViewBond,
              borderRadius: BorderRadius.circular(999),
              splashColor: _kGold.withOpacity(0.12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border:
                      Border.all(color: _kGold.withOpacity(0.55), width: 1),
                ),
                child: Text(
                  l10n.alignmentSeekButton,
                  style: GoogleFonts.cinzel(
                    color: _kGold,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Divider
          Container(height: 0.5, color: _kDivider.withOpacity(0.25)),

          const SizedBox(height: 16),

          // ── Footer ────────────────────────────────────────────────────────
          Text(
            '∞ Bonds Available',
            style: GoogleFonts.inter(
              color: _kGold.withOpacity(0.60),
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () {},
            child: Text(
              'View Recent Alignments',
              style: GoogleFonts.inter(
                color: _kGold.withOpacity(0.75),
                fontSize: 13,
                decoration: TextDecoration.underline,
                decorationColor: _kGold.withOpacity(0.55),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Avatar picker ────────────────────────────────────────────────────────────
class _AvatarPicker extends StatelessWidget {
  const _AvatarPicker({
    required this.sign,
    required this.label,
    required this.onTap,
  });

  final _SignOption? sign;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasSign = sign != null;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Circle avatar
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _kCardDeep,
              border: Border.all(
                color: _kGold.withOpacity(hasSign ? 0.65 : 0.30),
                width: 1.5,
              ),
              boxShadow: [
                if (hasSign)
                  BoxShadow(
                    color: _kGold.withOpacity(0.20),
                    blurRadius: 14,
                  ),
              ],
            ),
            alignment: Alignment.center,
            child: hasSign
                ? Text(
                    sign!.symbol,
                    style: TextStyle(
                      color: _kGold,
                      fontSize: 38,
                      height: 1,
                    ),
                  )
                : Icon(
                    Icons.add_circle_outline_rounded,
                    color: _kGold.withOpacity(0.35),
                    size: 32,
                  ),
          ),

          const SizedBox(height: 10),

          // Label + arrow
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                hasSign
                    ? ZodiacLocalization.name(context, sign!.id)
                    : label.split(' ').first,
                style: GoogleFonts.inter(
                  color: _kGold.withOpacity(0.80),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: _kGoldDim,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Result card ──────────────────────────────────────────────────────────────
class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.score, required this.message});

  final int score;
  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: _kCard.withOpacity(0.90),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kGold.withOpacity(0.35), width: 1),
        boxShadow: [
          BoxShadow(
            color: _kGold.withOpacity(0.12),
            blurRadius: 20,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.alignmentAnalysisTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              color: _kGold,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
              shadows: [
                Shadow(color: _kGold.withOpacity(0.40), blurRadius: 12),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Score row
          Row(
            children: [
              Text(
                l10n.alignmentScoreLabel,
                style: GoogleFonts.cinzel(
                  color: _kGold.withOpacity(0.80),
                  fontSize: 13,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              Text(
                '$score%',
                style: GoogleFonts.cinzel(
                  color: _kGold,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: (score / 100).clamp(0.0, 1.0),
              backgroundColor: _kCardDeep,
              color: _kGold,
            ),
          ),

          const SizedBox(height: 22),

          // Message
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _kGold.withOpacity(0.25)),
            ),
            child: Text(
              '"$message"',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: _kGold.withOpacity(0.90),
                fontSize: 13,
                fontStyle: FontStyle.italic,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Overlapping rings painter ────────────────────────────────────────────────
class _RingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..color = _kGold.withOpacity(0.85);

    final r = size.height / 2;
    final leftCenter = Offset(size.width / 2 - r * 0.55, r);
    final rightCenter = Offset(size.width / 2 + r * 0.55, r);

    canvas.drawCircle(leftCenter, r, paint);
    canvas.drawCircle(rightCenter, r, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
