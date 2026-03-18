# Quick Start Guide - astroweb_mobile

Get the Flutter Tử Vi app running in 5 minutes.

## Prerequisites

Verify you have these installed:

```bash
# Check Flutter version (3.0+)
flutter --version

# Check Dart version (3.0+)
dart --version

# Check if you can build
flutter doctor
```

**Expected output:** No issues or only optional components missing.

## Setup (30 seconds)

```bash
# 1. Navigate to project
cd /Users/cao.lv/gitlab.citigo.com.vn/local/astroweb_mobile

# 2. Install dependencies
flutter pub get

# 3. Done! Ready to run
```

## Running the App

### iOS (macOS only)
```bash
flutter run -d iphone
# or
flutter run --device-id=D86DC16A-65D9-4A6A-A9B6-02B4B5730B8E
```

### Android
```bash
flutter run -d android
# or connect your device and run
```

### Web (for testing, development)
```bash
flutter run -d chrome
```

## First Launch

When you start the app, you'll see:

1. **"Nhập Thông Tin Sinh"** (Input Birth Info) screen
2. Fill in:
   - Name: e.g., "Lý Văn Cao"
   - Date: Tap the date field
   - Time: Tap the time field
   - Gender: Select Nam/Nữ
   - Cục: Choose 2-6
3. Tap **"Xem Bảng Lá Số"** (View Chart)
4. See the interactive chart with 12 houses

## Interacting with the Chart

| Action | Effect |
|--------|--------|
| **Pinch** | Zoom in/out (0.8x to 2.5x) |
| **Drag** | Pan chart around |
| **Tap House** | Highlight & show house details |
| **Tap Reset Icon** | Reset zoom to 1.0x |
| **Bottom Sheet Modal** | View all stars in selected house |

## Key Files to Know

```
lib/
├── main.dart                          # App start, theme
├── features/profile/.../profile_input_page.dart  # Form
├── features/chart/.../tuvi_chart_screen.dart     # Chart UI
├── astro_engine/chart_builder.dart    # Star calculation
└── core/theme/astro_theme.dart        # Colors & styles
```

## Common Tasks

### View the Chart Data Model
```dart
// In tuvi_chart_screen.dart, inspect _mockPalaceStars
final Map<int, List<String>> _mockPalaceStars = {
  0: ['Tử Vệ', 'Thiên Cơ'],  // Mệnh palace
  // ...
};
```

### Change Colors
Edit `lib/core/theme/astro_theme.dart`:
```dart
static const Color accentGold = Color(0xFFd4af37);  // Change this
```

### Add a New Palace
Edit `lib/features/chart/presentation/pages/tuvi_chart_screen.dart`:
```dart
static const Map<int, int> gridIndexMap = {
  0: 0,   // Mệnh
  // Add more mappings here
};
```

### Run Tests
```bash
flutter test
```

### Build for Release

**iOS:**
```bash
flutter build ios --release
# Follow iOS App Store submission guide
```

**Android:**
```bash
flutter build appbundle --release
# Upload to Google Play Store
```

**Web:**
```bash
flutter build web --release
# Output in build/web/
```

## Troubleshooting

### App won't start
```bash
# Clean build
flutter clean
flutter pub get
flutter run
```

### "No devices available"
```bash
# List available devices
flutter devices

# Open emulator/simulator first, then run
flutter run -d <device-id>
```

### Theme colors look wrong
- Check `astro_theme.dart` color values
- Verify Material3 is enabled in `main.dart`

### Chart won't display
- Check `_mockPalaceStars` data in `chart_display_page.dart`
- Verify `TuViChartScreen` receives valid `palaceStars` map

### Zoom/pan not working
- Verify `InteractiveViewer` in `tuvi_chart_screen.dart`
- Check gesture detector isn't blocking interactions

## Next Steps

1. **Integrate real engine:** Update `ChartDisplayPage` to call `generateChart()`
2. **Add state management:** Use Riverpod providers in `chart_provider.dart`
3. **Connect backend:** Call Astroweb API endpoints
4. **Customize theme:** Edit colors in `astro_theme.dart`

## Project Structure Overview

```
astroweb_mobile/
├── pubspec.yaml           # Dependencies (riverpod, hive, http, intl)
├── README.md              # Project overview
├── SETUP.md              # Detailed setup
├── IMPLEMENTATION.md     # Features & status
├── INTEGRATION.md        # How to connect pieces
├── ARCHITECTURE.md       # System design
├── lib/
│   ├── main.dart        # Entry point (Profile page)
│   ├── astro_engine/    # Star calculation (pure Dart)
│   ├── core/theme/      # Dark theme & colors
│   └── features/
│       ├── profile/     # Input form
│       └── chart/       # Chart display
└── test/                # Unit tests (TODO)
```

## Documentation

- **IMPLEMENTATION.md** - Feature checklist & current status
- **INTEGRATION.md** - How to connect form → engine → chart
- **ARCHITECTURE.md** - System design & data flow
- **SETUP.md** - Detailed development setup
- **README.md** - Project overview

## Environment Info

**Tested on:**
- Flutter 3.13.0+
- Dart 3.1.0+
- macOS (iOS development)
- Android Studio (Android development)

**Target platforms:**
- iOS 12.0+
- Android 21.0+ (Android 5.0+)

## Support & Issues

- 📖 See **INTEGRATION.md** for connecting components
- 🏗️ See **ARCHITECTURE.md** for system overview
- 🐛 Check Flutter docs: https://flutter.dev/docs

## Tips

1. **Hot reload** - Press `r` in terminal to reload changes without restart
2. **Hot restart** - Press `R` for full restart (when hot reload fails)
3. **Use DevTools** - `flutter pub global activate devtools` then `devtools`
4. **Check widgets** - Use Flutter Inspector to debug UI layout

---

**Quick Checklist:**
- [ ] Installed Flutter 3.x
- [ ] Installed Xcode/Android Studio
- [ ] Ran `flutter pub get`
- [ ] Started iOS simulator/Android emulator
- [ ] Ran `flutter run`
- [ ] Filled in form and viewed chart
- [ ] Tested zoom/pan interactions

**Time:** ~5 min setup + 2 min first run = 7 min total

**Latest Update:** March 18, 2025
