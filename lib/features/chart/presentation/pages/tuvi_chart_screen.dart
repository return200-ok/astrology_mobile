import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/house_card.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

// ─── Palette (Ink Wash / Parchment) ──────────────────────────────────────────
abstract final class _P {
  static const ink    = Color(0xFF1A1A1A);
  static const mid    = Color(0xFF5C5C5C);
  static const red    = Color(0xFF8B3A3A);
  static const card   = Color(0xFFFBF8F3);
  static const border = Color(0xFFCDC5B8);
  static const sheet  = Color(0xFFF2EDE4);
}

class TuViChartScreen extends StatefulWidget {
  final String name;
  final DateTime birthDate;
  final TimeOfDay birthTime;
  final Map<int, List<String>> palaceStars;

  const TuViChartScreen({
    Key? key,
    required this.name,
    required this.birthDate,
    required this.birthTime,
    required this.palaceStars,
  }) : super(key: key);

  @override
  State<TuViChartScreen> createState() => _TuViChartScreenState();
}

class _TuViChartScreenState extends State<TuViChartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  int? _selectedHouseIndex;
  final TransformationController _transformController =
      TransformationController();

  static const List<String> houseNames = [
    'Mệnh',
    'Phụ Mẫu',
    'Phúc Đức',
    'Điền Trạch',
    'Quan Lộc',
    'Nô Bộc',
    'Thiên Di',
    'Tật Ách',
    'Tài Bạch',
    'Tử Tức',
    'Phu Thê',
    'Huynh Đệ',
  ];

  static const Map<int, int> gridIndexMap = {
    0: 0,   // Mệnh
    1: 1,   // Phụ mẫu
    2: 2,   // Phúc đức
    3: 3,   // Điền trạch
    4: 11,  // Huynh đệ
    7: 4,   // Quan lộc
    8: 10,  // Phu thê
    11: 5,  // Nô bộc
    12: 9,  // Tử tức
    13: 8,  // Tài bạch
    14: 7,  // Tật ách
    15: 6,  // Thiên di
  };

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _transformController.dispose();
    super.dispose();
  }

  Color _getElementColor(int houseIndex) {
    final elements = AstroTheme.elementColors;
    final elementIndex = houseIndex % elements.length;
    return elements.values.toList()[elementIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            children: [
              // ── Custom header row ───────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: _P.ink,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Bảng Lá Số',
                        style: GoogleFonts.cinzel(
                          color: _P.ink,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.zoom_out, color: _P.mid),
                      onPressed: () {
                        _transformController.value = Matrix4.identity();
                      },
                    ),
                  ],
                ),
              ),

              // Info section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _P.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _P.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: GoogleFonts.cinzel(
                          color: _P.ink,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ngày: ${widget.birthDate.day}/${widget.birthDate.month}/${widget.birthDate.year} - '
                        'Giờ: ${widget.birthTime.hour.toString().padLeft(2, '0')}:${widget.birthTime.minute.toString().padLeft(2, '0')}',
                        style: GoogleFonts.inter(
                          color: _P.mid,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Chart grid with zoom/pan
              Expanded(
                child: FadeTransition(
                  opacity: CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
                  child: InteractiveViewer(
                    boundaryMargin: const EdgeInsets.all(100),
                    minScale: 0.8,
                    maxScale: 2.5,
                    transformationController: _transformController,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: 16,
                        itemBuilder: (context, gridIndex) {
                          if (!gridIndexMap.containsKey(gridIndex)) {
                            // Empty center cells
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _P.border,
                                ),
                              ),
                            );
                          }

                          final houseIndex = gridIndexMap[gridIndex]!;
                          final stars = widget.palaceStars[houseIndex] ?? [];
                          final elementColor = _getElementColor(houseIndex);

                          return HouseCard(
                            houseIndex: houseIndex,
                            houseName: houseNames[houseIndex],
                            stars: stars,
                            elementColor: elementColor,
                            isSelected: _selectedHouseIndex == houseIndex,
                            onTap: () {
                              setState(() {
                                _selectedHouseIndex = houseIndex;
                                _showHouseDetail(context, houseIndex, stars, elementColor);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHouseDetail(
    BuildContext context,
    int houseIndex,
    List<String> stars,
    Color elementColor,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _P.sheet,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              houseNames[houseIndex],
              style: GoogleFonts.cinzel(
                color: elementColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            if (stars.isEmpty)
              Text(
                'Không có sao',
                style: GoogleFonts.inter(
                  color: _P.mid,
                  fontSize: 14,
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: stars
                    .map((star) => Chip(
                          label: Text(star),
                          backgroundColor: elementColor.withValues(alpha: 0.15),
                          side: BorderSide(color: elementColor.withValues(alpha: 0.25)),
                          labelStyle: TextStyle(
                            color: elementColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: _P.red, width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  'Đóng',
                  style: GoogleFonts.cinzel(
                    color: _P.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
