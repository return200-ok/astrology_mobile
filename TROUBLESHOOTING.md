# iOS Build Error - Quick Fix Reference

## What Was Wrong

5 Dart compilation errors preventing iOS build:

1. ❌ Missing closing brace in `chart_display_page.dart`
2. ❌ Wrong import path in `tuvi_chart_screen.dart`
3. ❌ Undefined theme constants (`darkBackground` → `darkBg`)
4. ❌ Wrong type for `cardTheme` (`CardTheme` → `CardThemeData`)
5. ❌ AstroTheme not accessible due to import issues

## What Was Fixed

✅ **chart_display_page.dart** - Added closing brace `}`

✅ **tuvi_chart_screen.dart** - Fixed imports:
```dart
// BEFORE (wrong)
import '../widgets/house_card.dart';
import '../../../core/theme/astro_theme.dart';  // Wrong, file in core/

// AFTER (correct)
import '../../presentation/widgets/house_card.dart';
import '../../../core/theme/astro_theme.dart';
```

✅ **astro_theme.dart** - Fixed constants and types:
```dart
// BEFORE (missing)
static const Color darkBg = Color(0xFF0a0e27);

// AFTER (complete with alias)
static const Color darkBackground = Color(0xFF0a0e27);
static const Color darkBg = Color(0xFF0a0e27); // Alias

// BEFORE (wrong type)
cardTheme: CardTheme(...)

// AFTER (correct type)
cardTheme: CardThemeData(...)
```

✅ **main.dart** - Fixed theme references (5 places):
```dart
// BEFORE (undefined)
scaffoldBackgroundColor: AstroTheme.darkBackground,

// AFTER (correct)
scaffoldBackgroundColor: AstroTheme.darkBg,
```

## How to Retry

```bash
# Navigate to project
cd /Users/cao.lv/gitlab.citigo.com.vn/local/astroweb_mobile

# Clean build
flutter clean

# Get dependencies
flutter pub get

# Run on iOS
flutter run -d iphone

# Or on iOS simulator specifically
flutter run -d ios
```

## Expected Result

✅ App should now compile and run on iOS simulator showing:
1. Profile input form (name, date, time, gender, cục)
2. Interactive Tử Vi chart on submission
3. Dark astrology theme

## Still Getting Errors?

If you see errors like:
- `Malformed bundle does not contain an identifier` - Xcode issue, may need `flutter clean` and rebuild
- Other Dart errors - Share the error message and I'll fix it

---

**Status:** ✅ **Ready to Build**  
**Build Command:** `flutter run -d iphone`  
**Estimated Build Time:** 2-3 minutes
