import 'package:flutter/material.dart';
import 'tuvi_chart_screen.dart';

class ChartDisplayPage extends StatefulWidget {
  final String name;
  final DateTime birthDate;
  final TimeOfDay birthTime;

  const ChartDisplayPage({
    Key? key,
    required this.name,
    required this.birthDate,
    required this.birthTime,
  }) : super(key: key);

  @override
  State<ChartDisplayPage> createState() => _ChartDisplayPageState();
}

class _ChartDisplayPageState extends State<ChartDisplayPage> {
  // Mock palace stars data - will be replaced with actual engine calculation
  final Map<int, List<String>> _mockPalaceStars = {
    0: ['Tử Vệ', 'Thiên Cơ'],           // Mệnh
    1: ['Tham Lang'],                     // Phụ Mẫu
    2: ['Thiên Phúc'],                    // Phúc Đức
    3: ['Thiên Tài'],                     // Điền Trạch
    4: ['Quan Lộc', 'Thiên Quân'],        // Quan Lộc
    5: ['Nô Bộc', 'Thiên Ủy'],            // Nô Bộc
    6: ['Thiên Di', 'Văn Khúc'],           // Thiên Di
    7: ['Tật Ách', 'Hỏa Tinh'],           // Tật Ách
    8: ['Tài Bạch', 'Thực Quân'],         // Tài Bạch
    9: ['Tử Tức'],                        // Tử Tức
    10: ['Phu Thê', 'Thiên Hành'],        // Phu Thê
    11: ['Huynh Đệ'],                     // Huynh Đệ
  };

  @override
  Widget build(BuildContext context) {
    return TuViChartScreen(
      name: widget.name,
      birthDate: widget.birthDate,
      birthTime: widget.birthTime,
      palaceStars: _mockPalaceStars,
    );
  }}