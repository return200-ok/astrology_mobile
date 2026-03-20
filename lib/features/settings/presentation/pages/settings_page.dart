import 'package:astroweb_mobile/core/i18n/locale_controller.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.localeController});

  final LocaleController localeController;

  static const Color _gold = Color(0xFFE2C27A);

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.4),
            radius: 1.3,
            colors: [
              Color(0xFF27204F),
              Color(0xFF171730),
              Color(0xFF090B1A),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.settings,
                    style: GoogleFonts.cinzel(
                      color: _gold,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _gold.withOpacity(0.45)),
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
                            color: _gold,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          languageHint,
                          style: GoogleFonts.cormorantGaramond(
                            color: Colors.white70,
                            fontSize: 21,
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
      activeColor: _gold,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: GoogleFonts.cinzel(
          color: active ? _gold : Colors.white70,
          fontSize: 14,
          fontWeight: active ? FontWeight.w700 : FontWeight.w400,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
