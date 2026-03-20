import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/models/imperial_cast_request.dart';
import '../widgets/imperial_starfield_background.dart';

class ImperialResultPage extends StatelessWidget {
  const ImperialResultPage({super.key, required this.request});

  final ImperialCastRequest request;
  static const Color _gold = Color(0xFFFFD438);

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
                    onPressed: () => Navigator.of(context).pop(),
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
                const SizedBox(height: 24),
                _ImperialChartBoard(request: request),
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
}

class _ImperialChartBoard extends StatelessWidget {
  const _ImperialChartBoard({required this.request});

  final ImperialCastRequest request;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final boardHeight = MediaQuery.sizeOf(context).width < 700 ? 520.0 : 620.0;
    final palaces = _palaceData();

    return Container(
      width: 920,
      constraints: const BoxConstraints(maxWidth: 920),
      height: boardHeight,
      decoration: BoxDecoration(
        color: const Color(0xFF100F42).withOpacity(0.92),
        border: Border.all(color: _gold.withOpacity(0.55), width: 1.4),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.20),
            blurRadius: 16,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const border = 1.0;
          final cw = (constraints.maxWidth - (border * 3)) / 4;
          final ch = (constraints.maxHeight - (border * 3)) / 4;

          return Stack(
            children: [
              ...palaces.map(
                (palace) => Positioned(
                  left: palace.col * (cw + border),
                  top: palace.row * (ch + border),
                  width: cw,
                  height: ch,
                  child: _PalaceCell(data: palace),
                ),
              ),
              Positioned(
                left: (cw + border),
                top: (ch + border),
                width: (cw * 2) + border,
                height: (ch * 2) + border,
                child: _CenterIdentityCard(request: request),
              ),
            ],
          );
        },
      ),
    );
  }

  List<_PalaceData> _palaceData() {
    return const [
      _PalaceData(row: 0, col: 0, title: 'TỬ TỨC', stars: ['THIÊN PHỦ']),
      _PalaceData(
        row: 0,
        col: 1,
        title: 'PHU THÊ',
        stars: ['TỬ VI', 'THÁI DƯƠNG', 'THAM LANG', 'THẤT SÁT'],
      ),
      _PalaceData(row: 0, col: 2, title: 'HUYNH ĐỆ', stars: ['THIÊN TƯỚNG']),
      _PalaceData(row: 0, col: 3, title: 'MỆNH', stars: ['VŨ KHÚC']),
      _PalaceData(row: 1, col: 0, title: 'TÀI BẠCH', stars: ['THIÊN LƯƠNG']),
      _PalaceData(
        row: 1,
        col: 3,
        title: 'PHỤ MẪU',
        stars: ['LIÊM TRINH', 'THIÊN CƠ', 'CỰ MÔN', 'PHÁ QUÂN'],
      ),
      _PalaceData(row: 2, col: 0, title: 'TẬT ÁCH', stars: ['THIÊN ĐỒNG']),
      _PalaceData(row: 2, col: 3, title: 'PHÚC ĐỨC', stars: ['THÁI ÂM']),
      _PalaceData(row: 3, col: 0, title: 'THIÊN DI', stars: ['THAM TÀI']),
      _PalaceData(row: 3, col: 1, title: 'NÔ BỘC', stars: ['VĂN KHÚC']),
      _PalaceData(row: 3, col: 2, title: 'QUAN LỘC', stars: ['VĂN XƯƠNG']),
      _PalaceData(row: 3, col: 3, title: 'ĐIỀN TRẠCH', stars: ['THIÊN KHÔI']),
    ];
  }
}

class _PalaceCell extends StatelessWidget {
  const _PalaceCell({required this.data});

  final _PalaceData data;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0B34),
        border: Border.all(color: _gold.withOpacity(0.28), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            style: GoogleFonts.cinzel(
              color: _gold,
              fontSize: 10,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          ...data.stars.map(
            (star) => Text(
              star,
              style: GoogleFonts.cinzel(
                color: _starColor(star),
                fontSize: 10,
                height: 1.25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _starColor(String star) {
    if (star == 'THÁI DƯƠNG' || star == 'LIÊM TRINH') {
      return const Color(0xFFFF4B4B);
    }
    if (star == 'THAM LANG' || star == 'THIÊN CƠ' || star == 'CỰ MÔN') {
      return const Color(0xFF4FCBFF);
    }
    return Colors.white;
  }
}

class _CenterIdentityCard extends StatelessWidget {
  const _CenterIdentityCard({required this.request});

  final ImperialCastRequest request;
  static const Color _gold = Color(0xFFFFD438);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final solar = DateFormat('M/d/yyyy').format(request.arrivalDay);
    final lunar = '${request.arrivalDay.month}/${request.arrivalDay.year}';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF232164),
        border: Border.all(color: _gold.withOpacity(0.72), width: 1.4),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  request.spiritId.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _gold,
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              '${l10n.imperialSolarPrefix}: $solar',
              style: GoogleFonts.cinzel(
                color: _gold.withOpacity(0.7),
                fontSize: 11,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${l10n.imperialLunarPrefix}: $lunar',
              style: GoogleFonts.cinzel(
                color: _gold.withOpacity(0.7),
                fontSize: 11,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${l10n.imperialHourPrefix}: ${request.streamHour}',
              style: GoogleFonts.cinzel(
                color: _gold.withOpacity(0.7),
                fontSize: 11,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
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

class _PalaceData {
  const _PalaceData({
    required this.row,
    required this.col,
    required this.title,
    required this.stars,
  });

  final int row;
  final int col;
  final String title;
  final List<String> stars;
}
