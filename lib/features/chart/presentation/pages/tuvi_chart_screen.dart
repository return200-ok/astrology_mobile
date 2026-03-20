import 'package:flutter/material.dart';
import '../widgets/house_card.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

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
      appBar: AppBar(
        title: const Text('Bảng Lá Số'),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              _transformController.value = Matrix4.identity();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Info section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.02),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ngày: ${widget.birthDate.day}/${widget.birthDate.month}/${widget.birthDate.year} - '
                    'Giờ: ${widget.birthTime.hour.toString().padLeft(2, '0')}:${widget.birthTime.minute.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
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
                              color: Colors.white.withOpacity(0.1),
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
      backgroundColor: const Color(0xFF1a1a2e).withOpacity(0.95),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              houseNames[houseIndex],
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: elementColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 16),
            if (stars.isEmpty)
              Text(
                'Không có sao',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: stars
                    .map((star) => Chip(
                          label: Text(star),
                          backgroundColor: elementColor.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color: elementColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text('Đóng'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
