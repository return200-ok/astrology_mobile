# Astroweb Mobile - Flutter

Full-stack mobile astrology application built with Flutter. Companion app to the Astroweb web platform.

## Features

- 📱 Cross-platform: iOS & Android
- ✨ Beautiful dark astrology theme
- 📊 12-house astrology chart with interactive UI
- 🌙 Lunar calendar integration
- 💾 Local data persistence
- 🔄 API integration with Astroweb backend

## Tech Stack

- **Framework**: Flutter 3.x with Dart null safety
- **State Management**: Riverpod
- **Local Storage**: Hive
- **API Client**: HTTP + Retrofit
- **UI**: Material Design 3 + custom animations

## Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.x or higher)
- Xcode (for iOS development)
- Android Studio (for Android development)
- Dart SDK (included with Flutter)

## Installation

1. Clone repository:
```bash
git clone <repo-url>
cd astroweb_mobile
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run app:
```bash
# Debug mode
flutter run

# iOS specific
flutter run -d iPhone

# Android specific
flutter run -d android
```

## Development

### Project Structure

```
lib/
├── features/          # Feature modules (chart, profile, etc.)
├── astro_engine/      # Pure Dart astrology calculation engine
├── core/              # Core utilities, theme, widgets
└── main.dart          # App entry point
```

### Available Commands

| Command | Purpose |
|---------|---------|
| `flutter pub get` | Install dependencies |
| `flutter run` | Run in debug mode |
| `flutter build apk` | Build Android APK |
| `flutter build ios` | Build iOS app |
| `flutter test` | Run tests |
| `flutter analyze` | Code analysis |

## Astrology Engine

The app includes a pure Dart astrology engine (`lib/astro_engine/`) that calculates:

- 14 main stars (Tử Vi, Thiên Cơ, Thái Dương, etc.)
- 12 secondary stars (Văn Xương, Hóa Tinh, etc.)
- Lunar date conversion
- 12 astrological houses

**Note**: No external astronomy libraries required - fully deterministic calculations.

## API Integration

Connect to Astroweb backend:

```dart
// lib/data/services/astroweb_api.dart
class AstrowebApiClient {
  Future<BirthChart> generateChart(BirthProfile profile) async {
    // API calls to backend
  }
}
```

## Building for Production

### Android

```bash
# APK
flutter build apk --release

# App Bundle (Play Store)
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
# Then open in Xcode for signing & deployment
```

## Testing

```bash
# Run unit tests
flutter test

# Run with coverage
flutter test --coverage
```

## Contributing

1. Create feature branch: `git checkout -b feature/your-feature`
2. Commit changes: `git commit -m "feat: add feature"`
3. Push to repo: `git push origin feature/your-feature`
4. Create pull request

## License

MIT - See [LICENSE](LICENSE) for details

## Support

For issues or questions:
- Open GitHub issue
- Check [Astroweb Web](../astroweb-99-cyber-mystic-astrology) for backend details
# astrology_mobile
