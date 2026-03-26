import 'package:flutter/material.dart';
import 'star_chip.dart';

// ─── Palette (Ink Wash / Parchment) ──────────────────────────────────────────
abstract final class _P {
  static const ink    = Color(0xFF1A1A1A);
  static const card   = Color(0xFFFBF8F3);
  static const border = Color(0xFFCDC5B8);
  static const sheet  = Color(0xFFF2EDE4);
}

class HouseCard extends StatelessWidget {
  final int houseIndex;
  final String houseName;
  final List<String> stars;
  final Color elementColor;
  final bool isSelected;
  final VoidCallback onTap;

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

  const HouseCard({
    Key? key,
    required this.houseIndex,
    required this.houseName,
    required this.stars,
    required this.elementColor,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? _P.sheet : _P.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? elementColor : _P.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                houseName,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: elementColor,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: stars
                        .map((star) => StarChip(
                          starName: star,
                          elementColor: elementColor,
                        ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
