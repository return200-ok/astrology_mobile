import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/models/imperial_cast_request.dart';
import '../widgets/imperial_starfield_background.dart';
import 'imperial_result_page.dart';

// ─── Colors ──────────────────────────────────────────────────────────────────
const Color _kGold = Color(0xFFD4AF37);
const Color _kGoldBright = Color(0xFFEDD060);
const Color _kPanel = Color(0xFF1A174D);
const Color _kBorder = Color(0xFF3B3480);
const Color _kCloud = Color(0xFF2B2870);

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
    'Tý': '23H - 1H', 'Sửu': '1H - 3H', 'Dần': '3H - 5H',
    'Mão': '5H - 7H', 'Thìn': '7H - 9H', 'Tỵ': '9H - 11H',
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
    return Scaffold(
      body: ImperialStarfieldBackground(
        child: Stack(
          children: [
            // Cloud decoration layer
            const Positioned.fill(child: _CloudDecoration()),

            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(
                          Icons.chevron_left_rounded,
                          size: 32,
                          color: Colors.white60,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ── Title ──────────────────────────────────────────────
                    _buildTitle(context, l10n),

                    const SizedBox(height: 40),

                    // ── Form ───────────────────────────────────────────────
                    _fieldLabel(l10n.imperialSpiritId),
                    const SizedBox(height: 10),
                    _nameField(l10n),

                    const SizedBox(height: 24),

                    _fieldLabel(l10n.imperialArrivalDay),
                    const SizedBox(height: 10),
                    _dateField(l10n),

                    const SizedBox(height: 24),

                    _fieldLabel(l10n.imperialStreamsHour),
                    const SizedBox(height: 10),
                    _hourField(),

                    const SizedBox(height: 40),

                    // ── Cast Stars button ──────────────────────────────────
                    _CastStarsButton(
                      label: l10n.imperialCastStars,
                      onTap: () => _submit(l10n),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Title ────────────────────────────────────────────────────────────────
  Widget _buildTitle(BuildContext context, AppLocalizations l10n) {
    final w = MediaQuery.sizeOf(context).width;
    final titleSize = w < 430 ? 58.0 : 72.0;
    final subtitleSize = w < 430 ? 11.0 : 14.0;

    return Column(
      children: [
        Text(
          l10n.imperialTitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            color: _kGold,
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            height: 1.1,
            letterSpacing: 2.0,
            shadows: [
              Shadow(color: _kGold.withOpacity(0.50), blurRadius: 20),
              Shadow(color: _kGold.withOpacity(0.25), blurRadius: 48),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          l10n.imperialSubtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            color: _kGold.withOpacity(0.55),
            fontSize: subtitleSize,
            letterSpacing: w < 430 ? 3.5 : 5.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // ── Field label ──────────────────────────────────────────────────────────
  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.cinzel(
        color: _kGold,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.4,
      ),
    );
  }

  // ── Name text field ──────────────────────────────────────────────────────
  Widget _nameField(AppLocalizations l10n) {
    return TextField(
      controller: _nameCtrl,
      style: GoogleFonts.cinzel(
        color: Colors.white.withOpacity(0.92),
        fontSize: 16,
        fontStyle: FontStyle.italic,
      ),
      cursorColor: _kGold,
      decoration: InputDecoration(
        hintText: l10n.imperialSpiritPlaceholder,
        hintStyle: GoogleFonts.cinzel(
          color: _kGold.withOpacity(0.38),
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _kBorder.withOpacity(0.80), width: 1),
          borderRadius: BorderRadius.circular(999),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _kGold.withOpacity(0.70), width: 1.2),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  // ── Date picker field ────────────────────────────────────────────────────
  Widget _dateField(AppLocalizations l10n) {
    final txt = _birthDate == null
        ? l10n.imperialDatePlaceholder
        : DateFormat('MM/dd/yyyy').format(_birthDate!);
    final hasDate = _birthDate != null;

    return _FieldTile(
      onTap: _pickDate,
      child: Row(
        children: [
          Expanded(
            child: Text(
              txt,
              style: GoogleFonts.cinzel(
                color: hasDate
                    ? Colors.white.withOpacity(0.92)
                    : _kGold.withOpacity(0.40),
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Icon(Icons.calendar_month_outlined,
              color: _kGold.withOpacity(0.70), size: 20),
        ],
      ),
    );
  }

  // ── Hour picker field ────────────────────────────────────────────────────
  Widget _hourField() {
    final range = _ranges[_birthHour] ?? '';
    return _FieldTile(
      onTap: _pickHour,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$_birthHour ($range)',
              style: GoogleFonts.cinzel(
                color: Colors.white.withOpacity(0.92),
                fontSize: 16,
              ),
            ),
          ),
          Icon(Icons.unfold_more_rounded,
              color: _kGold.withOpacity(0.70), size: 22),
        ],
      ),
    );
  }

  // ── Date picker ──────────────────────────────────────────────────────────
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final init = _birthDate ?? DateTime(2000);
    var temp = DateTime(init.year, init.month, init.day);
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
    if (picked == null && temp != init) {
      // user scrolled but tapped outside
    }
    if (mounted && picked != null) setState(() => _birthDate = picked);
  }

  // ── Hour picker ──────────────────────────────────────────────────────────
  Future<void> _pickHour() async {
    final idx = _branches.indexOf(_birthHour).clamp(0, 11);
    var sel = idx;
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

  // ── Submit ───────────────────────────────────────────────────────────────
  void _submit(AppLocalizations l10n) {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty || _birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.imperialFillRequiredSnack),
          backgroundColor: _kPanel,
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

// ─── Reusable pill field tile ─────────────────────────────────────────────

class _FieldTile extends StatelessWidget {
  const _FieldTile({required this.child, required this.onTap});

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
        splashColor: _kGold.withOpacity(0.10),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: _kBorder.withOpacity(0.80), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─── Cast Stars button ────────────────────────────────────────────────────

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
        splashColor: Colors.white.withOpacity(0.12),
        child: Ink(
          height: 62,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: const LinearGradient(
              colors: [Color(0xFFA8832A), Color(0xFFD4AF37), Color(0xFFEDD060),
                       Color(0xFFD4AF37), Color(0xFF8E6E1A)],
              stops: [0.0, 0.25, 0.50, 0.75, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: _kGold.withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Bagua watermark
              CustomPaint(
                size: const Size(52, 52),
                painter: _BaguaPainter(),
              ),
              // Label
              Text(
                label,
                style: GoogleFonts.cinzel(
                  color: const Color(0xFF2A1E06),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
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

// ─── Bagua watermark painter ──────────────────────────────────────────────

class _BaguaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2A1E06).withOpacity(0.18)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    // Outer circle
    canvas.drawCircle(Offset(cx, cy), r * 0.98, paint);
    // Inner circle
    canvas.drawCircle(Offset(cx, cy), r * 0.52, paint);

    // 8 trigram lines (simplified as short bars)
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) - math.pi / 2;
      for (int line = 0; line < 3; line++) {
        final lineR = r * 0.60 + line * r * 0.11;
        final lineLen = r * 0.14;
        final cos = math.cos(angle);
        final sin = math.sin(angle);
        // Broken or solid line (alternating)
        final isBroken = (i + line) % 2 == 1;
        if (isBroken) {
          canvas.drawLine(
            Offset(cx + cos * lineR - sin * lineLen * 0.4,
                cy + sin * lineR + cos * lineLen * 0.4),
            Offset(cx + cos * lineR - sin * lineLen * 0.05,
                cy + sin * lineR + cos * lineLen * 0.05),
            paint,
          );
          canvas.drawLine(
            Offset(cx + cos * lineR + sin * lineLen * 0.05,
                cy + sin * lineR - cos * lineLen * 0.05),
            Offset(cx + cos * lineR + sin * lineLen * 0.4,
                cy + sin * lineR - cos * lineLen * 0.4),
            paint,
          );
        } else {
          canvas.drawLine(
            Offset(cx + cos * lineR - sin * lineLen * 0.4,
                cy + sin * lineR + cos * lineLen * 0.4),
            Offset(cx + cos * lineR + sin * lineLen * 0.4,
                cy + sin * lineR - cos * lineLen * 0.4),
            paint,
          );
        }
      }
    }

    // Yin-yang circle (simplified)
    canvas.drawCircle(Offset(cx, cy), r * 0.22, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Cloud decoration ─────────────────────────────────────────────────────

class _CloudDecoration extends StatelessWidget {
  const _CloudDecoration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _CloudPainter());
  }
}

class _CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kCloud.withOpacity(0.55)
      ..style = PaintingStyle.fill;

    // Right side cloud scroll
    _drawCloudScroll(canvas, paint,
        Offset(size.width + 10, size.height * 0.48), scale: 1.2);

    // Bottom-right cloud
    _drawCloudScroll(canvas, paint,
        Offset(size.width - 10, size.height - 20), scale: 0.9, flip: true);

    // Bottom-left cloud (partial)
    _drawCloudScroll(canvas, paint,
        Offset(-20, size.height - 30), scale: 0.75);
  }

  void _drawCloudScroll(Canvas canvas, Paint paint, Offset origin,
      {double scale = 1.0, bool flip = false}) {
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    if (flip) canvas.scale(-1, -1);
    canvas.scale(scale, scale);

    final path = Path();

    // Main cloud body — three overlapping arcs
    path.moveTo(-80, 20);
    path.quadraticBezierTo(-90, -10, -60, -20);
    path.quadraticBezierTo(-50, -40, -20, -35);
    path.quadraticBezierTo(-10, -55, 20, -45);
    path.quadraticBezierTo(50, -55, 55, -30);
    path.quadraticBezierTo(80, -25, 75, 0);
    path.quadraticBezierTo(85, 20, 60, 25);

    // Curling tail (scroll)
    path.quadraticBezierTo(40, 30, 20, 22);
    path.quadraticBezierTo(0, 38, -20, 28);
    path.quadraticBezierTo(-40, 42, -60, 30);
    path.quadraticBezierTo(-75, 38, -80, 25);
    path.close();

    canvas.drawPath(path, paint);

    // Inner curl detail (darker)
    final curlPaint = Paint()
      ..color = _kCloud.withOpacity(0.30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final curl = Path();
    curl.moveTo(-30, 10);
    curl.quadraticBezierTo(-10, -5, 10, 5);
    curl.quadraticBezierTo(30, 15, 20, 30);
    curl.quadraticBezierTo(5, 42, -10, 35);
    canvas.drawPath(curl, curlPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ─── Date sheet ───────────────────────────────────────────────────────────

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
          brightness: Brightness.dark,
          primaryColor: _kGold,
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: GoogleFonts.cinzel(
              color: _kGold,
              fontSize: 22,
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
                color: _kGold.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kGold.withOpacity(0.20)),
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

// ─── Hour sheet ───────────────────────────────────────────────────────────

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
        data: const CupertinoThemeData(brightness: Brightness.dark),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 44,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: _kGold.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kGold.withOpacity(0.20)),
              ),
            ),
            CupertinoPicker(
              itemExtent: 44,
              scrollController:
                  FixedExtentScrollController(initialItem: initialIndex),
              onSelectedItemChanged: onChanged,
              children: branches
                  .map(
                    (b) => Center(
                      child: Text(
                        '$b (${ranges[b] ?? ''})',
                        style: GoogleFonts.cinzel(
                          color: _kGold.withOpacity(0.95),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Generic bottom sheet shell ───────────────────────────────────────────

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
        color: _kPanel.withOpacity(0.98),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: _kGold.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF14124A),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(
                bottom: BorderSide(color: _kGold.withOpacity(0.20)),
              ),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.cinzel(
                    color: _kGold.withOpacity(0.80),
                    fontSize: 12,
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
                      color: _kGoldBright,
                      fontSize: 16,
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
