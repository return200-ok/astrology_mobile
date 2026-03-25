import 'dart:async';

import 'package:flutter/material.dart';
import 'package:astroweb_mobile/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/i18n/locale_controller.dart';
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

class FeatureMenuItem {
  const FeatureMenuItem({
    required this.feature,
    required this.title,
    required this.icon,
    required this.tagline,
    required this.page,
  });

  final AppFeature feature;
  final String title;
  final IconData icon;
  final String tagline;
  final Widget page;
}

enum AppFeature {
  oracle,
  imperial,
  alignment,
  iching,
  soulRevelation,
  cosmicVoid,
}

class AstroApp extends StatelessWidget {
  AstroApp({super.key, this.localeController});

  final LocaleController? localeController;
  static final LocaleController _fallbackLocaleController = LocaleController();
  static bool _fallbackLoaded = false;

  LocaleController get _activeLocaleController =>
      localeController ?? _fallbackLocaleController;

  void _ensureFallbackLoaded() {
    if (localeController != null || _fallbackLoaded) {
      return;
    }
    _fallbackLoaded = true;
    unawaited(_fallbackLocaleController.load());
  }

  @override
  Widget build(BuildContext context) {
    _ensureFallbackLoaded();
    final activeLocaleController = _activeLocaleController;
    return AnimatedBuilder(
      animation: activeLocaleController,
      builder: (context, _) {
        return MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          debugShowCheckedModeBanner: false,
          locale: activeLocaleController.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF090B1A),
            textTheme: GoogleFonts.interTextTheme(
              ThemeData.dark().textTheme,
            ),
            primaryColor: const Color(0xFFE2C27A),
          ),
          home: MainScaffold(localeController: activeLocaleController),
        );
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key, required this.localeController});

  final LocaleController localeController;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  // Ink-wash color palette
  static const Color _inkDark = Color(0xFF2C2C2C);
  static const Color _inkMedium = Color(0xFF5A5A5A);
  static const Color _inkLight = Color(0xFF8A8A8A);
  static const Color _parchment = Color(0xFFF5F0E8);
  static const Color _parchmentDark = Color(0xFFEDE6D8);
  static const Color _cardBorder = Color(0xFFD5CFC3);

  List<FeatureMenuItem> _featureItems(AppLocalizations l10n) {
    return [
      FeatureMenuItem(
        feature: AppFeature.oracle,
        title: l10n.featureOracleTitle,
        icon: Icons.all_inclusive_rounded,
        tagline: l10n.featureOracleTagline,
        page: const OracleSignSelectionPage(),
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
  }

  void _navigateToFeature(FeatureMenuItem item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => item.page),
    );
  }

  void _navigateToSettings() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SettingsPage(localeController: widget.localeController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final featureItems = _featureItems(l10n);
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.06;

    return Scaffold(
      backgroundColor: _parchment,
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Moon icon
                  Icon(
                    Icons.nightlight_round,
                    size: 40,
                    color: _inkDark.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    l10n.homeHeroTitle,
                    style: GoogleFonts.cinzel(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: _inkDark,
                      letterSpacing: 3.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Subtitle
                  Text(
                    l10n.homeHeroSubtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: _inkMedium,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Feature grid
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: featureItems.length,
                  itemBuilder: (context, index) {
                    return _FeatureCard(
                      item: featureItems[index],
                      onTap: () => _navigateToFeature(featureItems[index]),
                    );
                  },
                ),
              ),
            ),

            // Settings button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: _navigateToSettings,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _parchmentDark,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: _cardBorder, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          size: 20,
                          color: _inkDark,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l10n.settings,
                          style: GoogleFonts.cinzel(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _inkDark,
                            letterSpacing: 1.5,
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
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.item,
    required this.onTap,
  });

  final FeatureMenuItem item;
  final VoidCallback onTap;

  static const Color _inkDark = Color(0xFF2C2C2C);
  static const Color _inkMedium = Color(0xFF5A5A5A);
  static const Color _cardBg = Color(0xFFFAF7F2);
  static const Color _cardBorder = Color(0xFFD5CFC3);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _cardBorder, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon in a subtle circle
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _cardBorder,
                  width: 1,
                ),
              ),
              child: Icon(
                item.icon,
                size: 24,
                color: _inkDark.withValues(alpha: 0.75),
              ),
            ),
            const SizedBox(height: 12),
            // Title
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _inkDark,
                letterSpacing: 1.2,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 6),
            // Tagline
            Text(
              item.tagline,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: _inkMedium,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
