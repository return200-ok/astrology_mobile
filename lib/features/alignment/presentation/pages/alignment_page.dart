import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';
import 'package:astroweb_mobile/core/widgets/astro_page_scaffold.dart';
import 'package:astroweb_mobile/core/widgets/astro_card.dart';
import 'package:astroweb_mobile/core/widgets/astro_button.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

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

List<String> _bondTypes(AppLocalizations l10n) => [
  l10n.alignmentBondRomantic,
  l10n.alignmentBondFriendship,
  l10n.alignmentBondSoul,
  l10n.alignmentBondKinship,
];

enum _Element { fire, earth, air, water }
enum _Modality { cardinal, fixed, mutable }
enum _Polarity { masculine, feminine }

class _ScoreFactor {
  const _ScoreFactor({
    required this.label,
    required this.points,
    required this.detail,
  });
  final String label;
  final int points;
  final String detail;
}

class _ScoreBreakdown {
  const _ScoreBreakdown({required this.total, required this.factors});
  final int total;
  final List<_ScoreFactor> factors;
}

// ─── Page ─────────────────────────────────────────────────────────────────────
class AlignmentPage extends StatefulWidget {
  const AlignmentPage({super.key});

  @override
  State<AlignmentPage> createState() => _AlignmentPageState();
}

class _AlignmentPageState extends State<AlignmentPage> {
  _SignOption _origin = _kSigns.firstWhere((s) => s.id == 'gemini');
  _SignOption? _distant;
  String? _bondType;
  _ScoreBreakdown? _breakdown;
  String? _message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bondTypes = _bondTypes(l10n);
    _bondType ??= bondTypes.first;
    final width = MediaQuery.sizeOf(context).width;

    return AstroPageScaffold(
      horizontalPadding: 16,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            style: AstroText.pageTitle(AstroSize.title(width)),
          ),

          const SizedBox(height: 8),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.alignmentSubtitle,
              textAlign: TextAlign.center,
              style: AstroText.pageSubtitle(),
            ),
          ),

          const SizedBox(height: 20),

          // Red divider
          Center(
            child: Container(
              width: 80,
              height: 1,
              color: AstroColors.red.withValues(alpha: 0.55),
            ),
          ),

          const SizedBox(height: 16),

          _MainCard(
            origin: _origin,
            distant: _distant,
            bondType: _bondType!,
            onOriginTap: () => _pickSign(isOrigin: true),
            onDistantTap: () => _pickSign(isOrigin: false),
            onBondTypeTap: _pickBondType,
            onViewBond: _seekAlignment,
            l10n: l10n,
          ),
          if (_breakdown != null && _message != null) ...[
            const SizedBox(height: 14),
            _ResultCard(
              breakdown: _breakdown!,
              message: _message!,
            ),
          ],
        ],
      ),
    );
  }

  // ── Sign picker ─────────────────────────────────────────────────────────────
  Future<void> _pickSign({required bool isOrigin}) async {
    final l10n = AppLocalizations.of(context)!;
    var selected = isOrigin ? _origin : (_distant ?? _kSigns.first);
    var idx = _kSigns.indexOf(selected).clamp(0, _kSigns.length - 1);

    final picked = await showModalBottomSheet<_SignOption>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 320,
          decoration: BoxDecoration(
            color: AstroColors.board,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: AstroColors.border, width: 0.8),
          ),
          child: Column(
            children: [
              // Header
              Container(
                height: 54,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: AstroColors.card,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(
                    bottom: BorderSide(color: AstroColors.divider, width: 0.8),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      isOrigin ? l10n.alignmentOriginSoul : l10n.alignmentDistantSoul,
                      style: AstroText.sectionLabel(size: 11, spacing: 1.8).copyWith(color: AstroColors.mid),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          Navigator.of(context).pop(_kSigns[idx]),
                      child: Text(
                        l10n.commonDone,
                        style: AstroText.sectionLabel(size: 15),
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
                          color: AstroColors.border.withValues(alpha: 0.30),
                          borderRadius: BorderRadius.circular(10),
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
                              style: AstroText.sectionLabel(size: 18).copyWith(color: AstroColors.ink),
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
      _breakdown = null;
      _message = null;
    });
  }

  // ── Bond type picker ──────────────────────────────────────────────────────
  Future<void> _pickBondType() async {
    final l10n = AppLocalizations.of(context)!;
    final types = _bondTypes(l10n);
    var idx = (_bondType != null ? types.indexOf(_bondType!) : 0).clamp(0, types.length - 1);

    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 280,
          decoration: BoxDecoration(
            color: AstroColors.board,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: AstroColors.border, width: 0.8),
          ),
          child: Column(
            children: [
              Container(
                height: 54,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: AstroColors.card,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(
                    bottom: BorderSide(color: AstroColors.divider, width: 0.8),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.alignmentBondType,
                      style: AstroText.sectionLabel(size: 11, spacing: 1.8).copyWith(color: AstroColors.mid),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          Navigator.of(context).pop(types[idx]),
                      child: Text(
                        l10n.commonDone,
                        style: AstroText.sectionLabel(size: 15),
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
                          color: AstroColors.border.withValues(alpha: 0.30),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      CupertinoPicker(
                        itemExtent: 44,
                        scrollController:
                            FixedExtentScrollController(initialItem: idx),
                        onSelectedItemChanged: (i) => idx = i,
                        children: types.map((type) {
                          return Center(
                            child: Text(
                              type,
                              style: AstroText.sectionLabel(size: 17).copyWith(color: AstroColors.ink),
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
          backgroundColor: AstroColors.ink,
        ),
      );
      return;
    }
    final breakdown = _calculateBreakdown(
      l10n,
      _origin.id,
      _distant!.id,
      _bondType ?? '',
    );
    setState(() {
      _breakdown = breakdown;
      _message = _buildMessage(context, breakdown.total);
    });
  }

  // Factor-based scoring. Total = baseline 50 + each factor's contribution,
  // clamped to [40, 99]. Each factor exposes its label, points, and a
  // human-readable explanation rendered in the result card.
  _ScoreBreakdown _calculateBreakdown(
    AppLocalizations l10n,
    String a,
    String b,
    String bondType,
  ) {
    final factors = <_ScoreFactor>[];
    var total = 50;

    // ── Element factor ────────────────────────────────────────────────────
    final ea = _elementOf(a);
    final eb = _elementOf(b);
    final elName = '${l10n.alignmentFactorElement} '
        '(${_elementName(l10n, ea)} & ${_elementName(l10n, eb)})';
    if (ea == eb) {
      const pts = 22;
      total += pts;
      factors.add(_ScoreFactor(
        label: elName,
        points: pts,
        detail: l10n.alignmentExplainSameElement(_elementName(l10n, ea)),
      ));
    } else if (_isComplementElement(ea, eb)) {
      const pts = 18;
      total += pts;
      factors.add(_ScoreFactor(
        label: elName,
        points: pts,
        detail: l10n.alignmentExplainComplementElement,
      ));
    } else {
      const pts = 6;
      total += pts;
      factors.add(_ScoreFactor(
        label: elName,
        points: pts,
        detail: l10n.alignmentExplainTensionElement,
      ));
    }

    // ── Modality factor ───────────────────────────────────────────────────
    final ma = _modalityOf(a);
    final mb = _modalityOf(b);
    final modName = '${l10n.alignmentFactorModality} '
        '(${_modalityName(l10n, ma)} & ${_modalityName(l10n, mb)})';
    if (ma == mb) {
      const pts = 8;
      total += pts;
      factors.add(_ScoreFactor(
        label: modName,
        points: pts,
        detail: l10n.alignmentExplainSameModality(_modalityName(l10n, ma)),
      ));
    } else {
      const pts = 14;
      total += pts;
      factors.add(_ScoreFactor(
        label: modName,
        points: pts,
        detail: l10n.alignmentExplainDifferentModality,
      ));
    }

    // ── Polarity factor ───────────────────────────────────────────────────
    final pa = _polarityOf(a);
    final pb = _polarityOf(b);
    final polName = l10n.alignmentFactorPolarity;
    if (pa == pb) {
      const pts = 6;
      total += pts;
      factors.add(_ScoreFactor(
        label: polName,
        points: pts,
        detail: l10n.alignmentExplainSamePolarity,
      ));
    } else {
      const pts = 10;
      total += pts;
      factors.add(_ScoreFactor(
        label: polName,
        points: pts,
        detail: l10n.alignmentExplainOppositePolarity,
      ));
    }

    // ── Aspect / sign-distance factor ─────────────────────────────────────
    final aspect = _aspectBetween(a, b);
    final pts = aspect.points;
    total += pts;
    factors.add(_ScoreFactor(
      label: '${l10n.alignmentFactorAspect} (${aspect.name(l10n)})',
      points: pts,
      detail: aspect.detail(l10n),
    ));

    // ── Bond-type modifier ────────────────────────────────────────────────
    final bondPts = _bondTypeBonus(bondType, ea, eb, ma, mb, l10n);
    total += bondPts.points;
    factors.add(_ScoreFactor(
      label: '${l10n.alignmentFactorBondType} ($bondType)',
      points: bondPts.points,
      detail: bondPts.detail,
    ));

    return _ScoreBreakdown(
      total: total.clamp(40, 99),
      factors: factors,
    );
  }

  String _buildMessage(BuildContext context, int score) {
    final l10n = AppLocalizations.of(context)!;
    if (score >= 90) return l10n.alignmentMessageOptimized;
    if (score >= 80) return l10n.alignmentMessageHarmonic;
    if (score >= 65) return l10n.alignmentMessageGrowth;
    return l10n.alignmentMessageChallenging;
  }

  bool _isComplementElement(_Element e1, _Element e2) {
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

  _Modality _modalityOf(String id) {
    switch (id) {
      case 'aries':
      case 'cancer':
      case 'libra':
      case 'capricorn':
        return _Modality.cardinal;
      case 'taurus':
      case 'leo':
      case 'scorpio':
      case 'aquarius':
        return _Modality.fixed;
      default:
        return _Modality.mutable;
    }
  }

  _Polarity _polarityOf(String id) {
    final e = _elementOf(id);
    if (e == _Element.fire || e == _Element.air) return _Polarity.masculine;
    return _Polarity.feminine;
  }

  String _elementName(AppLocalizations l10n, _Element e) {
    switch (e) {
      case _Element.fire:
        return l10n.alignmentElementFire;
      case _Element.earth:
        return l10n.alignmentElementEarth;
      case _Element.air:
        return l10n.alignmentElementAir;
      case _Element.water:
        return l10n.alignmentElementWater;
    }
  }

  String _modalityName(AppLocalizations l10n, _Modality m) {
    switch (m) {
      case _Modality.cardinal:
        return l10n.alignmentModalityCardinal;
      case _Modality.fixed:
        return l10n.alignmentModalityFixed;
      case _Modality.mutable:
        return l10n.alignmentModalityMutable;
    }
  }

  _Aspect _aspectBetween(String a, String b) {
    final ia = _kSigns.indexWhere((s) => s.id == a);
    final ib = _kSigns.indexWhere((s) => s.id == b);
    var diff = (ia - ib).abs();
    if (diff > 6) diff = 12 - diff;
    switch (diff) {
      case 0:
        return _Aspect.conjunction;
      case 1:
        return _Aspect.semisextile;
      case 2:
        return _Aspect.sextile;
      case 3:
        return _Aspect.square;
      case 4:
        return _Aspect.trine;
      case 5:
        return _Aspect.quincunx;
      default:
        return _Aspect.opposition;
    }
  }

  _BondBonus _bondTypeBonus(
    String bondType,
    _Element ea,
    _Element eb,
    _Modality ma,
    _Modality mb,
    AppLocalizations l10n,
  ) {
    if (bondType == l10n.alignmentBondRomantic) {
      final complement = _isComplementElement(ea, eb);
      return _BondBonus(
        points: complement ? 8 : 4,
        detail: complement
            ? l10n.alignmentExplainBondRomanticGood
            : l10n.alignmentExplainBondRomanticOk,
      );
    }
    if (bondType == l10n.alignmentBondFriendship) {
      final airy = ea == _Element.air || eb == _Element.air;
      return _BondBonus(
        points: airy ? 7 : 5,
        detail: airy
            ? l10n.alignmentExplainBondFriendshipGood
            : l10n.alignmentExplainBondFriendshipOk,
      );
    }
    if (bondType == l10n.alignmentBondSoul) {
      final deep = ea == _Element.water || eb == _Element.water;
      return _BondBonus(
        points: deep ? 8 : 5,
        detail: deep
            ? l10n.alignmentExplainBondSoulGood
            : l10n.alignmentExplainBondSoulOk,
      );
    }
    // Kinship / family
    final grounded = ea == _Element.earth || eb == _Element.earth ||
        ea == _Element.water || eb == _Element.water;
    return _BondBonus(
      points: grounded ? 7 : 4,
      detail: grounded
          ? l10n.alignmentExplainBondKinshipGood
          : l10n.alignmentExplainBondKinshipOk,
    );
  }
}

enum _Aspect {
  conjunction,
  semisextile,
  sextile,
  square,
  trine,
  quincunx,
  opposition,
}

extension _AspectMeta on _Aspect {
  int get points {
    switch (this) {
      case _Aspect.conjunction:
        return 12;
      case _Aspect.semisextile:
        return 4;
      case _Aspect.sextile:
        return 10;
      case _Aspect.square:
        return 3;
      case _Aspect.trine:
        return 14;
      case _Aspect.quincunx:
        return 4;
      case _Aspect.opposition:
        return 8;
    }
  }

  String name(AppLocalizations l10n) {
    switch (this) {
      case _Aspect.conjunction:
        return l10n.alignmentAspectConjunction;
      case _Aspect.semisextile:
        return l10n.alignmentAspectSemisextile;
      case _Aspect.sextile:
        return l10n.alignmentAspectSextile;
      case _Aspect.square:
        return l10n.alignmentAspectSquare;
      case _Aspect.trine:
        return l10n.alignmentAspectTrine;
      case _Aspect.quincunx:
        return l10n.alignmentAspectQuincunx;
      case _Aspect.opposition:
        return l10n.alignmentAspectOpposition;
    }
  }

  String detail(AppLocalizations l10n) {
    switch (this) {
      case _Aspect.conjunction:
        return l10n.alignmentExplainAspectConjunction;
      case _Aspect.semisextile:
        return l10n.alignmentExplainAspectSemisextile;
      case _Aspect.sextile:
        return l10n.alignmentExplainAspectSextile;
      case _Aspect.square:
        return l10n.alignmentExplainAspectSquare;
      case _Aspect.trine:
        return l10n.alignmentExplainAspectTrine;
      case _Aspect.quincunx:
        return l10n.alignmentExplainAspectQuincunx;
      case _Aspect.opposition:
        return l10n.alignmentExplainAspectOpposition;
    }
  }
}

class _BondBonus {
  const _BondBonus({required this.points, required this.detail});
  final int points;
  final String detail;
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
    return AstroCard(
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
                  style: AstroText.sectionLabel(size: 26).copyWith(color: AstroColors.red.withValues(alpha: 0.70), fontWeight: FontWeight.w300),
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
                border: Border.all(color: AstroColors.border, width: 0.8),
                color: AstroColors.card,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.link_rounded,
                      color: AstroColors.red.withValues(alpha: 0.70), size: 18),
                  const SizedBox(width: 10),
                  Text(
                    bondType,
                    style: AstroText.sectionLabel(size: 15, spacing: 0.8).copyWith(color: AstroColors.ink, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AstroColors.light,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Divider
          const Divider(color: AstroColors.divider, thickness: 0.8, height: 1),

          const SizedBox(height: 18),

          // ── Seek button ─────────────────────────────────────────────────
          AstroButton.outline(
            label: l10n.alignmentSeekButton,
            expanded: false,
            height: 48,
            icon: Icon(Icons.auto_awesome_rounded,
                size: 17, color: AstroColors.red.withValues(alpha: 0.80)),
            onTap: onViewBond,
          ),

          const SizedBox(height: 18),

          // Divider
          const Divider(color: AstroColors.divider, thickness: 0.8, height: 1),

          const SizedBox(height: 16),

          // ── Footer ──────────────────────────────────────────────────────
          Text(
            l10n.alignmentFooterBonds,
            style: AstroText.body(size: 13).copyWith(color: AstroColors.light),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () {},
            child: Text(
              l10n.alignmentFooterRecent,
              style: AstroText.body(size: 13).copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AstroColors.border,
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
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AstroColors.iconBg,
              border: Border.all(
                color: hasSign
                    ? AstroColors.red.withValues(alpha: 0.50)
                    : AstroColors.border,
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: hasSign
                ? Text(
                    sign!.symbol,
                    style: TextStyle(
                      color: AstroColors.red.withValues(alpha: 0.85),
                      fontSize: 38,
                      height: 1,
                    ),
                  )
                : Icon(
                    Icons.add_circle_outline_rounded,
                    color: AstroColors.light,
                    size: 32,
                  ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                hasSign
                    ? ZodiacLocalization.name(context, sign!.id)
                    : label.split(' ').first,
                style: AstroText.body(size: 13).copyWith(color: AstroColors.mid),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AstroColors.light,
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
  const _ResultCard({required this.breakdown, required this.message});

  final _ScoreBreakdown breakdown;
  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final score = breakdown.total;
    return AstroCard(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.alignmentAnalysisTitle,
            textAlign: TextAlign.center,
            style: AstroText.sectionLabel(size: 16).copyWith(color: AstroColors.ink),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Text(
                l10n.alignmentScoreLabel,
                style: AstroText.sectionLabel(size: 13, spacing: 1.5).copyWith(color: AstroColors.mid),
              ),
              const Spacer(),
              Text(
                '$score%',
                style: AstroText.resultLabel(size: 22),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: (score / 100).clamp(0.0, 1.0),
              backgroundColor: AstroColors.iconBg,
              color: AstroColors.red.withValues(alpha: 0.70),
            ),
          ),

          const SizedBox(height: 22),

          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: AstroColors.board,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AstroColors.divider, width: 0.8),
            ),
            child: Text(
              '\u201C$message\u201D',
              textAlign: TextAlign.center,
              style: AstroText.quote(13),
            ),
          ),

          const SizedBox(height: 24),

          // Breakdown header
          Row(
            children: [
              Icon(Icons.insights_rounded,
                  size: 16, color: AstroColors.red.withValues(alpha: 0.75)),
              const SizedBox(width: 8),
              Text(
                l10n.alignmentBreakdownTitle,
                style: AstroText.sectionLabel(size: 13, spacing: 1.5)
                    .copyWith(color: AstroColors.ink),
              ),
              const Spacer(),
              Text(
                l10n.alignmentBreakdownBaseline,
                style: AstroText.caption(size: 11),
              ),
            ],
          ),

          const SizedBox(height: 12),

          for (final factor in breakdown.factors) ...[
            _FactorRow(factor: factor),
            const SizedBox(height: 10),
          ],

          const SizedBox(height: 4),
          Text(
            l10n.alignmentBreakdownDisclaimer,
            style: AstroText.caption(size: 11),
          ),
        ],
      ),
    );
  }
}

class _FactorRow extends StatelessWidget {
  const _FactorRow({required this.factor});

  final _ScoreFactor factor;

  @override
  Widget build(BuildContext context) {
    final positive = factor.points >= 0;
    final pointStr = '${positive ? '+' : ''}${factor.points}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AstroColors.cardAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AstroColors.divider, width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  factor.label,
                  style: AstroText.sectionLabel(size: 11, spacing: 0.8)
                      .copyWith(color: AstroColors.ink),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: positive
                      ? AstroColors.red.withValues(alpha: 0.10)
                      : AstroColors.iconBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  pointStr,
                  style: AstroText.score(size: 12).copyWith(
                    color: positive ? AstroColors.red : AstroColors.mid,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            factor.detail,
            style: AstroText.bodyMuted(size: 12, height: 1.5),
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
      ..color = AstroColors.red.withValues(alpha: 0.55);

    final r = size.height / 2;
    final leftCenter = Offset(size.width / 2 - r * 0.55, r);
    final rightCenter = Offset(size.width / 2 + r * 0.55, r);

    canvas.drawCircle(leftCenter, r, paint);
    canvas.drawCircle(rightCenter, r, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
