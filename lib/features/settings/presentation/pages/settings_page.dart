import 'package:astroweb_mobile/core/i18n/locale_controller.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.localeController});

  final LocaleController localeController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AstroColors.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            children: [
              _SettingsHeader(title: l10n.settings),
              Expanded(
                child: AnimatedBuilder(
                  animation: localeController,
                  builder: (context, _) {
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                      children: [
                        // ── CÁ NHÂN HÓA ────────────────────────
                        _SectionHeader(title: l10n.settingsSectionPersonalize),
                        _SettingsGroup(
                          children: [
                            _SettingsTile(
                              icon: Icons.language_rounded,
                              label: l10n.settingsLanguage,
                              value: _currentLanguageLabel(context),
                              onTap: () => _showLanguageSheet(context),
                            ),
                            _SettingsTile(
                              icon: Icons.palette_outlined,
                              label: l10n.settingsAppearance,
                              value: l10n.settingsAppearanceLight,
                              onTap: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ── HỆ THỐNG ────────────────────────────
                        _SectionHeader(title: l10n.settingsSectionSystem),
                        _SettingsGroup(
                          children: [
                            _SettingsTile(
                              icon: Icons.notifications_none_rounded,
                              label: l10n.settingsNotifications,
                              onTap: () {},
                            ),
                            _SettingsTile(
                              icon: Icons.volume_up_outlined,
                              label: l10n.settingsSound,
                              onTap: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ── HỖ TRỢ ─────────────────────────────
                        _SectionHeader(title: l10n.settingsSectionSupport),
                        _SettingsGroup(
                          children: [
                            _SettingsTile(
                              icon: Icons.description_outlined,
                              label: l10n.settingsTerms,
                              onTap: () {},
                            ),
                            _SettingsTile(
                              icon: Icons.chat_bubble_outline_rounded,
                              label: l10n.settingsContact,
                              onTap: () {},
                            ),
                            _SettingsTile(
                              icon: Icons.star_border_rounded,
                              label: l10n.settingsRate,
                              showChevron: false,
                              onTap: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // ── Version ─────────────────────────────
                        Center(
                          child: Text(
                            l10n.settingsVersion('1.0.0'),
                            style: AstroText.caption(size: 12).copyWith(color: AstroColors.light),
                          ),
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

  String _currentLanguageLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (localeController.selectedCode) {
      case 'vi':
        return l10n.settingsVietnamese;
      case 'en':
        return l10n.settingsEnglish;
      default:
        return l10n.settingsSystemDefault;
    }
  }

  void _showLanguageSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _LanguageBottomSheet(
        l10n: l10n,
        localeController: localeController,
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              color: AstroColors.ink.withValues(alpha: 0.7),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 4),
          // Playfair Display for heading — serif, sang trọng
          Text(
            title,
            style: AstroText.sectionLabel(size: 22, spacing: 1.0).copyWith(color: AstroColors.ink),
          ),
        ],
      ),
    );
  }
}

// ── Section header with đỏ huyết dụ accent line ────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 0, 10),
      child: Row(
        children: [
          // Thin red thread — "sợi chỉ đỏ định mệnh"
          Container(
            width: 16,
            height: 1,
            color: AstroColors.red.withValues(alpha: 0.45),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: AstroText.micro(size: 11, spacing: 1.8).copyWith(color: AstroColors.light),
          ),
        ],
      ),
    );
  }
}

// ── Grouped card container ──────────────────────────────────────────────────

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AstroColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AstroColors.border, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: AstroColors.ink.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1)
              // Thin red divider — chỉ đỏ kết nối
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: AstroColors.red.withValues(alpha: 0.12),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

// ── Single settings row ─────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    this.value,
    this.showChevron = true,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String? value;
  final bool showChevron;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AstroColors.mid),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: AstroText.body(size: 15),
                ),
              ),
              if (value != null) ...[
                Text(
                  value!,
                  style: AstroText.body(size: 14).copyWith(color: AstroColors.gold),
                ),
                const SizedBox(width: 6),
              ],
              if (showChevron)
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: AstroColors.border,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Language bottom sheet
// ═════════════════════════════════════════════════════════════════════════════

class _LanguageBottomSheet extends StatelessWidget {
  const _LanguageBottomSheet({
    required this.l10n,
    required this.localeController,
  });

  final AppLocalizations l10n;
  final LocaleController localeController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: localeController,
      builder: (context, _) {
        final selected = localeController.selectedCode;

        return Container(
          decoration: const BoxDecoration(
            color: AstroColors.card,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AstroColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.settingsChooseLanguage,
                      style: AstroText.sectionLabel(size: 18).copyWith(color: AstroColors.ink),
                    ),
                  ),
                ),
                // Red thread divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(
                    height: 0.5,
                    thickness: 0.5,
                    color: AstroColors.red.withValues(alpha: 0.18),
                  ),
                ),
                _LanguageOption(
                  label: l10n.settingsSystemDefault,
                  code: 'system',
                  selected: selected,
                  onTap: () async {
                    await localeController.setSystemLocale();
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                _LanguageOption(
                  label: l10n.settingsEnglish,
                  code: 'en',
                  selected: selected,
                  onTap: () async {
                    await localeController.setLocaleCode('en');
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                _LanguageOption(
                  label: l10n.settingsVietnamese,
                  code: 'vi',
                  selected: selected,
                  onTap: () async {
                    await localeController.setLocaleCode('vi');
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.code,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String code;
  final String selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = selected == code;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AstroText.body(size: 15).copyWith(
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive ? AstroColors.ink : AstroColors.mid,
                  ),
                ),
              ),
              // Đỏ huyết dụ checkmark
              if (isActive)
                const Icon(
                  Icons.check_rounded,
                  size: 20,
                  color: AstroColors.red,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
