import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';

import '../../domain/models/imperial_cast_request.dart';
import 'imperial_result_page.dart';

// ─── Palette ─────────────────────────────────────────────────────────────────
abstract final class _P {
  static const ink    = Color(0xFF1A1A1A);
  static const mid    = Color(0xFF5C5C5C);
  static const red    = Color(0xFF8B3A3A);
  static const card   = Color(0xFFFBF8F3);
  static const border = Color(0xFFCDC5B8);
  static const sheet  = Color(0xFFF2EDE4);  // bottom-sheet background
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class ImperialInputPage extends StatefulWidget {
  const ImperialInputPage({super.key});

  @override
  State<ImperialInputPage> createState() => _ImperialInputPageState();
}

class _ImperialInputPageState extends State<ImperialInputPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  DateTime? _birthDate;
  String _birthHour = 'Tý';

  static const List<String> _branches = [
    'Tý', 'Sửu', 'Dần', 'Mão', 'Thìn', 'Tỵ',
    'Ngọ', 'Mùi', 'Thân', 'Dậu', 'Tuất', 'Hợi',
  ];
  static const Map<String, String> _ranges = {
    'Tý': '23H - 1H',   'Sửu': '1H - 3H',   'Dần': '3H - 5H',
    'Mão': '5H - 7H',   'Thìn': '7H - 9H',  'Tỵ': '9H - 11H',
    'Ngọ': '11H - 13H', 'Mùi': '13H - 15H', 'Thân': '15H - 17H',
    'Dậu': '17H - 19H', 'Tuất': '19H - 21H', 'Hợi': '21H - 23H',
  };

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final w = MediaQuery.sizeOf(context).width;
    final titleSize = w < 430 ? 60.0 : 72.0;

    return Scaffold(
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Back button ─────────────────────────────────────────
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: _P.ink,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // ── Hero title ──────────────────────────────────────────
                Text(
                  l10n.imperialTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    color: _P.ink,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w600,
                    height: 1.05,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  l10n.imperialSubtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: _P.mid,
                    fontSize: 11,
                    letterSpacing: 3.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 40),

                // ── Celestial Identity ──────────────────────────────────
                _FieldLabel(text: l10n.imperialSpiritId),
                const SizedBox(height: 10),
                _NameField(controller: _nameCtrl, hint: l10n.imperialSpiritPlaceholder),

                const SizedBox(height: 22),

                // ── Date of Descent ─────────────────────────────────────
                _FieldLabel(text: l10n.imperialArrivalDay),
                const SizedBox(height: 10),
                _DateTile(
                  date: _birthDate,
                  placeholder: l10n.imperialDatePlaceholder,
                  onTap: _pickDate,
                ),

                const SizedBox(height: 22),

                // ── Hour of Destiny ─────────────────────────────────────
                _FieldLabel(text: l10n.imperialStreamsHour),
                const SizedBox(height: 10),
                _HourTile(
                  hour: _birthHour,
                  range: _ranges[_birthHour] ?? '',
                  onTap: _pickHour,
                ),

                const SizedBox(height: 48),

                // ── Cast Stars button ────────────────────────────────────
                _CastStarsButton(
                  label: l10n.imperialCastStars,
                  onTap: () => _submit(l10n),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Pickers ───────────────────────────────────────────────────────────────

  Future<void> _pickDate() async {
    final now  = DateTime.now();
    final init = _birthDate ?? DateTime(2000);
    var temp   = DateTime(init.year, init.month, init.day);

    final picked = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _DateSheet(
        initial: temp,
        onChanged: (d) => temp = d,
        onDone: () => Navigator.of(context).pop(temp),
        maxDate: DateTime(now.year + 2, 12, 31),
      ),
    );
    if (mounted && picked != null) setState(() => _birthDate = picked);
  }

  Future<void> _pickHour() async {
    final idx = _branches.indexOf(_birthHour).clamp(0, 11);
    var sel   = idx;
    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _HourSheet(
        branches: _branches,
        ranges: _ranges,
        initialIndex: idx,
        onChanged: (i) => sel = i,
        onDone: () => Navigator.of(context).pop(_branches[sel]),
      ),
    );
    if (mounted && picked != null) setState(() => _birthHour = picked);
  }

  // ── Submit ────────────────────────────────────────────────────────────────

  void _submit(AppLocalizations l10n) {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty || _birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.imperialFillRequiredSnack,
              style: GoogleFonts.inter(color: _P.card)),
          backgroundColor: _P.ink,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ImperialResultPage(
          request: ImperialCastRequest(
            spiritId: name,
            arrivalDay: _birthDate!,
            streamHour: _birthHour,
          ),
        ),
      ),
    );
  }
}

// ─── Field label ──────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.cinzel(
        color: _P.ink,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.0,
      ),
    );
  }
}

// ─── Name text field ──────────────────────────────────────────────────────────

class _NameField extends StatelessWidget {
  const _NameField({required this.controller, required this.hint});
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.cinzel(
        color: _P.ink,
        fontSize: 15,
        fontStyle: FontStyle.italic,
      ),
      cursorColor: _P.red,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.cinzel(
          color: _P.mid.withValues(alpha: 0.55),
          fontSize: 15,
          fontStyle: FontStyle.italic,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
        filled: true,
        fillColor: _P.card,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: _P.border, width: 0.8),
          borderRadius: BorderRadius.circular(999),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _P.red.withValues(alpha: 0.50), width: 1),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

// ─── Date tile ────────────────────────────────────────────────────────────────

class _DateTile extends StatelessWidget {
  const _DateTile({
    required this.date,
    required this.placeholder,
    required this.onTap,
  });
  final DateTime? date;
  final String placeholder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasDate = date != null;
    final txt = hasDate ? DateFormat('MM/dd/yyyy').format(date!) : placeholder;

    return _PillTile(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              txt,
              style: GoogleFonts.cinzel(
                color: hasDate ? _P.ink : _P.mid.withValues(alpha: 0.55),
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          // Calendar icon — red accent
          Icon(Icons.calendar_month_outlined,
              color: _P.red.withValues(alpha: 0.75), size: 20),
        ],
      ),
    );
  }
}

// ─── Hour tile ────────────────────────────────────────────────────────────────

class _HourTile extends StatelessWidget {
  const _HourTile({
    required this.hour,
    required this.range,
    required this.onTap,
  });
  final String hour;
  final String range;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _PillTile(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$hour ($range)',
              style: GoogleFonts.cinzel(
                color: _P.ink,
                fontSize: 15,
              ),
            ),
          ),
          Icon(Icons.unfold_more_rounded,
              color: _P.ink.withValues(alpha: 0.55), size: 22),
        ],
      ),
    );
  }
}

// ─── Generic pill tile ────────────────────────────────────────────────────────

class _PillTile extends StatelessWidget {
  const _PillTile({required this.child, required this.onTap});
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        splashColor: _P.red.withValues(alpha: 0.06),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
          decoration: BoxDecoration(
            color: _P.card,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: _P.border, width: 0.8),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─── Cast Stars button ────────────────────────────────────────────────────────

class _CastStarsButton extends StatelessWidget {
  const _CastStarsButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        splashColor: Colors.white.withValues(alpha: 0.08),
        child: Ink(
          height: 62,
          decoration: BoxDecoration(
            color: _P.ink,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Bagua watermark — muted red, very low opacity
              CustomPaint(
                size: const Size(52, 52),
                painter: _BaguaPainter(),
              ),
              // Label
              Text(
                label,
                style: GoogleFonts.cinzel(
                  color: InkWashBackground.parchment,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Bagua watermark ──────────────────────────────────────────────────────────

class _BaguaPainter extends CustomPainter {
  static const _red = Color(0xFF8B3A3A);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _red.withValues(alpha: 0.22)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r  = size.width / 2;

    canvas.drawCircle(Offset(cx, cy), r * 0.98, paint);
    canvas.drawCircle(Offset(cx, cy), r * 0.52, paint);
    canvas.drawCircle(Offset(cx, cy), r * 0.22, paint);

    for (var i = 0; i < 8; i++) {
      final angle   = (i * math.pi / 4) - math.pi / 2;
      final cos     = math.cos(angle);
      final sin     = math.sin(angle);
      for (var line = 0; line < 3; line++) {
        final lineR   = r * 0.60 + line * r * 0.11;
        final halfLen = r * 0.13;
        final isBroken = (i + line) % 2 == 1;
        if (isBroken) {
          canvas.drawLine(
            Offset(cx + cos * lineR - sin * halfLen * 0.9,
                   cy + sin * lineR + cos * halfLen * 0.9),
            Offset(cx + cos * lineR - sin * halfLen * 0.1,
                   cy + sin * lineR + cos * halfLen * 0.1),
            paint,
          );
          canvas.drawLine(
            Offset(cx + cos * lineR + sin * halfLen * 0.1,
                   cy + sin * lineR - cos * halfLen * 0.1),
            Offset(cx + cos * lineR + sin * halfLen * 0.9,
                   cy + sin * lineR - cos * halfLen * 0.9),
            paint,
          );
        } else {
          canvas.drawLine(
            Offset(cx + cos * lineR - sin * halfLen,
                   cy + sin * lineR + cos * halfLen),
            Offset(cx + cos * lineR + sin * halfLen,
                   cy + sin * lineR - cos * halfLen),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_BaguaPainter old) => false;
}

// ─── Date bottom sheet ────────────────────────────────────────────────────────

class _DateSheet extends StatelessWidget {
  const _DateSheet({
    required this.initial,
    required this.onChanged,
    required this.onDone,
    required this.maxDate,
  });
  final DateTime initial;
  final ValueChanged<DateTime> onChanged;
  final VoidCallback onDone;
  final DateTime maxDate;

  @override
  Widget build(BuildContext context) {
    return _PickerSheet(
      title: 'CHỌN NGÀY SINH',
      onDone: onDone,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: _P.red,
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: GoogleFonts.cinzel(
              color: _P.ink,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 44,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: _P.border.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              minimumDate: DateTime(1950),
              maximumDate: maxDate,
              initialDateTime: initial,
              onDateTimeChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Hour bottom sheet ────────────────────────────────────────────────────────

class _HourSheet extends StatelessWidget {
  const _HourSheet({
    required this.branches,
    required this.ranges,
    required this.initialIndex,
    required this.onChanged,
    required this.onDone,
  });
  final List<String> branches;
  final Map<String, String> ranges;
  final int initialIndex;
  final ValueChanged<int> onChanged;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return _PickerSheet(
      title: 'CHỌN GIỜ SINH',
      onDone: onDone,
      child: CupertinoTheme(
        data: const CupertinoThemeData(brightness: Brightness.light),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 44,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: _P.border.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            CupertinoPicker(
              itemExtent: 44,
              scrollController:
                  FixedExtentScrollController(initialItem: initialIndex),
              onSelectedItemChanged: onChanged,
              children: branches.map((b) {
                return Center(
                  child: Text(
                    '$b (${ranges[b] ?? ''})',
                    style: GoogleFonts.cinzel(
                      color: _P.ink,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Generic picker sheet shell ───────────────────────────────────────────────

class _PickerSheet extends StatelessWidget {
  const _PickerSheet({
    required this.title,
    required this.onDone,
    required this.child,
  });
  final String title;
  final VoidCallback onDone;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: _P.sheet,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: _P.border, width: 0.8),
      ),
      child: Column(
        children: [
          // Header bar
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: _P.card,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(
                bottom: BorderSide(color: _P.border, width: 0.8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.cinzel(
                    color: _P.mid,
                    fontSize: 11,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onDone,
                  child: Text(
                    'Xong',
                    style: GoogleFonts.cinzel(
                      color: _P.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
