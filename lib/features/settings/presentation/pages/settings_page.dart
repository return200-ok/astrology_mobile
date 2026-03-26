import 'package:astroweb_mobile/core/i18n/locale_controller.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Palette (Ink Wash / Parchment) ──────────────────────────────────────────
abstract final class _P {
  static const ink    = Color(0xFF1A1A1A);
  static const mid    = Color(0xFF5C5C5C);
  static const red    = Color(0xFF8B3A3A);
  static const card   = Color(0xFFFBF8F3);
  static const border = Color(0xFFCDC5B8);
  static const divider = Color(0xFFD8D0C6);
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.localeController});

  final LocaleController localeController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vietnamese = Localizations.localeOf(context).languageCode == 'vi';

    final languageTitle = vietnamese ? 'Ngôn ngữ' : 'Language';
    final languageHint = vietnamese
        ? 'Chọn ngôn ngữ cho ứng dụng'
        : 'Select language for this app';
    final systemLabel = vietnamese ? 'Theo hệ thống' : 'System default';
    final englishLabel = vietnamese ? 'Tiếng Anh' : 'English';
    final vietnameseLabel = vietnamese ? 'Tiếng Việt' : 'Vietnamese';

    return Scaffold(
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            children: [
              // ── Header ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                      ),
                      color: _P.ink,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.settings,
                      style: GoogleFonts.cinzel(
                        color: _P.ink,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ── Language card ────────────────────────────────────────
              Container(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
                decoration: BoxDecoration(
                  color: _P.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _P.border, width: 0.8),
                ),
                child: AnimatedBuilder(
                  animation: localeController,
                  builder: (context, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          languageTitle,
                          style: GoogleFonts.cinzel(
                            color: _P.ink,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          languageHint,
                          style: GoogleFonts.inter(
                            color: _P.mid,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _languageOption(
                          context: context,
                          title: systemLabel,
                          value: 'system',
                        ),
                        _languageOption(
                          context: context,
                          title: englishLabel,
                          value: 'en',
                        ),
                        _languageOption(
                          context: context,
                          title: vietnameseLabel,
                          value: 'vi',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageOption({
    required BuildContext context,
    required String title,
    required String value,
  }) {
    final active = localeController.selectedCode == value;
    return RadioListTile<String>(
      value: value,
      groupValue: localeController.selectedCode,
      onChanged: (selected) async {
        if (selected == null) return;
        if (selected == 'system') {
          await localeController.setSystemLocale();
          return;
        }
        await localeController.setLocaleCode(selected);
      },
      activeColor: _P.red,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: GoogleFonts.cinzel(
          color: active ? _P.red : _P.mid,
          fontSize: 14,
          fontWeight: active ? FontWeight.w700 : FontWeight.w400,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
