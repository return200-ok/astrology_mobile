import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';

import '../widgets/alignment_starfield_background.dart';

class AlignmentPage extends StatefulWidget {
  const AlignmentPage({super.key});

  @override
  State<AlignmentPage> createState() => _AlignmentPageState();
}

class _AlignmentPageState extends State<AlignmentPage> {
  static const Color _gold = Color(0xFFFFD438);
  static const List<_SignOption> _signs = [
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

  _SignOption _origin = _signs.firstWhere((s) => s.id == 'gemini');
  _SignOption? _external;
  int? _score;
  String? _message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 52.0 : width < 900 ? 72.0 : 84.0;
    final subtitleSize = width < 430 ? 12.0 : 16.0;
    final subtitleSpacing = width < 430 ? 2.2 : 4.5;

    return Scaffold(
      body: AlignmentStarfieldBackground(
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
                Text(
                  l10n.alignmentTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.9,
                    shadows: [
                      Shadow(color: _gold.withOpacity(0.4), blurRadius: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.alignmentSubtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _gold.withOpacity(0.66),
                    fontSize: subtitleSize,
                    letterSpacing: subtitleSpacing,
                  ),
                ),
                const SizedBox(height: 36),
                _buildSelectors(l10n),
                const SizedBox(height: 24),
                _buildSeekButton(l10n),
                if (_score != null && _message != null) ...[
                  const SizedBox(height: 34),
                  _buildResultCard(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectors(AppLocalizations l10n) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 760;
        if (narrow) {
          return Column(
            children: [
              _SelectorColumn(
                title: l10n.alignmentOriginSoul,
                child: _SignSelector(
                  signs: _signs,
                  value: _origin,
                  onChanged: (v) => setState(() => _origin = v!),
                  hint: l10n.alignmentChooseSign,
                ),
              ),
              const SizedBox(height: 16),
              _SelectorColumn(
                title: l10n.alignmentDistantSoul,
                child: _SignSelector(
                  signs: _signs,
                  value: _external,
                  onChanged: (v) => setState(() => _external = v),
                  hint: l10n.alignmentChooseSign,
                ),
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _SelectorColumn(
                title: l10n.alignmentOriginSoul,
                child: _SignSelector(
                  signs: _signs,
                  value: _origin,
                  onChanged: (v) => setState(() => _origin = v!),
                  hint: l10n.alignmentChooseSign,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _SelectorColumn(
                title: l10n.alignmentDistantSoul,
                child: _SignSelector(
                  signs: _signs,
                  value: _external,
                  onChanged: (v) => setState(() => _external = v),
                  hint: l10n.alignmentChooseSign,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSeekButton(AppLocalizations l10n) {
    final width = MediaQuery.sizeOf(context).width;
    final labelSize = width < 430 ? 24.0 : 31.0;

    return FilledButton.icon(
      onPressed: _seekAlignment,
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF2B286F),
        foregroundColor: _gold,
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: BorderSide(color: _gold.withOpacity(0.55)),
        ),
        elevation: 0,
      ),
      icon: const Icon(Icons.favorite_border_rounded, size: 22),
      label: Text(
        l10n.alignmentSeekButton,
        style: GoogleFonts.cinzel(
          fontSize: labelSize,
          letterSpacing: 1.8,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 40.0 : width < 900 ? 48.0 : 56.0;
    final quoteSize = width < 430 ? 24.0 : width < 900 ? 30.0 : 38.0;

    return Container(
      width: 920,
      constraints: const BoxConstraints(maxWidth: 920),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
      decoration: BoxDecoration(
        color: const Color(0xFF262366).withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _gold.withOpacity(0.45)),
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
          Center(
            child: Text(
              l10n.alignmentAnalysisTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                color: _gold,
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                letterSpacing: 2.2,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.alignmentScoreLabel,
                  style: GoogleFonts.cinzel(
                    color: _gold,
                    fontSize: 16,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Text(
                '${_score ?? 0}%',
                style: GoogleFonts.cinzel(
                  color: _gold,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 14,
              value: ((_score ?? 0) / 100).clamp(0, 1),
              backgroundColor: const Color(0xFF1A184C),
              color: _gold,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _gold.withOpacity(0.30)),
            ),
            child: Text(
              '"${_message ?? ''}"',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                color: _gold,
                fontSize: quoteSize,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _seekAlignment() {
    final l10n = AppLocalizations.of(context)!;
    final external = _external;
    if (external == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.alignmentPickExternalSnack)),
      );
      return;
    }

    final score = _calculateScore(_origin.id, external.id);
    final message = _buildMessage(context, score);
    setState(() {
      _score = score;
      _message = message;
    });
  }

  int _calculateScore(String a, String b) {
    if (a == b) return 96;
    if ((a == 'gemini' && b == 'virgo') || (a == 'virgo' && b == 'gemini')) return 99;
    if (_sameElement(a, b)) return 90;
    if (_isComplement(a, b)) return 84;
    return 68;
  }

  String _buildMessage(BuildContext context, int score) {
    final l10n = AppLocalizations.of(context)!;
    if (score >= 95) {
      return l10n.alignmentMessageOptimized;
    }
    if (score >= 85) {
      return l10n.alignmentMessageHarmonic;
    }
    if (score >= 75) {
      return l10n.alignmentMessageGrowth;
    }
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
      case 'cancer':
      case 'scorpio':
      case 'pisces':
        return _Element.water;
      default:
        return _Element.air;
    }
  }
}

enum _Element { fire, earth, air, water }

class _SelectorColumn extends StatelessWidget {
  const _SelectorColumn({required this.title, required this.child});

  final String title;
  final Widget child;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.cinzel(
            color: _gold,
            fontSize: 18,
            letterSpacing: 1.8,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _SignSelector extends StatelessWidget {
  const _SignSelector({
    required this.signs,
    required this.value,
    required this.onChanged,
    required this.hint,
  });

  final List<_SignOption> signs;
  final _SignOption? value;
  final ValueChanged<_SignOption?> onChanged;
  final String hint;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF252165),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _gold.withOpacity(0.55)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<_SignOption>(
          value: value,
          isExpanded: true,
          iconEnabledColor: _gold,
          dropdownColor: const Color(0xFF252165),
          style: GoogleFonts.cinzel(
            color: _gold,
            fontSize: 24,
          ),
          hint: Text(
            hint,
            style: GoogleFonts.cinzel(
              color: _gold.withOpacity(0.8),
              fontSize: 22,
            ),
          ),
          items: signs
              .map(
                (sign) => DropdownMenuItem<_SignOption>(
                  value: sign,
                  child: Text(
                    '${sign.symbol} ${ZodiacLocalization.name(context, sign.id)}',
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _SignOption {
  const _SignOption({
    required this.id,
    required this.symbol,
  });

  final String id;
  final String symbol;
}
