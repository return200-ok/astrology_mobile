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
  });

  final AppFeature feature;
  final String title;
  final IconData icon;
  final String tagline;
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
            textTheme: GoogleFonts.cormorantGaramondTextTheme(
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const Color _gold = Color(0xFFE2C27A);
  static const Color _moon = Color(0xFFC6CBF9);
  int _selectedIndex = 0;

  List<FeatureMenuItem> _featureItems(AppLocalizations l10n) {
    return [
      FeatureMenuItem(
        feature: AppFeature.oracle,
        title: l10n.featureOracleTitle,
        icon: Icons.auto_awesome_outlined,
        tagline: l10n.featureOracleTagline,
      ),
      FeatureMenuItem(
        feature: AppFeature.imperial,
        title: l10n.featureImperialTitle,
        icon: Icons.workspace_premium_outlined,
        tagline: l10n.featureImperialTagline,
      ),
      FeatureMenuItem(
        feature: AppFeature.alignment,
        title: l10n.featureAlignmentTitle,
        icon: Icons.track_changes_outlined,
        tagline: l10n.featureAlignmentTagline,
      ),
      FeatureMenuItem(
        feature: AppFeature.iching,
        title: l10n.featureIChingTitle,
        icon: Icons.grid_goldenratio_outlined,
        tagline: l10n.featureIChingTagline,
      ),
      FeatureMenuItem(
        feature: AppFeature.soulRevelation,
        title: l10n.featureSoulRevelationTitle,
        icon: Icons.visibility_outlined,
        tagline: l10n.featureSoulRevelationTagline,
      ),
      FeatureMenuItem(
        feature: AppFeature.cosmicVoid,
        title: l10n.featureCosmicVoidTitle,
        icon: Icons.nightlight_round_outlined,
        tagline: l10n.featureCosmicVoidTagline,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final featureItems = _featureItems(l10n);
    final selectedItem = featureItems[_selectedIndex];
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildSidebar(context, featureItems),
      body: Stack(
        children: [
          HomePageContent(selectedItem: selectedItem),

          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  border: Border.all(color: _gold.withOpacity(0.7), width: 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: _gold.withOpacity(0.15),
                      blurRadius: 14,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.menu_rounded,
                  color: _gold,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, List<FeatureMenuItem> featureItems) {
    final l10n = AppLocalizations.of(context)!;
    return Drawer(
      backgroundColor: const Color(0xFF0B0D20),
      child: Column(
        children: [
          const SizedBox(height: 80),
          _sidebarHeader(),
          const SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              itemCount: featureItems.length,
              itemBuilder: (itemContext, index) {
                final item = featureItems[index];
                return _sidebarItem(
                  item.icon,
                  item.title,
                  index == _selectedIndex,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    Navigator.pop(itemContext);
                    if (item.feature == AppFeature.oracle) {
                      Navigator.of(this.context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const OracleSignSelectionPage(),
                        ),
                      );
                    } else if (item.feature == AppFeature.imperial) {
                      Navigator.of(this.context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const ImperialInputPage(),
                        ),
                      );
                    } else if (item.feature == AppFeature.alignment) {
                      Navigator.of(this.context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const AlignmentPage(),
                        ),
                      );
                    } else if (item.feature == AppFeature.iching) {
                      Navigator.of(this.context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const IChingInputPage(),
                        ),
                      );
                    } else if (item.feature == AppFeature.soulRevelation) {
                      Navigator.of(this.context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SoulRevelationIntroPage(),
                        ),
                      );
                    } else if (item.feature == AppFeature.cosmicVoid) {
                      Navigator.of(this.context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const CosmicVoidPage(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          _sidebarItem(
            Icons.settings_outlined,
            l10n.settings,
            false,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(this.context).push(
                MaterialPageRoute<void>(
                  builder: (_) => SettingsPage(localeController: widget.localeController),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sidebarHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                colors: [Color(0xFFE2C27A), Color(0xFF7D69D8)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.auto_awesome,
              size: 18,
              color: Color(0xFF130F2C),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            AppLocalizations.of(context)!.sidebarBrand,
            style: GoogleFonts.cinzel(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: _moon,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem(
    IconData icon,
    String title,
    bool isActive, {
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color:
            isActive
                ? _gold.withOpacity(0.10)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border:
            isActive
                ? Border.all(color: _gold.withOpacity(0.55), width: 1)
                : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? _gold : Colors.white60,
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? _gold : Colors.white60,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            letterSpacing: 1.2,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key, required this.selectedItem});

  final FeatureMenuItem selectedItem;
  static const Color _moon = Color(0xFFC6CBF9);
  static const Color _gold = Color(0xFFE2C27A);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          center: Alignment(0.0, -0.2),
          radius: 1.25,
          colors: [
            Color(0xFF27204F),
            Color(0xFF171730),
            Color(0xFF090B1A),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7D69D8).withOpacity(0.08),
            blurRadius: 80,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 120,
            right: 36,
            child: Icon(
              Icons.brightness_2_rounded,
              color: Color(0xFFF2E8C8),
              size: 42,
            ),
          ),
          Positioned(
            top: 72,
            right: 28,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _gold.withOpacity(0.25),
                    blurRadius: 30,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 30,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF8E75DB).withOpacity(0.35),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.homeHeroTitle,
                    style: GoogleFonts.cinzelDecorative(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: _moon,
                      letterSpacing: 2.8,
                      shadows: [
                        Shadow(
                          color: _moon.withOpacity(0.35),
                          blurRadius: 18,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.homeHeroSubtitle,
                    style: GoogleFonts.cinzel(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 2.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 34),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _gold.withOpacity(0.45),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _gold.withOpacity(0.10),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          selectedItem.title,
                          style: GoogleFonts.cinzel(
                            color: _gold,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.6,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          selectedItem.tagline,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cormorantGaramond(
                            color: Colors.white70,
                            fontSize: 19,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
