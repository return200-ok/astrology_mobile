import 'package:flutter/material.dart';
import 'tuvi_chart_screen.dart';
import '../../domain/models/birth_profile.dart';
import '../../data/providers/chart_provider.dart';
import '../../../../astro_engine/chart_builder.dart' as engine;

class ChartDisplayPage extends StatefulWidget {
  final String name;
  final DateTime birthDate;
  final TimeOfDay birthTime;
  final int cucNumber;

  const ChartDisplayPage({
    Key? key,
    required this.name,
    required this.birthDate,
    required this.birthTime,
    required this.cucNumber,
  }) : super(key: key);

  @override
  State<ChartDisplayPage> createState() => _ChartDisplayPageState();
}

class _ChartDisplayPageState extends State<ChartDisplayPage> {
  Map<int, List<String>>? _palaceStars;
  String? _error;

  @override
  void initState() {
    super.initState();
    try {
      final profile = BirthProfile(
        name: widget.name,
        birthDate: widget.birthDate,
        birthTime: widget.birthTime,
        gender: '',
        cuc: widget.cucNumber,
      );
      final birthData = birthDataFromProfile(profile);
      final chart = engine.generateChart(birthData);
      _palaceStars = chart.houses;
    } catch (e) {
      _error = 'Không thể tính toán lá số. Vui lòng kiểm tra lại thông tin sinh.';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lá Số Tử Vi')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Quay lại'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return TuViChartScreen(
      name: widget.name,
      birthDate: widget.birthDate,
      birthTime: widget.birthTime,
      palaceStars: _palaceStars!,
    );
  }
}