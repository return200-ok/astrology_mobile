import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../chart/presentation/pages/chart_display_page.dart';

class ProfileInputPage extends StatefulWidget {
  const ProfileInputPage({Key? key}) : super(key: key);

  @override
  State<ProfileInputPage> createState() => _ProfileInputPageState();
}

class _ProfileInputPageState extends State<ProfileInputPage> {
  final _nameController = TextEditingController();
  DateTime? _birthDate;
  TimeOfDay? _birthTime;
  String _gender = 'male';
  int _cucNumber = 3;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _birthTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _birthTime = picked);
    }
  }

  void _submit() {
    if (_nameController.text.isEmpty || _birthDate == null || _birthTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }

    // Navigate to chart display
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChartDisplayPage(
          name: _nameController.text,
          birthDate: _birthDate!,
          birthTime: _birthTime!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhập Thông Tin Sinh'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name input
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Tên',
                hintText: 'Nhập tên của bạn',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Gender
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(label: Text('Nam'), value: 'male'),
                ButtonSegment(label: Text('Nữ'), value: 'female'),
                ButtonSegment(label: Text('Khác'), value: 'other'),
              ],
              selected: {_gender},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() => _gender = newSelection.first);
              },
            ),
            const SizedBox(height: 16),

            // Birth date
            ListTile(
              title: const Text('Ngày Sinh (Dương)'),
              subtitle: Text(
                _birthDate == null
                    ? 'Chọn ngày'
                    : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 12),

            // Birth time
            ListTile(
              title: const Text('Giờ Sinh'),
              subtitle: Text(
                _birthTime == null
                    ? 'Chọn giờ'
                    : '${_birthTime!.hour.toString().padLeft(2, '0')}:${_birthTime!.minute.toString().padLeft(2, '0')}',
              ),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            const SizedBox(height: 24),

            // Cục number selector
            Text(
              'Cục (Cách Định)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: List.generate(5, (i) {
                final cuc = i + 2;
                return FilterChip(
                  label: Text('Cục $cuc'),
                  selected: _cucNumber == cuc,
                  onSelected: (selected) {
                    if (selected) setState(() => _cucNumber = cuc);
                  },
                );
              }),
            ),
            const SizedBox(height: 32),

            // Submit button
            FilledButton.tonal(
              onPressed: _submit,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Xem Bảng Lá Số',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
