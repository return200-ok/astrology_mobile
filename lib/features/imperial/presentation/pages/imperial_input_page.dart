import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/models/imperial_cast_request.dart';
import '../widgets/imperial_starfield_background.dart';
import 'imperial_result_page.dart';

class ImperialInputPage extends StatefulWidget {
  const ImperialInputPage({super.key});

  @override
  State<ImperialInputPage> createState() => _ImperialInputPageState();
}

class _ImperialInputPageState extends State<ImperialInputPage> {
  static const Color _gold = Color(0xFFFFD438);
  static const Color _panel = Color(0xFF252067);
  final TextEditingController _spiritController = TextEditingController();

  DateTime? _arrivalDay;
  String _streamHour = 'Tý';

  final List<String> _branches = const [
    'Tý',
    'Sửu',
    'Dần',
    'Mão',
    'Thìn',
    'Tỵ',
    'Ngọ',
    'Mùi',
    'Thân',
    'Dậu',
    'Tuất',
    'Hợi',
  ];

  @override
  void dispose() {
    _spiritController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: ImperialStarfieldBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 30),
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
                _buildTitle(context),
                const SizedBox(height: 20),
                _ImperialTabs(
                  selectedIndex: 0,
                  tabs: [
                    l10n.imperialTabChart,
                    l10n.imperialTabCompatibility,
                    l10n.imperialTabCalendar,
                  ],
                  onTap: (index) {
                    if (index != 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.featureComingSoon)),
                      );
                    }
                  },
                ),
                const SizedBox(height: 28),
                _buildFormCard(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 430 ? 52.0 : width < 900 ? 68.0 : 78.0;
    final subtitleSize = width < 430 ? 12.0 : 16.0;
    final subtitleSpacing = width < 430 ? 2.2 : 4.6;

    return Column(
      children: [
        Text(
          l10n.imperialTitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.cormorantGaramond(
            color: _gold,
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            letterSpacing: 2.4,
            shadows: [
              Shadow(
                color: _gold.withOpacity(0.35),
                blurRadius: 14,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.imperialSubtitle,
          style: GoogleFonts.cinzel(
            color: _gold.withOpacity(0.65),
            fontSize: subtitleSize,
            letterSpacing: subtitleSpacing,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormCard(AppLocalizations l10n) {
    return Container(
      width: 760,
      constraints: const BoxConstraints(maxWidth: 760),
      padding: const EdgeInsets.fromLTRB(26, 28, 26, 30),
      decoration: BoxDecoration(
        color: _panel.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _gold.withOpacity(0.45)),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.18),
            blurRadius: 22,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(l10n.imperialSpiritId),
          const SizedBox(height: 8),
          _textInput(
            controller: _spiritController,
            hint: '',
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final narrow = constraints.maxWidth < 620;
              if (narrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label(l10n.imperialArrivalDay),
                    const SizedBox(height: 8),
                    _dateInput(),
                    const SizedBox(height: 14),
                    _label(l10n.imperialStreamsHour),
                    const SizedBox(height: 8),
                    _hourInput(),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label(l10n.imperialArrivalDay),
                        const SizedBox(height: 8),
                        _dateInput(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label(l10n.imperialStreamsHour),
                        const SizedBox(height: 8),
                        _hourInput(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 26),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _castStars,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF9E8B2D),
                foregroundColor: const Color(0xFF1D184C),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              icon: const Icon(Icons.explore_outlined),
              label: Text(
                l10n.imperialCastStars,
                style: GoogleFonts.cinzel(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.8,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.cinzel(
        color: _gold,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
      ),
    );
  }

  Widget _textInput({required TextEditingController controller, required String hint}) {
    return TextField(
      controller: controller,
      style: GoogleFonts.cinzel(
        color: _gold,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.cormorantGaramond(
          color: _gold.withOpacity(0.45),
          fontSize: 22,
          fontStyle: FontStyle.italic,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _gold.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(999),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _gold.withOpacity(0.9), width: 1.2),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  Widget _dateInput() {
    final l10n = AppLocalizations.of(context)!;
    final dateText = _arrivalDay == null
        ? l10n.imperialDatePlaceholder
        : DateFormat('MM/dd/yyyy').format(_arrivalDay!);
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: _pickDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          border: Border.all(color: _gold.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                dateText,
                style: GoogleFonts.cormorantGaramond(
                  color: _gold,
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Icon(Icons.calendar_month_outlined, color: _gold, size: 19),
          ],
        ),
      ),
    );
  }

  Widget _hourInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        border: Border.all(color: _gold.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _streamHour,
          isExpanded: true,
          iconEnabledColor: _gold,
          dropdownColor: const Color(0xFF252067),
          style: GoogleFonts.cinzel(
            color: _gold,
            fontSize: 16,
          ),
          items: _branches
              .map(
                (branch) => DropdownMenuItem<String>(
                  value: branch,
                  child: Text(branch),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _streamHour = value;
            });
          },
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _arrivalDay ?? now,
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year + 2),
    );
    if (picked == null) return;
    setState(() {
      _arrivalDay = picked;
    });
  }

  void _castStars() {
    final l10n = AppLocalizations.of(context)!;
    final spiritId = _spiritController.text.trim();
    if (spiritId.isEmpty || _arrivalDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.imperialFillRequiredSnack)),
      );
      return;
    }

    final request = ImperialCastRequest(
      spiritId: spiritId,
      arrivalDay: _arrivalDay!,
      streamHour: _streamHour,
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ImperialResultPage(request: request),
      ),
    );
  }
}

class _ImperialTabs extends StatelessWidget {
  const _ImperialTabs({
    required this.selectedIndex,
    required this.tabs,
    required this.onTap,
  });

  final int selectedIndex;
  final List<String> tabs;
  final ValueChanged<int> onTap;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 760,
      constraints: const BoxConstraints(maxWidth: 760),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1A174D),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _gold.withOpacity(0.55)),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final active = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: active ? _gold : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: active ? const Color(0xFF1C184A) : Colors.white70,
                    fontSize: 14,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
