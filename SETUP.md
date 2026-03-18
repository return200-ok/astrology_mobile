# Astroweb Mobile - Setup Guide

## Quick Start

```bash
cd /Users/cao.lv/gitlab.citigo.com.vn/local/astroweb_mobile

# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Run on specific device
flutter run -d iPhone
flutter run -d android
```

## File Structure

```
astroweb_mobile/
├── lib/
│   ├── features/          # Feature modules
│   │   ├── profile/       # Birth profile input
│   │   └── chart/         # Astrology chart display
│   ├── astro_engine/      # Pure Dart calculation engine
│   ├── core/              # Theme, widgets, utilities
│   └── main.dart          # App entry point
├── test/                  # Unit & widget tests
├── pubspec.yaml           # Dependencies
├── analysis_options.yaml  # Lint rules
└── README.md
```

## Key Features

✅ **Astro Engine**: 14 main stars + 12 secondary stars + 12 houses  
✅ **Dark Theme**: Beautiful astrology-themed UI  
✅ **Interactive Chart**: Zoom, pan, tap for details  
✅ **Lunar Calendar**: Automatic date conversion  
✅ **State Management**: Riverpod for reactive state  
✅ **Local Storage**: Hive for offline data  

## Building

```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release
flutter build appbundle --release
```

## Testing

```bash
flutter test
flutter test --coverage
```

## Development Tips

- Use `flutter analyze` to check code quality
- Run `flutter pub upgrade` to update dependencies
- Use `flutter doctor` to verify setup
- Enable hot reload: `r` in terminal while running

## Related Repos

- **Web App**: [astroweb-99-cyber-mystic-astrology](../astroweb-99-cyber-mystic-astrology)
- **Flutter Tuvi App**: [a_tuvi](../a_tuvi)
