import 'dart:async';

import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
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

// ─── Palette ────────────────────────────────────────────────────────────────
// Single source used by both MainScaffold and _FeatureCard.
abstract final class _P {
  static const ink    = Color(0xFF1A1A1A);   // near-black — primary text/icons
  static const mid    = Color(0xFF5C5C5C);   // secondary text
  static const red    = Color(0xFF8B3A3A);   // deep muted red — accent only
  static const card   = Color(0xFFFBF8F3);   // card surface
  static const border = Color(0xFFCDC5B8);   // subtle warm-grey border
  static const settingsBg = Color(0xFFF0EBE3); // settings pill bg
}

// ─── Feature data ────────────────────────────────────────────────────────────

class FeatureMenuItem {
  const FeatureMenuItem({
    required this.feature,
    required this.title,
    required this.icon,
    required this.tagline,
    required this.page,
    this.accentRed = false,
  });

  final AppFeature feature;
  final String title;
  final IconData icon;
  final String tagline;
  final Widget page;
  /// Whether this card's icon circle gets the subtle red accent.
  final bool accentRed;
}

enum AppFeature {
  oracle,
  imperial,
  alignment,
  iching,
  soulRevelation,
  cosmicVoid,
}

// ─── App root ────────────────────────────────────────────────────────────────

class AstroApp extends StatelessWidget {
  AstroApp({super.key, this.localeController});

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
            scaffoldBackgroundColor: InkWashBackground.parchment,
            textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
            primaryColor: _P.red,
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
      accentRed: true,          // Oracle gets the red accent
    ),
    FeatureMenuItem(
      feature: AppFeature.imperial,
      title: l10n.featureImperialTitle,
      icon: Icons.workspace_premium_outlined,
      tagline: l10n.featureImperialTagline,
      page: const ImperialInputPage(),
    ),
    FeatureMenuItem(
      feature: AppFeature.alignment,
      title: l10n.featureAlignmentTitle,
      icon: Icons.track_changes_outlined,
      tagline: l10n.featureAlignmentTagline,
      page: const AlignmentPage(),
    ),
    FeatureMenuItem(
      feature: AppFeature.iching,
      title: l10n.featureIChingTitle,
      icon: Icons.grid_goldenratio_outlined,
      tagline: l10n.featureIChingTagline,
      page: const IChingInputPage(),
      accentRed: true,          // I Ching also gets the red accent
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
      backgroundColor: InkWashBackground.parchment,
      body: InkWashBackground(
        child: SafeArea(
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(hPad, 28, hPad, 0),
                child: Column(
                  children: [
                    // Crescent moon — near-black at 65 % opacity
                    Icon(
                      Icons.nightlight_round,
                      size: 38,
                      color: _P.ink.withValues(alpha: 0.65),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.homeHeroTitle,
                      style: GoogleFonts.cinzel(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: _P.ink,
                        letterSpacing: 3.2,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      l10n.homeHeroSubtitle,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: _P.mid,
                        letterSpacing: 2.2,
                      ),
                    ),
                    const SizedBox(height: 22),
                  ],
                ),
              ),

              // ── Feature grid ─────────────────────────────────────────
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

              // ── Settings pill ────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 18),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: _goSettings,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: _P.settingsBg,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: _P.border, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.settings_outlined,
                              size: 18, color: _P.ink),
                          const SizedBox(width: 8),
                          Text(
                            l10n.settings,
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _P.ink,
                              letterSpacing: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
    final iconColor = item.accentRed
        ? _P.red.withValues(alpha: 0.80)
        : _P.ink.withValues(alpha: 0.72);
    final circleBorder = item.accentRed
        ? _P.red.withValues(alpha: 0.30)
        : _P.border;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _P.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _P.border, width: 0.8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon circle
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: circleBorder, width: 1),
              ),
              child: Icon(item.icon, size: 22, color: iconColor),
            ),
            const SizedBox(height: 11),
            // Title — Cinzel, near-black
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _P.ink,
                letterSpacing: 1.1,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 5),
            // Tagline — Inter, mid-grey
            Text(
              item.tagline,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: _P.mid,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
