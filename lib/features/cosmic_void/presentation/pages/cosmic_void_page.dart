import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/i18n/zodiac_localization.dart';

import '../widgets/cosmic_void_starfield_background.dart';

class CosmicVoidPage extends StatefulWidget {
  const CosmicVoidPage({super.key});

  @override
  State<CosmicVoidPage> createState() => _CosmicVoidPageState();
}

class _CosmicVoidPageState extends State<CosmicVoidPage> {
  static const Color _gold = Color(0xFFFFD438);
  static const Color _panel = Color(0xFF1D1A5F);

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

  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _essenceController = TextEditingController();
  final List<_EchoEntry> _echoes = [];

  _SignOption _selectedSign = _signs.firstWhere((s) => s.id == 'gemini');

  @override
  void dispose() {
    _aliasController.dispose();
    _essenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 58.0 : width < 900 ? 82.0 : 98.0;
    final subtitleSize = width < 430 ? 12.0 : 16.0;
    final subtitleSpacing = width < 430 ? 2.4 : 4.5;

    return Scaffold(
      body: CosmicVoidStarfieldBackground(
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
                  l10n.cosmicVoidTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(color: _gold.withOpacity(0.4), blurRadius: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.cosmicVoidSubtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _gold.withOpacity(0.64),
                    fontSize: subtitleSize,
                    letterSpacing: subtitleSpacing,
                  ),
                ),
                const SizedBox(height: 24),
                _buildCommunePanel(l10n),
                const SizedBox(height: 28),
                _buildEchoHeading(),
                const SizedBox(height: 12),
                _buildEchoBoard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommunePanel(AppLocalizations l10n) {
    final width = MediaQuery.sizeOf(context).width;
    final barSize = width < 430 ? 14.0 : 18.0;
    final buttonSize = width < 430 ? 18.0 : 24.0;

    return Container(
      width: 920,
      constraints: const BoxConstraints(maxWidth: 920),
      decoration: BoxDecoration(
        color: _panel.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _gold.withOpacity(0.44)),
        boxShadow: [
          BoxShadow(color: _gold.withOpacity(0.16), blurRadius: 20),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: const BoxDecoration(
              color: _gold,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.auto_awesome_rounded,
                  size: 18,
                  color: Color(0xFF1D1A5F),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.cosmicPanelTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cinzel(
                      color: const Color(0xFF1D1A5F),
                      fontSize: barSize,
                      letterSpacing: 1.6,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
            child: Column(
              children: [
                _buildTopFields(),
                const SizedBox(height: 16),
                _FieldLabel(text: l10n.cosmicSpiritualEssence),
                const SizedBox(height: 8),
                TextField(
                  controller: _essenceController,
                  minLines: 5,
                  maxLines: 6,
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold,
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: _fieldDecoration(
                    hint: l10n.cosmicWhisperHint,
                    hintSize: 30,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _sendWhisper,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF9D8A2D),
                      foregroundColor: const Color(0xFF1D1A5F),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    icon: const Icon(Icons.near_me_outlined, size: 20),
                    label: Text(
                      l10n.cosmicWhisperToVoid,
                      style: GoogleFonts.cinzel(
                        fontSize: buttonSize,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopFields() {
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 760;
        if (narrow) {
          return Column(
            children: [
              _fieldColumn(
                label: l10n.cosmicSpiritAlias,
                child: TextField(
                  controller: _aliasController,
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold,
                    fontSize: 30,
                  ),
                  decoration: _fieldDecoration(hint: l10n.cosmicSpiritPlaceholder, hintSize: 30),
                ),
              ),
              const SizedBox(height: 14),
              _fieldColumn(
                label: l10n.cosmicCelestialSign,
                child: _buildSignDropdown(),
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _fieldColumn(
                label: l10n.cosmicSpiritAlias,
                child: TextField(
                  controller: _aliasController,
                  style: GoogleFonts.cormorantGaramond(
                    color: _gold,
                    fontSize: 30,
                  ),
                  decoration: _fieldDecoration(hint: l10n.cosmicSpiritPlaceholder, hintSize: 30),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _fieldColumn(
                label: l10n.cosmicCelestialSign,
                child: _buildSignDropdown(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _fieldColumn({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(text: label),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildSignDropdown() {
    return DropdownButtonFormField<_SignOption>(
      value: _selectedSign,
      onChanged: (value) {
        if (value == null) return;
        setState(() => _selectedSign = value);
      },
      isExpanded: true,
      icon: Icon(Icons.expand_more_rounded, color: _gold.withOpacity(0.8)),
      dropdownColor: const Color(0xFF242067),
      style: GoogleFonts.cormorantGaramond(
        color: _gold,
        fontSize: 30,
        fontStyle: FontStyle.italic,
      ),
      decoration: _fieldDecoration(hint: '', hintSize: 30),
      items: _signs.map((sign) {
        return DropdownMenuItem<_SignOption>(
          value: sign,
          child: Text(
            '${sign.symbol} ${ZodiacLocalization.name(context, sign.id)}',
            style: GoogleFonts.cormorantGaramond(
              color: _gold,
              fontSize: 30,
            ),
          ),
        );
      }).toList(),
    );
  }

  InputDecoration _fieldDecoration({required String hint, required double hintSize}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.cormorantGaramond(
        color: _gold.withOpacity(0.5),
        fontSize: hintSize,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: _gold.withOpacity(0.52)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: _gold.withOpacity(0.9), width: 1.2),
      ),
    );
  }

  Widget _buildEchoHeading() {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 36.0 : width < 900 ? 44.0 : 52.0;

    return SizedBox(
      width: 920,
      child: Row(
        children: [
          Container(
            width: 6,
            height: 42,
            color: _gold.withOpacity(0.96),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.cosmicEchoesTitle,
              maxLines: 2,
              style: GoogleFonts.cormorantGaramond(
                color: _gold,
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEchoBoard() {
    return Container(
      width: 920,
      constraints: const BoxConstraints(maxWidth: 920, minHeight: 210),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _panel.withOpacity(0.45),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _gold.withOpacity(0.25),
        ),
      ),
      child: _echoes.isEmpty
          ? _buildSilentState()
          : Column(
              children: _echoes
                  .map(
                    (echo) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _EchoCard(entry: echo),
                    ),
                  )
                  .toList(),
            ),
    );
  }

  Widget _buildSilentState() {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 30.0 : 44.0;

    return SizedBox(
      height: 170,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.cosmicSilentPrimary,
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                color: _gold.withOpacity(0.56),
                fontSize: titleSize,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.cosmicSilentSecondary,
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                color: _gold.withOpacity(0.38),
                fontSize: 14,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendWhisper() {
    final l10n = AppLocalizations.of(context)!;
    final alias = _aliasController.text.trim();
    final essence = _essenceController.text.trim();

    if (alias.isEmpty || essence.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.cosmicFillRequiredSnack)),
      );
      return;
    }

    setState(() {
      _echoes.insert(
        0,
        _EchoEntry(
          alias: alias,
          sign: _selectedSign,
          essence: essence,
          timestamp: DateTime.now(),
        ),
      );
      _essenceController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.cosmicSentSnack)),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.cinzel(
        color: _gold.withOpacity(0.76),
        fontSize: 13,
        letterSpacing: 2.1,
      ),
    );
  }
}

class _EchoCard extends StatelessWidget {
  const _EchoCard({required this.entry});

  final _EchoEntry entry;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final time = '${entry.timestamp.hour.toString().padLeft(2, '0')}:'
        '${entry.timestamp.minute.toString().padLeft(2, '0')}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1A5D).withOpacity(0.94),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _gold.withOpacity(0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${entry.alias}  •  ${entry.sign.symbol} ${ZodiacLocalization.name(context, entry.sign.id)}',
                  style: GoogleFonts.cinzel(
                    color: _gold,
                    fontSize: 14,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                time,
                style: GoogleFonts.cinzel(
                  color: _gold.withOpacity(0.65),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '"${entry.essence}"',
            style: GoogleFonts.cormorantGaramond(
              color: _gold.withOpacity(0.92),
              fontSize: 30,
              fontStyle: FontStyle.italic,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

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

class _SignOption {
  const _SignOption({
    required this.id,
    required this.symbol,
  });

  final String id;
  final String symbol;
}
