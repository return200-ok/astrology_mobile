import 'package:astroweb_mobile/core/i18n/locale_controller.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';
import 'package:astroweb_mobile/core/widgets/ink_wash_background.dart';
import 'package:astroweb_mobile/core/widgets/astro_section_header.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.localeController,
    required this.themeController,
  });

  final LocaleController localeController;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bg = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bg,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            children: [
              _SettingsHeader(title: l10n.settings),
              Expanded(
                child: AnimatedBuilder(
                  animation: Listenable.merge([localeController, themeController]),
                  builder: (context, _) {
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                      children: [
                        // ── CÁ NHÂN HÓA ────────────────────────
                        AstroSectionHeader(title: l10n.settingsSectionPersonalize),
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
                              value: _currentAppearanceLabel(context),
                              onTap: () => _showAppearanceSheet(context),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ── HỆ THỐNG ────────────────────────────
                        AstroSectionHeader(title: l10n.settingsSectionSystem),
                        _SettingsGroup(
                          children: [
                            _SettingsTile(
                              icon: Icons.notifications_none_rounded,
                              label: l10n.settingsNotifications,
                              onTap: () => _showComingSoon(context, l10n.settingsNotifications),
                            ),
                            _SettingsTile(
                              icon: Icons.volume_up_outlined,
                              label: l10n.settingsSound,
                              onTap: () => _showComingSoon(context, l10n.settingsSound),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ── HỖ TRỢ ─────────────────────────────
                        AstroSectionHeader(title: l10n.settingsSectionSupport),
                        _SettingsGroup(
                          children: [
                            _SettingsTile(
                              icon: Icons.description_outlined,
                              label: l10n.settingsTerms,
                              onTap: () => _showTerms(context, l10n),
                            ),
                            _SettingsTile(
                              icon: Icons.chat_bubble_outline_rounded,
                              label: l10n.settingsContact,
                              onTap: () => _showComingSoon(context, l10n.settingsContact),
                            ),
                            _SettingsTile(
                              icon: Icons.star_border_rounded,
                              label: l10n.settingsRate,
                              showChevron: false,
                              onTap: () => _showComingSoon(context, l10n.settingsRate),
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

  String _currentAppearanceLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (themeController.selectedCode) {
      case 'light':
        return l10n.settingsAppearanceLight;
      case 'dark':
        return l10n.settingsAppearanceDark;
      default:
        return l10n.settingsAppearanceSystem;
    }
  }

  void _showAppearanceSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _AppearanceBottomSheet(
        l10n: l10n,
        themeController: themeController,
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature — ${l10n.settingsComingSoon}'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showTerms(BuildContext context, AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(l10n.settingsTerms, style: AstroText.sectionLabel(size: 16).copyWith(color: AstroColors.ink)),
        content: Text(
          'Mystic Cosmos (Tử Vi) là ứng dụng chiêm tinh học phục vụ mục đích giải trí và khám phá bản thân. Các thông tin cung cấp không thay thế lời khuyên chuyên nghiệp.\n\nDữ liệu cá nhân (ngày sinh, tên) được xử lý cục bộ trên thiết bị và không được chia sẻ với bên thứ ba.',
          style: AstroText.bodyMuted(size: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('OK', style: AstroText.buttonOutline(size: 14).copyWith(color: AstroColors.red)),
          ),
        ],
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
      padding: const EdgeInsets.fromLTRB(8, 4, 24, 0),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              color: AstroColors.ink,
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: AstroText.sectionLabel(size: 22, spacing: 1.0).copyWith(color: AstroColors.ink),
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AstroColors.border.withValues(alpha: 0.7),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AstroColors.ink.withValues(alpha: 0.06),
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
        borderRadius: BorderRadius.circular(16),
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
                    final saved = await localeController.setSystemLocale();
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (!saved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ngôn ngữ đã đổi nhưng không thể lưu cài đặt'),
                        ),
                      );
                    }
                  },
                ),
                _LanguageOption(
                  label: l10n.settingsEnglish,
                  code: 'en',
                  selected: selected,
                  onTap: () async {
                    final saved = await localeController.setLocaleCode('en');
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (!saved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Language changed but could not save settings'),
                        ),
                      );
                    }
                  },
                ),
                _LanguageOption(
                  label: l10n.settingsVietnamese,
                  code: 'vi',
                  selected: selected,
                  onTap: () async {
                    final saved = await localeController.setLocaleCode('vi');
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (!saved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ngôn ngữ đã đổi nhưng không thể lưu cài đặt'),
                        ),
                      );
                    }
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

// ═════════════════════════════════════════════════════════════════════════════
// Appearance bottom sheet
// ═════════════════════════════════════════════════════════════════════════════

class _AppearanceBottomSheet extends StatelessWidget {
  const _AppearanceBottomSheet({
    required this.l10n,
    required this.themeController,
  });

  final AppLocalizations l10n;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        final selected = themeController.selectedCode;

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AstroColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.settingsChooseAppearance,
                      style: AstroText.sectionLabel(size: 18).copyWith(color: AstroColors.ink),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(
                    height: 0.5,
                    thickness: 0.5,
                    color: AstroColors.red.withValues(alpha: 0.18),
                  ),
                ),
                _AppearanceOption(
                  label: l10n.settingsAppearanceSystem,
                  code: 'system',
                  icon: Icons.brightness_auto_rounded,
                  selected: selected,
                  onTap: () async {
                    final saved = await themeController.setMode(ThemeMode.system);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (!saved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${l10n.settingsAppearance} — ${l10n.settingsComingSoon}')),
                      );
                    }
                  },
                ),
                _AppearanceOption(
                  label: l10n.settingsAppearanceLight,
                  code: 'light',
                  icon: Icons.light_mode_rounded,
                  selected: selected,
                  onTap: () async {
                    final saved = await themeController.setMode(ThemeMode.light);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (!saved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${l10n.settingsAppearance} — ${l10n.settingsComingSoon}')),
                      );
                    }
                  },
                ),
                _AppearanceOption(
                  label: l10n.settingsAppearanceDark,
                  code: 'dark',
                  icon: Icons.dark_mode_rounded,
                  selected: selected,
                  onTap: () async {
                    final saved = await themeController.setMode(ThemeMode.dark);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (!saved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${l10n.settingsAppearance} — ${l10n.settingsComingSoon}')),
                      );
                    }
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

class _AppearanceOption extends StatelessWidget {
  const _AppearanceOption({
    required this.label,
    required this.code,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String code;
  final IconData icon;
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
              Icon(icon, size: 20, color: isActive ? AstroColors.red : AstroColors.mid),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: AstroText.body(size: 15).copyWith(
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive ? AstroColors.ink : AstroColors.mid,
                  ),
                ),
              ),
              if (isActive)
                const Icon(Icons.check_rounded, size: 20, color: AstroColors.red),
            ],
          ),
        ),
      ),
    );
  }
}
