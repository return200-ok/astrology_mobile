import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';

import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

// ─── Palette (Ink Wash / Parchment) ──────────────────────────────────────────
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

// ─── Page ─────────────────────────────────────────────────────────────────────
class CosmicVoidPage extends StatefulWidget {
  const CosmicVoidPage({super.key});

  @override
  State<CosmicVoidPage> createState() => _CosmicVoidPageState();
}

class _CosmicVoidPageState extends State<CosmicVoidPage> {
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
    final vi = Localizations.localeOf(context).languageCode == 'vi';

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

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 8, 28, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Header ──────────────────────────────────────────────
                      Text(
                        vi ? 'Cosmic Void' : 'Cosmic Void',
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
                      Text(
                        l10n.cosmicVoidSubtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          color: _P.mid,
                          fontSize: 10,
                          letterSpacing: 2.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // ── Alias field ─────────────────────────────────────────
                      _fieldLabel(l10n.cosmicSpiritAlias),
                      const SizedBox(height: 8),
                      _pillField(
                        controller: _aliasCtrl,
                        hint: l10n.cosmicSpiritPlaceholder,
                      ),

                      const SizedBox(height: 20),

                      // ── Sign picker ─────────────────────────────────────────
                      _fieldLabel(l10n.cosmicCelestialSign),
                      const SizedBox(height: 8),
                      _SignPicker(
                        sign: _sign,
                        onTap: _pickSign,
                      ),

                      const SizedBox(height: 20),

                      // ── Essence textarea ────────────────────────────────────
                      _fieldLabel(l10n.cosmicSpiritualEssence),
                      const SizedBox(height: 8),
                      _essenceField(l10n),

                      const SizedBox(height: 28),

                      // ── Send button ─────────────────────────────────────────
                      _SendButton(
                        label: l10n.cosmicWhisperToVoid,
                        onTap: () => _sendWhisper(l10n),
                      ),

                      const SizedBox(height: 36),

                      // ── Thin separator ──────────────────────────────────────
                      Container(
                        height: 0.5,
                        color: _P.divider,
                      ),

                      const SizedBox(height: 24),

                      // ── Echoes section ──────────────────────────────────────
                      _echoHeader(l10n),
                      const SizedBox(height: 16),

                      if (_echoes.isEmpty)
                        _emptyState(l10n)
                      else
                        ..._echoes.map((e) => _EchoTile(entry: e)),
                    ],
                  ),
                ),
              ),

              // ── Bottom bar ──────────────────────────────────────────────────
              _BottomBar(echoCount: _echoes.length),
            ],
          ),
        ),
      ),
    );
  }

  // ── Field label ──────────────────────────────────────────────────────────────
  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.cinzel(
        color: _P.ink,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.0,
      ),
    );
  }

  // ── Pill text field ──────────────────────────────────────────────────────────
  Widget _pillField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.inter(
        color: _P.ink,
        fontSize: 15,
      ),
      cursorColor: _P.red,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: _P.light,
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        filled: true,
        fillColor: _P.sheet,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: _P.border),
          borderRadius: BorderRadius.circular(999),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _P.red.withValues(alpha: 0.70), width: 1.2),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  // ── Essence textarea ─────────────────────────────────────────────────────────
  Widget _essenceField(AppLocalizations l10n) {
    return TextField(
      controller: _essenceCtrl,
      minLines: 4,
      maxLines: 6,
      style: GoogleFonts.inter(
        color: _P.ink,
        fontSize: 14,
        height: 1.6,
        fontStyle: FontStyle.italic,
      ),
      cursorColor: _P.red,
      decoration: InputDecoration(
        hintText: l10n.cosmicWhisperHint,
        hintStyle: GoogleFonts.inter(
          color: _P.light,
          fontSize: 14,
          fontStyle: FontStyle.italic,
        ),
        contentPadding: const EdgeInsets.all(20),
        filled: true,
        fillColor: _P.sheet,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: _P.border),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _P.red.withValues(alpha: 0.70), width: 1.2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  // ── Echo header ──────────────────────────────────────────────────────────────
  Widget _echoHeader(AppLocalizations l10n) {
    return Text(
      l10n.cosmicEchoesTitle,
      style: GoogleFonts.cinzel(
        color: _P.mid,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.0,
      ),
    );
  }

  // ── Empty state ──────────────────────────────────────────────────────────────
  Widget _emptyState(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Text(
            l10n.cosmicSilentPrimary,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: _P.light,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.cosmicSilentSecondary,
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              color: _P.light,
              fontSize: 9,
              letterSpacing: 3.0,
            ),
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
          decoration: const BoxDecoration(
            color: _P.sheet,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(20)),
            border: Border(
              top: BorderSide(color: _P.border),
              left: BorderSide(color: _P.border),
              right: BorderSide(color: _P.border),
            ),
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
                    bottom: BorderSide(color: _P.divider),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'CELESTIAL SIGN',
                      style: GoogleFonts.cinzel(
                        color: _P.ink,
                        fontSize: 11,
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
                          border:
                              Border.all(color: _P.red.withValues(alpha: 0.18)),
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
    if (picked != null && mounted) setState(() => _sign = picked);
  }

  // ── Send whisper ─────────────────────────────────────────────────────────────
  void _sendWhisper(AppLocalizations l10n) {
    final alias = _aliasCtrl.text.trim();
    final essence = _essenceCtrl.text.trim();
    if (alias.isEmpty || essence.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.cosmicFillRequiredSnack),
          backgroundColor: _P.ink,
        ),
      );
      return;
    }
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
        backgroundColor: _P.ink,
      ),
    );
  }
}

// ─── Sign picker tile ─────────────────────────────────────────────────────────
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
        splashColor: _P.red.withValues(alpha: 0.10),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: _P.card,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: _P.border),
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
                  style: GoogleFonts.inter(
                    color: _P.ink,
                    fontSize: 15,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: _P.light,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Outlined accent button ──────────────────────────────────────────────────
class _SendButton extends StatelessWidget {
  const _SendButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: _P.red, width: 1.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        label,
        style: GoogleFonts.cinzel(
          color: _P.red,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}

// ─── Echo tile (no card frame) ────────────────────────────────────────────────
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
              Text(
                entry.alias,
                style: GoogleFonts.cinzel(
                  color: _P.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${entry.sign.symbol} ${ZodiacLocalization.name(context, entry.sign.id)}',
                style: GoogleFonts.inter(
                  color: _P.light,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              Text(
                time,
                style: GoogleFonts.inter(
                  color: _P.light,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Essence quote
          Text(
            '"${entry.essence}"',
            style: GoogleFonts.inter(
              color: _P.mid,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          // Separator
          Container(height: 0.5, color: _P.divider),
        ],
      ),
    );
  }
}

// ─── Bottom bar ───────────────────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.echoCount});
  final int echoCount;

  @override
  Widget build(BuildContext context) {
    final vi = Localizations.localeOf(context).languageCode == 'vi';
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                '$echoCount ${vi ? "tiếng vọng" : "echoes"}',
                style: GoogleFonts.inter(
                  color: _P.light,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              Text(
                vi ? 'đang lắng nghe...' : 'listening...',
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
              value: echoCount > 0 ? 1.0 : 0.0,
              minHeight: 3,
              backgroundColor: _P.iconBg,
              color: _P.red.withValues(alpha: 0.70),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'COSMIC VOID',
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
