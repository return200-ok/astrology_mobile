import 'package:flutter/material.dart';
import 'core/theme/astro_theme.dart';
import 'features/profile/presentation/pages/profile_input_page.dart';

void main() {
  runApp(const AstrowebMobileApp());
}

class AstrowebMobileApp extends StatelessWidget {
  const AstrowebMobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tử Vi Đẩu Số',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: AstroTheme.darkBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: AstroTheme.darkBackground,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: AstroTheme.accentGold,
          secondary: AstroTheme.glowPurple,
          surface: AstroTheme.darkBackground,
          background: AstroTheme.darkBackground,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AstroTheme.accentGold,
            foregroundColor: AstroTheme.darkBackground,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const ProfileInputPage(),
    );
  }
}
