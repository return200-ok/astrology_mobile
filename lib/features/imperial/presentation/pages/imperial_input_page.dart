import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:astroweb_mobile/core/widgets/astro_page_scaffold.dart';
import 'package:astroweb_mobile/core/widgets/astro_button.dart';
import 'package:astroweb_mobile/core/widgets/astro_text_field.dart';
import 'package:astroweb_mobile/core/widgets/astro_section_header.dart';

import '../../domain/models/imperial_cast_request.dart';
import 'imperial_result_page.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

// ─── Page ─────────────────────────────────────────────────────────────────────

class ImperialInputPage extends StatefulWidget {
  const ImperialInputPage({super.key});

  @override
  State<ImperialInputPage> createState() => _ImperialInputPageState();
}

class _ImperialInputPageState extends State<ImperialInputPage> {
  final _formKey = GlobalKey<FormState>();
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

    return AstroPageScaffold(
      backTooltip: l10n.backTooltip,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 4),

            // ── Hero title ──────────────────────────────────────────
            Text(
              l10n.imperialTitle,
              textAlign: TextAlign.center,
              style: AstroText.pageTitle(AstroSize.title(w)),
            ),

            const SizedBox(height: 8),

            Text(
              l10n.imperialSubtitle,
              textAlign: TextAlign.center,
              style: AstroText.pageSubtitle(size: 11),
            ),

            const SizedBox(height: 40),

            // ── Celestial Identity ──────────────────────────────────
            AstroFieldLabel(text: l10n.imperialSpiritId),
            const SizedBox(height: 10),
            AstroTextField(
              controller: _nameCtrl,
              hint: l10n.imperialSpiritPlaceholder,
              style: AstroText.sectionLabel(size: 15)
                  .copyWith(color: AstroColors.ink, fontStyle: FontStyle.italic),
              hintStyle: AstroText.sectionLabel(size: 15).copyWith(
                color: AstroColors.mid.withValues(alpha: 0.55),
                fontStyle: FontStyle.italic,
              ),
              validator: (value) {
                final v = value?.trim() ?? '';
                if (v.isEmpty) return 'Vui lòng nhập tên';
                if (v.length < 2) return 'Tên phải có ít nhất 2 ký tự';
                return null;
              },
            ),

            const SizedBox(height: 22),

            // ── Date of Descent ─────────────────────────────────────
            AstroFieldLabel(text: l10n.imperialArrivalDay),
            const SizedBox(height: 10),
            _DateTile(
              date: _birthDate,
              placeholder: l10n.imperialDatePlaceholder,
              onTap: _pickDate,
            ),

            const SizedBox(height: 22),

            // ── Hour of Destiny ─────────────────────────────────────
            AstroFieldLabel(text: l10n.imperialStreamsHour),
            const SizedBox(height: 10),
            _HourTile(
              hour: _birthHour,
              range: _ranges[_birthHour] ?? '',
              onTap: _pickHour,
            ),

            const SizedBox(height: 48),

            // ── Cast Stars button ────────────────────────────────────
            AstroButton.outline(
              label: l10n.imperialCastStars,
              onTap: () => _submit(l10n),
              fontSize: 16,
            ),
          ],
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
    if (!_formKey.currentState!.validate()) return;
    final name = _nameCtrl.text.trim();
    if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.imperialFillRequiredSnack,
              style: AstroText.body().copyWith(color: AstroColors.card)),
          backgroundColor: AstroColors.ink,
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
              style: AstroText.sectionLabel(size: 15).copyWith(
                color: hasDate ? AstroColors.ink : AstroColors.mid.withValues(alpha: 0.55),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Icon(Icons.calendar_month_outlined,
              color: AstroColors.red.withValues(alpha: 0.75), size: 20),
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
              style: AstroText.sectionLabel(size: 15).copyWith(color: AstroColors.ink),
            ),
          ),
          Icon(Icons.unfold_more_rounded,
              color: AstroColors.ink.withValues(alpha: 0.55), size: 22),
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
        splashColor: AstroColors.red.withValues(alpha: 0.06),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          decoration: BoxDecoration(
            color: AstroColors.card,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AstroColors.border, width: 0.8),
          ),
          child: child,
        ),
      ),
    );
  }
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
      title: AppLocalizations.of(context)!.imperialPickDate,
      onDone: onDone,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: AstroColors.red,
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: AstroText.sectionLabel(size: 20).copyWith(color: AstroColors.ink, fontWeight: FontWeight.w500),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 44,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AstroColors.border.withValues(alpha: 0.30),
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
      title: AppLocalizations.of(context)!.imperialPickHour,
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
                color: AstroColors.border.withValues(alpha: 0.30),
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
                    style: AstroText.sectionLabel(size: 16).copyWith(color: AstroColors.ink),
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
        color: AstroColors.board,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: AstroColors.border, width: 0.8),
      ),
      child: Column(
        children: [
          // Header bar
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AstroColors.card,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(
                bottom: BorderSide(color: AstroColors.border, width: 0.8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: AstroText.sectionLabel(size: 11, spacing: 1.8).copyWith(color: AstroColors.mid),
                ),
                const Spacer(),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onDone,
                  child: Text(
                    AppLocalizations.of(context)!.commonDone,
                    style: AstroText.sectionLabel(size: 15),
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
