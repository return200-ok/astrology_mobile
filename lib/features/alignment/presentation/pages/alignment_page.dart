import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

// ─── Palette ──────────────────────────────────────────────────────────────────
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

// ─── Data ─────────────────────────────────────────────────────────────────────
class _SignOption {
  const _SignOption({required this.id, required this.symbol});
  final String id;
  final String symbol;
}

const List<_SignOption> _kSigns = [
  _SignOption(id: 'aries', symbol: '\u2648'),
  _SignOption(id: 'taurus', symbol: '\u2649'),
  _SignOption(id: 'gemini', symbol: '\u264A'),
  _SignOption(id: 'cancer', symbol: '\u264B'),
  _SignOption(id: 'leo', symbol: '\u264C'),
  _SignOption(id: 'virgo', symbol: '\u264D'),
  _SignOption(id: 'libra', symbol: '\u264E'),
  _SignOption(id: 'scorpio', symbol: '\u264F'),
  _SignOption(id: 'sagittarius', symbol: '\u2650'),
  _SignOption(id: 'capricorn', symbol: '\u2651'),
  _SignOption(id: 'aquarius', symbol: '\u2652'),
  _SignOption(id: 'pisces', symbol: '\u2653'),
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
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context, l10n),
                const SizedBox(height: 16),
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
                if (_score != null && _message != null) ...[
                  const SizedBox(height: 14),
                  _ResultCard(score: _score!, message: _message!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          // Back button row
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              color: _P.ink,
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
              color: _P.ink,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
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
                color: _P.mid,
                fontSize: 13,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Red divider
          Container(
            width: 80,
            height: 1,
            color: _P.red.withValues(alpha: 0.55),
          ),
        ],
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
          decoration: const BoxDecoration(
            color: _P.sheet,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: _P.card,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(
                    bottom: BorderSide(color: _P.divider, width: 0.8),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      isOrigin ? 'ORIGIN SOUL' : 'DISTANT SOUL',
                      style: GoogleFonts.cinzel(
                        color: _P.mid,
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
                          color: _P.red,
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
                  data: const CupertinoThemeData(brightness: Brightness.light),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 44,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: _P.red.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _P.red.withValues(alpha: 0.15),
                          ),
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
                                color: _P.ink,
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

  // ── Bond type picker ──────────────────────────────────────────────────────
  Future<void> _pickBondType() async {
    var idx = _kBondTypes.indexOf(_bondType).clamp(0, _kBondTypes.length - 1);

    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 280,
          decoration: const BoxDecoration(
            color: _P.sheet,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: _P.card,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(
                    bottom: BorderSide(color: _P.divider, width: 0.8),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'BOND TYPE',
                      style: GoogleFonts.cinzel(
                        color: _P.mid,
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
                          color: _P.red,
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
                  data: const CupertinoThemeData(brightness: Brightness.light),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 44,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: _P.red.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _P.red.withValues(alpha: 0.15),
                          ),
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
                                color: _P.ink,
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

  // ── Seek alignment ────────────────────────────────────────────────────────
  void _seekAlignment() {
    final l10n = AppLocalizations.of(context)!;
    if (_distant == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.alignmentPickExternalSnack),
          backgroundColor: _P.ink,
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
    if ((a == 'gemini' && b == 'virgo') || (a == 'virgo' && b == 'gemini')) {
      return 99;
    }
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
        color: _P.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _P.border, width: 0.8),
      ),
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      child: Column(
        children: [
          // ── Two avatars ─────────────────────────────────────────────────
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
                    color: _P.red.withValues(alpha: 0.70),
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

          // ── Bond type picker ────────────────────────────────────────────
          GestureDetector(
            onTap: onBondTypeTap,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: _P.border, width: 1),
                color: _P.card,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.link_rounded,
                      color: _P.red.withValues(alpha: 0.70), size: 18),
                  const SizedBox(width: 10),
                  Text(
                    bondType,
                    style: GoogleFonts.cinzel(
                      color: _P.ink,
                      fontSize: 15,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: _P.light,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Divider
          const Divider(color: _P.divider, thickness: 0.8, height: 1),

          const SizedBox(height: 18),

          // ── Seek button ─────────────────────────────────────────────────
          OutlinedButton.icon(
            onPressed: onViewBond,
            style: OutlinedButton.styleFrom(
              foregroundColor: _P.red,
              side: BorderSide(
                color: _P.red.withValues(alpha: 0.65),
                width: 1,
              ),
              backgroundColor: _P.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            ),
            icon: Icon(Icons.auto_awesome_rounded,
                size: 17, color: _P.red.withValues(alpha: 0.80)),
            label: Text(
              l10n.alignmentSeekButton,
              style: GoogleFonts.cinzel(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Divider
          const Divider(color: _P.divider, thickness: 0.8, height: 1),

          const SizedBox(height: 16),

          // ── Footer ──────────────────────────────────────────────────────
          Text(
            '\u221E Bonds Available',
            style: GoogleFonts.inter(
              color: _P.light,
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
                color: _P.mid,
                fontSize: 13,
                decoration: TextDecoration.underline,
                decorationColor: _P.border,
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
              color: _P.iconBg,
              border: Border.all(
                color: hasSign
                    ? _P.red.withValues(alpha: 0.50)
                    : _P.border,
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: hasSign
                ? Text(
                    sign!.symbol,
                    style: TextStyle(
                      color: _P.red.withValues(alpha: 0.85),
                      fontSize: 38,
                      height: 1,
                    ),
                  )
                : Icon(
                    Icons.add_circle_outline_rounded,
                    color: _P.light,
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
                  color: _P.mid,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: _P.light,
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
        color: _P.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _P.border, width: 0.8),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.alignmentAnalysisTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              color: _P.ink,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
            ),
          ),

          const SizedBox(height: 24),

          // Score row
          Row(
            children: [
              Text(
                l10n.alignmentScoreLabel,
                style: GoogleFonts.cinzel(
                  color: _P.mid,
                  fontSize: 13,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              Text(
                '$score%',
                style: GoogleFonts.cinzel(
                  color: _P.red,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: (score / 100).clamp(0.0, 1.0),
              backgroundColor: _P.iconBg,
              color: _P.red.withValues(alpha: 0.70),
            ),
          ),

          const SizedBox(height: 22),

          // Message
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: _P.sheet,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _P.divider, width: 0.8),
            ),
            child: Text(
              '\u201C$message\u201D',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: _P.ink,
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
      ..color = _P.red.withValues(alpha: 0.55);

    final r = size.height / 2;
    final leftCenter = Offset(size.width / 2 - r * 0.55, r);
    final rightCenter = Offset(size.width / 2 + r * 0.55, r);

    canvas.drawCircle(leftCenter, r, paint);
    canvas.drawCircle(rightCenter, r, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
