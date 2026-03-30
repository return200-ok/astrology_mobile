import 'dart:async';

import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astroweb_mobile/core/theme/astro_theme.dart';
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
  final localeController = LocaleController();
  await localeController.load();
  runApp(AstroApp(localeController: localeController));
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
  const AstroApp({super.key, this.localeController});

  final LocaleController? localeController;
  static final LocaleController _fallbackLocaleController = LocaleController();
  static bool _fallbackLoaded = false;

  LocaleController get _activeLocaleController =>
      localeController ?? _fallbackLocaleController;

  void _ensureFallbackLoaded() {
    if (localeController != null || _fallbackLoaded) return;
    _fallbackLoaded = true;
    unawaited(_fallbackLocaleController.load());
  }

  @override
  Widget build(BuildContext context) {
    _ensureFallbackLoaded();
    final lc = _activeLocaleController;
    return AnimatedBuilder(
      animation: lc,
      builder: (context, _) {
        return MaterialApp(
          onGenerateTitle: (ctx) => AppLocalizations.of(ctx)!.appTitle,
          debugShowCheckedModeBanner: false,
          locale: lc.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: AstroColors.parchment,
            textTheme: GoogleFonts.beVietnamProTextTheme(
                ThemeData.light().textTheme),
            primaryColor: AstroColors.red,
          ),
          home: MainScaffold(localeController: lc),
        );
      },
    );
  }
}

// ─── Main scaffold ───────────────────────────────────────────────────────────

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key, required this.localeController});
  final LocaleController localeController;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  List<FeatureMenuItem> _featureItems(AppLocalizations l10n) => [
    FeatureMenuItem(
      feature: AppFeature.oracle,
      title: l10n.featureOracleTitle,
      icon: Icons.all_inclusive_rounded,
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
      builder: (_) => SettingsPage(localeController: widget.localeController),
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
              // ── Header with settings gear top-right ────────────
              Padding(
                padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: _goSettings,
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AstroColors.card.withValues(alpha: 0.7),
                            border: Border.all(
                              color: AstroColors.border.withValues(alpha: 0.5),
                              width: 0.8,
                            ),
                          ),
                          child: Icon(
                            Icons.settings_outlined,
                            size: 18,
                            color: AstroColors.ink.withValues(alpha: 0.55),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 12),
                        Icon(
                          Icons.nightlight_round,
                          size: 38,
                          color: AstroColors.ink.withValues(alpha: 0.65),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          l10n.homeHeroTitle,
                          style: AstroText.sectionLabel(size: 26, spacing: 3.2),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          l10n.homeHeroSubtitle,
                          style: AstroText.caption(size: 10),
                        ),
                        const SizedBox(height: 22),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Feature grid ───────────────────────────────────
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: hPad),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
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
          color: AstroColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AstroColors.border, width: 0.8),
          boxShadow: [
            BoxShadow(
              color: AstroColors.ink.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon circle
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: circleBorder, width: 1),
              ),
              child: Icon(item.icon, size: 27, color: iconColor),
            ),
            const SizedBox(height: 11),
            // Title — Playfair Display
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: AstroText.sectionLabel(size: 12, spacing: 1.1).copyWith(height: 1.35),
            ),
            const SizedBox(height: 5),
            // Tagline — Be Vietnam Pro
            Text(
              item.tagline,
              textAlign: TextAlign.center,
              style: AstroText.bodyMuted(size: 10, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }
}
