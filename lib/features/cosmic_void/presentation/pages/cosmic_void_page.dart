import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';

import '../widgets/cosmic_void_starfield_background.dart';

// ─── Colors (đồng bộ Big Five style) ─────────────────────────────────────────
const Color _kBg = Color(0xFF070910);
const Color _kGold = Color(0xFFD4AF37);
const Color _kTeal = Color(0xFF00BDA4);
const Color _kBorder = Color(0xFF2A2860);

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
      backgroundColor: _kBg,
      body: CosmicVoidStarfieldBackground(
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
                        style: GoogleFonts.cormorantGaramond(
                          color: _kGold,
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          height: 1.0,
                          letterSpacing: 3.0,
                          shadows: [
                            Shadow(
                              color: _kGold.withOpacity(0.45),
                              blurRadius: 22,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.cosmicVoidSubtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          color: _kGold.withOpacity(0.50),
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
                      _TealButton(
                        label: l10n.cosmicWhisperToVoid,
                        onTap: () => _sendWhisper(l10n),
                      ),

                      const SizedBox(height: 36),

                      // ── Thin separator ──────────────────────────────────────
                      Container(
                        height: 0.5,
                        color: Colors.white.withOpacity(0.07),
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
        color: _kGold,
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
        color: Colors.white.withOpacity(0.90),
        fontSize: 15,
      ),
      cursorColor: _kTeal,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: Colors.white.withOpacity(0.25),
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        filled: true,
        fillColor: Colors.white.withOpacity(0.04),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _kBorder.withOpacity(0.80)),
          borderRadius: BorderRadius.circular(999),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _kTeal.withOpacity(0.70), width: 1.2),
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
        color: Colors.white.withOpacity(0.88),
        fontSize: 14,
        height: 1.6,
        fontStyle: FontStyle.italic,
      ),
      cursorColor: _kTeal,
      decoration: InputDecoration(
        hintText: l10n.cosmicWhisperHint,
        hintStyle: GoogleFonts.inter(
          color: Colors.white.withOpacity(0.22),
          fontSize: 14,
          fontStyle: FontStyle.italic,
        ),
        contentPadding: const EdgeInsets.all(20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.04),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _kBorder.withOpacity(0.80)),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _kTeal.withOpacity(0.70), width: 1.2),
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
        color: _kGold.withOpacity(0.70),
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
              color: Colors.white.withOpacity(0.30),
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
              color: Colors.white.withOpacity(0.15),
              fontSize: 9,
              letterSpacing: 3.0,
            ),
          ),
        ],
      ),
    );
  }

  // ── Sign picker sheet ────────────────────────────────────────────────────────
  Future<void> _pickSign() async {
    var idx = _kSigns.indexOf(_sign).clamp(0, _kSigns.length - 1);
    final picked = await showModalBottomSheet<_SignOption>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: const Color(0xFF0E1020).withOpacity(0.98),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: _kTeal.withOpacity(0.25)),
          ),
          child: Column(
            children: [
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0D18),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(
                    bottom: BorderSide(color: _kTeal.withOpacity(0.18)),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'CELESTIAL SIGN',
                      style: GoogleFonts.cinzel(
                        color: _kGold.withOpacity(0.80),
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
                          color: _kTeal,
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
                          color: _kTeal.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: _kTeal.withOpacity(0.18)),
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
          backgroundColor: const Color(0xFF0E1020),
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
        backgroundColor: const Color(0xFF0E1020),
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
        splashColor: _kTeal.withOpacity(0.10),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: _kBorder.withOpacity(0.80)),
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
                    color: Colors.white.withOpacity(0.90),
                    fontSize: 15,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: _kGold.withOpacity(0.55),
                size: 22,
              ),
            ],
          ),
        ),
      ),
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: const LinearGradient(
              colors: [Color(0xFF00C9AE), Color(0xFF00897B)],
            ),
            boxShadow: [
              BoxShadow(
                color: _kTeal.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.cinzel(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
              ),
            ),
          ),
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
                  color: _kGold,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${entry.sign.symbol} ${ZodiacLocalization.name(context, entry.sign.id)}',
                style: GoogleFonts.inter(
                  color: Colors.white38,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              Text(
                time,
                style: GoogleFonts.inter(
                  color: Colors.white24,
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
              color: Colors.white.withOpacity(0.55),
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          // Separator
          Container(height: 0.5, color: Colors.white.withOpacity(0.07)),
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
                  color: Colors.white24,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              Text(
                vi ? 'đang lắng nghe...' : 'listening...',
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
              value: echoCount > 0 ? 1.0 : 0.0,
              minHeight: 3,
              backgroundColor: Colors.white.withOpacity(0.08),
              color: _kTeal,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'COSMIC VOID',
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
