import 'package:flutter/material.dart';
import 'star_chip.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

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
          color: isSelected ? AstroColors.board : AstroColors.cardAlt,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? elementColor : AstroColors.border,
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
