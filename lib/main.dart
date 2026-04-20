import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';
import 'core/config/app_config.dart';
import 'core/i18n/locale_controller.dart';
import 'core/widgets/ink_wash_background.dart';
import 'features/alignment/presentation/pages/alignment_page.dart';
import 'features/cosmic_void/presentation/pages/cosmic_void_page.dart';
import 'features/iching/presentation/pages/iching_input_page.dart';
import 'features/imperial/presentation/pages/imperial_input_page.dart';
import 'features/oracle/presentation/pages/oracle_sign_selection_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';
import 'features/soul_revelation/presentation/pages/soul_revelation_intro_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.assertConfigured();
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );
  final localeController = LocaleController();
  final themeController = ThemeController();
  try {
    await Future.wait([localeController.load(), themeController.load()]);
  } catch (_) {
    // Continue with defaults if preferences are unavailable
  }
  runApp(AstroApp(localeController: localeController, themeController: themeController));
}

// ─── Card accent types ───────────────────────────────────────────────────────
enum CardAccent { none, red, gold }

// ─── Feature data ────────────────────────────────────────────────────────────

class FeatureMenuItem {
  const FeatureMenuItem({
    required this.feature,
    required this.title,
    required this.icon,
    required this.tagline,
    required this.page,
    this.accent = CardAccent.none,
  });

  final AppFeature feature;
  final String title;
  final IconData icon;
  final String tagline;
  final Widget page;
  final CardAccent accent;
}

enum AppFeature { oracle, imperial, alignment, iching, soulRevelation, cosmicVoid }

// ─── App root ────────────────────────────────────────────────────────────────

class AstroApp extends StatelessWidget {
  const AstroApp({super.key, this.localeController, this.themeController});

  final LocaleController? localeController;
  final ThemeController? themeController;
  static final LocaleController _fallbackLocaleController = LocaleController();
  static final ThemeController _fallbackThemeController = ThemeController();
  static bool _fallbackLoaded = false;

  LocaleController get _activeLocaleController =>
      localeController ?? _fallbackLocaleController;

  ThemeController get _activeThemeController =>
      themeController ?? _fallbackThemeController;

  void _ensureFallbackLoaded() {
    if (localeController != null || _fallbackLoaded) return;
    _fallbackLoaded = true;
    unawaited(Future.wait([
      _fallbackLocaleController.load(),
      _fallbackThemeController.load(),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    _ensureFallbackLoaded();
    final lc = _activeLocaleController;
    final tc = _activeThemeController;
    return AnimatedBuilder(
      animation: Listenable.merge([lc, tc]),
      builder: (context, _) {
        return MaterialApp(
          onGenerateTitle: (ctx) => AppLocalizations.of(ctx)!.appTitle,
          debugShowCheckedModeBanner: false,
          locale: lc.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AstroThemeData.light(),
          darkTheme: AstroThemeData.dark(),
          themeMode: tc.mode,
          home: MainScaffold(localeController: lc, themeController: tc),
        );
      },
    );
  }
}

// ─── Main scaffold ───────────────────────────────────────────────────────────

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key, required this.localeController, required this.themeController});
  final LocaleController localeController;
  final ThemeController themeController;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  List<FeatureMenuItem> _featureItems(AppLocalizations l10n) => [
    FeatureMenuItem(
      feature: AppFeature.oracle,
      title: l10n.featureOracleTitle,
      icon: Icons.all_inclusive_outlined,
      tagline: l10n.featureOracleTagline,
      page: const OracleSignSelectionPage(),
      accent: CardAccent.red,          // Tiên tri — huyền bí
    ),
    FeatureMenuItem(
      feature: AppFeature.imperial,
      title: l10n.featureImperialTitle,
      icon: Icons.workspace_premium_outlined,
      tagline: l10n.featureImperialTagline,
      page: const ImperialInputPage(),
      accent: CardAccent.gold,         // Tử Vi — tri thức cổ
    ),
    FeatureMenuItem(
      feature: AppFeature.alignment,
      title: l10n.featureAlignmentTitle,
      icon: Icons.track_changes_outlined,
      tagline: l10n.featureAlignmentTagline,
      page: const AlignmentPage(),
      accent: CardAccent.gold,         // Tương hợp — vì sao
    ),
    FeatureMenuItem(
      feature: AppFeature.iching,
      title: l10n.featureIChingTitle,
      icon: Icons.grid_goldenratio_outlined,
      tagline: l10n.featureIChingTagline,
      page: const IChingInputPage(),
      accent: CardAccent.red,          // Kinh Dịch — linh thiêng
    ),
    FeatureMenuItem(
      feature: AppFeature.soulRevelation,
      title: l10n.featureSoulRevelationTitle,
      icon: Icons.self_improvement_outlined,
      tagline: l10n.featureSoulRevelationTagline,
      page: const SoulRevelationIntroPage(),
    ),
    FeatureMenuItem(
      feature: AppFeature.cosmicVoid,
      title: l10n.featureCosmicVoidTitle,
      icon: Icons.nightlight_round_outlined,
      tagline: l10n.featureCosmicVoidTagline,
      page: const CosmicVoidPage(),
    ),
  ];

  void _go(FeatureMenuItem item) => Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => item.page),
  );

  void _goSettings() => Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => SettingsPage(
        localeController: widget.localeController,
        themeController: widget.themeController,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = _featureItems(l10n);
    final hPad = MediaQuery.sizeOf(context).width * 0.055;

    return Scaffold(
      backgroundColor: AstroColors.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            children: [
              // ── Settings row ─────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: _goSettings,
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Center(
                        child: Icon(
                          Icons.tune_rounded,
                          size: 20,
                          color: AstroColors.light,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ── Hero title ────────────────────────────────────────
              Text(
                l10n.homeHeroTitle,
                style: AstroText.sectionLabel(size: 26, spacing: 3.2),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.homeHeroSubtitle,
                style: AstroText.bodyMuted(size: 11, height: 1.0),
              ),
              const SizedBox(height: 20),

              // ── Feature grid ───────────────────────────────────
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: hPad),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.95,
                    ),
                    itemCount: items.length,
                    itemBuilder: (_, i) => _FeatureCard(
                      item: items[i],
                      onTap: () => _go(items[i]),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Feature card ────────────────────────────────────────────────────────────

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.item, required this.onTap});

  final FeatureMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Resolve accent colours
    final Color iconColor;
    final Color circleBorder;
    switch (item.accent) {
      case CardAccent.red:
        iconColor = AstroColors.red.withValues(alpha: 0.85);
        circleBorder = AstroColors.red.withValues(alpha: 0.30);
      case CardAccent.gold:
        iconColor = AstroColors.gold;
        circleBorder = AstroColors.gold.withValues(alpha: 0.40);
      case CardAccent.none:
        iconColor = AstroColors.ink.withValues(alpha: 0.68);
        circleBorder = AstroColors.border;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AstroColors.cardAlt, AstroColors.card],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AstroColors.border.withValues(alpha: 0.6), width: 0.8),
          boxShadow: [
            BoxShadow(
              color: AstroColors.ink.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: AstroColors.ink.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon circle
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: circleBorder, width: 1),
              ),
              child: Icon(item.icon, size: 26, color: iconColor),
            ),
            const SizedBox(height: 11),
            // Title — Playfair Display
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: AstroText.sectionLabel(size: 12, spacing: 1.1).copyWith(height: 1.35),
            ),
            const SizedBox(height: 5),
            // Tagline — Be Vietnam Pro, enhanced readability
            Text(
              item.tagline,
              textAlign: TextAlign.center,
              style: AstroText.bodyMuted(size: 10.5, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }
}
