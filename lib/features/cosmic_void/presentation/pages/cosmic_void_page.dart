import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';
import 'package:astroweb_mobile/core/widgets/astro_page_scaffold.dart';
import 'package:astroweb_mobile/core/widgets/astro_button.dart';
import 'package:astroweb_mobile/core/widgets/astro_text_field.dart';
import 'package:astroweb_mobile/core/widgets/astro_section_header.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

// ─── Data ───────────────────────────────────────────────────────────────────
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

class _EchoEntry {
  const _EchoEntry({
    required this.alias,
    required this.sign,
    required this.essence,
    required this.timestamp,
  });
  final String alias;
  final _SignOption sign;
  final String essence;
  final DateTime timestamp;
}

// ─── Page ───────────────────────────────────────────────────────────────────
class CosmicVoidPage extends StatefulWidget {
  const CosmicVoidPage({super.key});

  @override
  State<CosmicVoidPage> createState() => _CosmicVoidPageState();
}

class _CosmicVoidPageState extends State<CosmicVoidPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aliasCtrl = TextEditingController();
  final TextEditingController _essenceCtrl = TextEditingController();
  final List<_EchoEntry> _echoes = [];
  _SignOption _sign = _kSigns.firstWhere((s) => s.id == 'gemini');

  @override
  void dispose() {
    _aliasCtrl.dispose();
    _essenceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;

    return AstroPageScaffold(
      scrollable: false,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Header ────────────────────────────────────────────
                    Text(
                      l10n.cosmicVoidTitle,
                      textAlign: TextAlign.center,
                      style: AstroText.pageTitle(AstroSize.title(width)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.cosmicVoidSubtitle,
                      textAlign: TextAlign.center,
                      style: AstroText.pageSubtitle(),
                    ),

                    const SizedBox(height: 40),

                    // ── Alias field ───────────────────────────────────────
                    AstroFieldLabel(text: l10n.cosmicSpiritAlias),
                    const SizedBox(height: 8),
                    AstroTextField(
                      controller: _aliasCtrl,
                      hint: l10n.cosmicSpiritPlaceholder,
                      maxLength: 30,
                      validator: (value) {
                        final v = value?.trim() ?? '';
                        if (v.isEmpty) return 'Vui lòng nhập tên';
                        if (v.length < 2) return 'Tên phải có ít nhất 2 ký tự';
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // ── Sign picker ───────────────────────────────────────
                    AstroFieldLabel(text: l10n.cosmicCelestialSign),
                    const SizedBox(height: 8),
                    _SignPicker(
                      sign: _sign,
                      onTap: _pickSign,
                    ),

                    const SizedBox(height: 20),

                    // ── Essence textarea ──────────────────────────────────
                    AstroFieldLabel(text: l10n.cosmicSpiritualEssence),
                    const SizedBox(height: 8),
                    AstroTextArea(
                      controller: _essenceCtrl,
                      hint: l10n.cosmicWhisperHint,
                      validator: (value) {
                        final v = value?.trim() ?? '';
                        if (v.isEmpty) return 'Vui lòng nhập tinh hoa';
                        if (v.length < 5) return 'Nội dung phải có ít nhất 5 ký tự';
                        return null;
                      },
                    ),

                    const SizedBox(height: 28),

                    // ── Send button ───────────────────────────────────────
                    AstroButton.outline(
                      label: l10n.cosmicWhisperToVoid,
                      onTap: () => _sendWhisper(l10n),
                    ),

                    const SizedBox(height: 36),

                    // ── Thin separator ────────────────────────────────────
                    Container(height: 0.5, color: AstroColors.divider),

                    const SizedBox(height: 24),

                    // ── Echoes section ────────────────────────────────────
                    AstroSectionHeader(title: l10n.cosmicEchoesTitle),
                    const SizedBox(height: 16),

                    if (_echoes.isEmpty)
                      _emptyState(l10n)
                    else
                      ..._echoes.map((e) => _EchoTile(entry: e)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Empty state ────────────────────────────────────────────────────────────
  Widget _emptyState(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Text(
            l10n.cosmicSilentPrimary,
            textAlign: TextAlign.center,
            style: AstroText.bodyMuted(size: 13),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.cosmicSilentSecondary,
            textAlign: TextAlign.center,
            style: AstroText.micro(size: 9, spacing: 3.0),
          ),
        ],
      ),
    );
  }

  // ── Sign picker sheet ──────────────────────────────────────────────────────
  Future<void> _pickSign() async {
    var idx = _kSigns.indexOf(_sign).clamp(0, _kSigns.length - 1);
    final picked = await showModalBottomSheet<_SignOption>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: AstroColors.card,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: AstroColors.border, width: 0.8),
          ),
          child: Column(
            children: [
              Container(
                height: 54,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AstroColors.board,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(
                    bottom: BorderSide(color: AstroColors.border, width: 0.8),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.cosmicCelestialSign,
                      style: AstroText.sectionLabel(size: 11, spacing: 1.8).copyWith(color: AstroColors.mid),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          Navigator.of(context).pop(_kSigns[idx]),
                      child: Text(
                        AppLocalizations.of(context)!.commonDone,
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
                        children: _kSigns.map((s) {
                          return Center(
                            child: Text(
                              '${s.symbol}  ${ZodiacLocalization.name(context, s.id)}',
                              style: AstroText.body(size: 17),
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
    if (picked != null && mounted) setState(() => _sign = picked);
  }

  // ── Send whisper ───────────────────────────────────────────────────────────
  void _sendWhisper(AppLocalizations l10n) {
    if (!_formKey.currentState!.validate()) return;
    final alias = _aliasCtrl.text.trim();
    final essence = _essenceCtrl.text.trim();
    setState(() {
      _echoes.insert(
        0,
        _EchoEntry(
          alias: alias,
          sign: _sign,
          essence: essence,
          timestamp: DateTime.now(),
        ),
      );
      _essenceCtrl.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.cosmicSentSnack),
      ),
    );
  }
}

// ─── Sign picker tile ───────────────────────────────────────────────────────
class _SignPicker extends StatelessWidget {
  const _SignPicker({required this.sign, required this.onTap});
  final _SignOption sign;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        splashColor: AstroColors.red.withValues(alpha: 0.06),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          decoration: BoxDecoration(
            color: AstroColors.card,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AstroColors.border, width: 0.8),
          ),
          child: Row(
            children: [
              Text(
                sign.symbol,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  ZodiacLocalization.name(context, sign.id),
                  style: AstroText.body(size: 15),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AstroColors.gold,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Echo tile ──────────────────────────────────────────────────────────────
class _EchoTile extends StatelessWidget {
  const _EchoTile({required this.entry});
  final _EchoEntry entry;

  @override
  Widget build(BuildContext context) {
    final time = '${entry.timestamp.hour.toString().padLeft(2, '0')}:'
        '${entry.timestamp.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: alias · sign · time
          Row(
            children: [
              Text(entry.alias, style: AstroText.resultLabel()),
              const SizedBox(width: 8),
              Text(
                '${entry.sign.symbol} ${ZodiacLocalization.name(context, entry.sign.id)}',
                style: AstroText.body(size: 11).copyWith(color: AstroColors.mid),
              ),
              const Spacer(),
              Text(time, style: AstroText.caption()),
            ],
          ),
          const SizedBox(height: 8),
          // Essence quote
          Text('"${entry.essence}"', style: AstroText.bodyMuted(size: 13)),
          const SizedBox(height: 14),
          // Separator
          Container(height: 0.5, color: AstroColors.divider),
        ],
      ),
    );
  }
}
