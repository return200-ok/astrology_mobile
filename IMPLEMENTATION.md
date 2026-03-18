# Astroweb Mobile - Flutter App

A mobile-first companion to the Astroweb astrology web app, built with Flutter for iOS and Android.

## Features

✨ **Interactive Tử Vi Chart**
- 12-house Tử Vi (Vietnamese astrology) chart display
- Zoom and pan interactions (0.8x to 2.5x scale)
- Tap to select houses and view detailed star information
- Glassmorphic UI with animated glow effects
- Element-based color coding (Wood, Fire, Earth, Metal, Water)

🌙 **Birth Profile Input**
- Material 3 form with date and time pickers
- Gender selection
- Cục (direction) selector (2-6)
- Form validation

📊 **Chart Display**
- 12 palace houses in 4×4 grid layout
- Star chips with pulsing glow animations
- House cards with border highlighting
- Bottom sheet modal for detailed house information

🎨 **Design System**
- Dark astrology theme (navy, cosmic purple, gold)
- Glassmorphism effects (semi-transparent cards, glow borders)
- Smooth animations (fade-in, scale, glow pulse)
- Exact color match to web app (Astroweb)

## Getting Started

### Prerequisites

- Flutter 3.x (or later)
- Dart 3.x
- iOS: Xcode 14+ (for iOS builds)
- Android: Android Studio 4.1+ (for Android builds)

### Installation

1. **Clone the repo:**
   ```bash
   cd /Users/cao.lv/gitlab.citigo.com.vn/local/astroweb_mobile
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   # iOS (requires macOS)
   flutter run -d iphone

   # Android
   flutter run -d android

   # Web (development)
   flutter run -d chrome
   ```

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── astro_engine/                      # Pure Dart astro engine
│   ├── star_engine.dart              # Core calculations (BirthData, Chart)
│   ├── main_star_rules.dart          # 14 main stars positioning
│   ├── secondary_star_rules.dart     # Hour/year stars, secondary effects
│   └── chart_builder.dart            # Chart generation algorithm
├── core/
│   └── theme/
│       └── astro_theme.dart          # Dark theme, colors, decorations
└── features/
    ├── profile/
    │   ├── domain/models/
    │   │   └── birth_profile.dart    # BirthProfile data class
    │   └── presentation/pages/
    │       └── profile_input_page.dart # Input form with pickers
    └── chart/
        ├── domain/models/
        │   ├── birth_profile.dart    # (duplicate from profile/)
        │   └── birth_chart.dart      # Chart result data
        ├── data/providers/
        │   └── chart_provider.dart   # Riverpod state management
        └── presentation/
            ├── pages/
            │   ├── chart_display_page.dart  # Chart navigation
            │   └── tuvi_chart_screen.dart   # Main chart UI
            └── widgets/
                ├── star_chip.dart       # Star badge with animation
                └── house_card.dart      # House container with stars
```

## Architecture

**Features-based structure:**
- `profile/` - User input (name, birth date/time, gender)
- `chart/` - Chart calculation and display

**Layer separation:**
- `domain/models/` - Data classes
- `data/providers/` - State management (Riverpod)
- `presentation/pages/` - Full-page screens
- `presentation/widgets/` - Reusable UI components

**Engine:**
- Pure Dart astro_engine isolated from UI
- Deterministic modulo-12 calculations
- 40 stars total: 14 main + 12 secondary + 12 fate cycle

**State Management:**
- Riverpod for reactive state
- ProfileProvider: Birth profile data
- ChartProvider: Chart generation (async)

## Theme Colors

| Name | Hex | Use |
|------|-----|-----|
| darkBg | #0a0e27 | Background |
| cosmicPurple | #3d1a5c | Secondary accent |
| accentGold | #d4af37 | Primary accent |
| glowPurple | #8b5cf6 | Glow/border |
| glowCyan | #06b6d4 | Element color |

## Animations

- **Fade-in:** Chart display on load (800ms, easeOut)
- **Scale:** Chart entry (0.95 → 1.0 scale)
- **Glow pulse:** Star chips continuous animation (1500ms, easeInOut)
- **Selection highlight:** House card border/glow on tap (300ms)

## Dependencies

```yaml
flutter_riverpod: ^2.4.0      # State management
hive: ^2.2.3                  # Local storage
hive_flutter: ^1.1.0          # Hive Flutter integration
http: ^1.1.0                  # HTTP client
intl: ^0.19.0                 # Date formatting
```

## Development

### Running Tests

```bash
flutter test
```

### Building

```bash
# iOS
flutter build ios --release

# Android (AAB)
flutter build appbundle --release

# Android (APK)
flutter build apk --release

# Web
flutter build web --release
```

### Code Generation (if using freezed, json_serializable, etc.)

```bash
flutter pub run build_runner build
```

## Project Status

✅ **Completed:**
- Astro engine (star positioning, 12-house system)
- Theme system (colors, glassmorphism, animations)
- Profile input page (Material 3, date/time pickers)
- Interactive chart screen (TuViChartScreen)
- Star chips with glow animation
- House cards with element colors
- Chart navigation (form → display)

⏳ **In Progress:**
- Chart generation integration (engine → UI data flow)
- Riverpod state management (form submission hook)
- API integration (connect to web backend)

⏭️ **Planned:**
- Compatibility analysis (tương hợp) between two profiles
- Year/month/day cycle views
- Star detail tooltips
- Theme customization (light/dark)
- Offline mode with Hive
- Share chart as image

## Related Projects

- **astroweb-99-cyber-mystic-astrology** (React Web) - Web version with Cloudflare Workers backend
- **a_tuvi** (Flutter Legacy) - Original Tử Vi app (separate from mobile/web)

## Design Reference

The mobile app matches the web app design system exactly:
- Same dark theme colors and gradients
- Glassmorphism borders and shadows
- Matching animation timing and curves
- Material 3 components (web uses shadcn/ui equivalent)

## Contributing

Pull requests welcome! Please ensure:
1. Code follows Flutter/Dart style guidelines
2. Tests pass (`flutter test`)
3. No breaking changes without discussion

## License

[License info here]

## Contact

For issues, questions, or feature requests, please create an issue in the GitLab repository.

---

**Last Updated:** March 18, 2025  
**Version:** 0.1.0 (pre-release)
