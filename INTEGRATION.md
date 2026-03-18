# Integration Guide - astroweb_mobile

This guide connects the pieces of the astroweb_mobile app: input form → engine calculation → interactive chart display.

## Data Flow

```
ProfileInputPage (form submission)
    ↓
    └→ ChartDisplayPage (navigation with params)
        ↓
        └→ TuViChartScreen (chart display with mock data)
            ├─→ HouseCard × 12 (house containers)
            └─→ StarChip × N (star badges with glow)
```

## Current Implementation Status

### ✅ Phase 1: UI/UX Complete
- `lib/features/profile/presentation/pages/profile_input_page.dart` - Input form ready
- `lib/features/chart/presentation/pages/tuvi_chart_screen.dart` - Interactive chart ready
- `lib/features/chart/presentation/widgets/house_card.dart` - House card widget complete
- `lib/features/chart/presentation/widgets/star_chip.dart` - Star chip with glow animation
- `lib/core/theme/astro_theme.dart` - Dark theme with exact web colors
- `lib/main.dart` - App entry point configured

### ✅ Phase 2: Engine Integration Ready
- `lib/astro_engine/star_engine.dart` - BirthData, Chart classes
- `lib/astro_engine/main_star_rules.dart` - 14 main stars
- `lib/astro_engine/secondary_star_rules.dart` - Hour/year stars
- `lib/astro_engine/chart_builder.dart` - generateChart() function

### ⏳ Phase 3: State Management (Next)
- `lib/features/chart/data/providers/chart_provider.dart` - Riverpod providers (skeleton)

## Next Steps to Complete Integration

### Step 1: Connect Engine to ChartDisplayPage

Update `ChartDisplayPage` to call the astro engine:

```dart
// In chart_display_page.dart
import '../../domain/models/birth_profile.dart' as profile_model;
import '../../../astro_engine/star_engine.dart' as engine;
import '../../../astro_engine/chart_builder.dart';

class _ChartDisplayPageState extends State<ChartDisplayPage> {
  late Map<int, List<String>> _palaceStars;

  @override
  void initState() {
    super.initState();
    _generateChart();
  }

  void _generateChart() {
    final birthData = engine.BirthData(
      name: widget.name,
      birthDate: widget.birthDate,
      birthTime: widget.birthTime,
      // TODO: Add gender and cục from form
    );

    final chart = generateChart(birthData);
    
    setState(() {
      _palaceStars = {
        for (int i = 0; i < 12; i++)
          i: chart.palaces[i]?.stars.map((star) => star.name).toList() ?? []
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return TuViChartScreen(
      name: widget.name,
      birthDate: widget.birthDate,
      birthTime: widget.birthTime,
      palaceStars: _palaceStars,
    );
  }
}
```

### Step 2: Update ProfileInputPage to Pass Additional Data

Modify `profile_input_page.dart` to pass gender and cục:

```dart
void _submit() {
  if (!_isFormValid()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
    );
    return;
  }

  // Pass gender and cục to ChartDisplayPage
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChartDisplayPage(
        name: _nameController.text,
        birthDate: _birthDate!,
        birthTime: _birthTime!,
        gender: _gender,        // Add this
        cuc: _cucNumber,        // Add this
      ),
    ),
  );
}
```

### Step 3: Add Riverpod State Management (Optional but Recommended)

Create providers for form state and chart generation:

```dart
// lib/features/chart/data/providers/chart_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/birth_profile.dart';
import '../../domain/models/birth_chart.dart';
import '../../../astro_engine/star_engine.dart' as engine;
import '../../../astro_engine/chart_builder.dart';

final profileProvider = StateProvider<BirthProfile?>((ref) => null);

final chartProvider = FutureProvider.family<BirthChart?, BirthProfile>((ref, profile) async {
  final birthData = engine.BirthData(
    name: profile.name,
    birthDate: profile.birthDate,
    birthTime: profile.birthTime,
    gender: profile.gender,
    cuc: profile.cuc,
  );

  final chart = generateChart(birthData);

  return BirthChart(
    name: profile.name,
    birthDate: profile.birthDate,
    palaceStars: {
      for (int i = 0; i < 12; i++)
        i: chart.palaces[i]?.stars.map((star) => star.name).toList() ?? []
    },
  );
});
```

### Step 4: Duplicate BirthProfile Model (if using separate layers)

Currently there are two `BirthProfile` models:
- `lib/features/profile/domain/models/birth_profile.dart`
- `lib/features/chart/domain/models/birth_profile.dart` (was created for chart layer)

**Option A: Remove duplicate (recommended)**
Delete the chart version and import from profile:

```dart
// In chart files, import from profile:
import '../../../features/profile/domain/models/birth_profile.dart';
```

**Option B: Keep separated (if needed for independence)**
Use distinct names or organize differently.

## Testing the Integration

1. **Run the app:**
   ```bash
   flutter run
   ```

2. **Test input → display flow:**
   - Fill in profile form (name, date, time)
   - Select gender and cục
   - Tap "Xem Bảng Lá Số"
   - Should navigate to interactive chart

3. **Test chart interactions:**
   - Zoom (pinch) - should scale 0.8x to 2.5x
   - Pan (drag) - should move chart
   - Tap house - should highlight and show bottom sheet
   - Tap reset button - should reset zoom/pan

## File Dependencies

```
main.dart
├── core/theme/astro_theme.dart
└── features/profile/presentation/pages/profile_input_page.dart
    ├── intl (date formatting)
    └── chart/presentation/pages/chart_display_page.dart
        ├── chart/presentation/pages/tuvi_chart_screen.dart
        │   ├── chart/presentation/widgets/house_card.dart
        │   │   └── chart/presentation/widgets/star_chip.dart
        │   └── core/theme/astro_theme.dart (colors, decorations)
        ├── astro_engine/star_engine.dart (BirthData, Chart)
        └── astro_engine/chart_builder.dart (generateChart)
```

## Astro Engine API

### BirthData Class
```dart
BirthData(
  name: String,
  birthDate: DateTime,
  birthTime: TimeOfDay,
  gender: String, // 'male' or 'female'
  cuc: int,       // 2-6 (direction/zone)
)
```

### Chart Class
```dart
Chart {
  name: String,
  birthDate: DateTime,
  palaces: List<Palace?>, // 12 palaces, each with stars
}

Palace {
  index: int,
  name: String,
  stars: List<Star>, // Stars in this palace
}

Star {
  name: String,
  type: String, // 'main', 'secondary', 'fate'
  degree: double,
  strength: double,
}
```

### generateChart() Function
```dart
Chart generateChart(BirthData data)
```

Returns a complete chart with all 40 stars positioned in 12 palaces based on birth data.

## Styling Reference

All colors and animations match the web app:

### Colors
- Background: `#0a0e27` (dark navy)
- Primary: `#d4af37` (gold)
- Secondary: `#3d1a5c` (cosmic purple)
- Glow: `#8b5cf6` (bright purple)
- Element water: `#06b6d4` (cyan)

### Animations
- Fade-in: 800ms, easeOut
- Scale: 0.95 → 1.0, 800ms
- Glow pulse: 1500ms, easeInOut, 0.5 → 1.0 opacity

### Decorations
- Glassmorphic cards: `Colors.white.withOpacity(0.05)` background, gold/purple borders
- Shadows: `blurRadius: 8-12`, colored shadows matching element
- Border radius: 8-12dp for most elements

## Common Issues & Solutions

### Issue: "BirthProfile imported from multiple sources"
**Solution:** Use one BirthProfile model in `features/profile/domain/models/`. Import from there everywhere else.

### Issue: "Chart generation is async but UI not updating"
**Solution:** Wrap chart generation in `setState()` or use Riverpod `FutureProvider`.

### Issue: "Stars not showing in houses"
**Solution:** Verify engine is correctly assigning stars to palaces. Check `chart_builder.dart` output.

### Issue: "Theme colors don't match web"
**Solution:** Cross-check hex values in `astro_theme.dart` against web app design system.

## Migration Path

When fully integrated, the data flow becomes:

```
Provider Input (form state)
    ↓
    └→ chartProvider (engine calculation)
        ↓
        └→ Chart display (UI layer consumed from provider)
```

This allows:
- Sharing chart state across screens
- Offline caching with Hive
- Undo/redo functionality
- Exporting to image/PDF

## Next Phases

### Phase 4: Backend Integration
- Connect to Astroweb API (Cloudflare Workers)
- Add authentication if needed
- Sync profile data between mobile and web

### Phase 5: Advanced Features
- Tương hợp (compatibility) calculator
- Year/month/day cycle views
- Star detail pages
- Chart sharing and export

### Phase 6: Polish
- Theme customization
- Accessibility (dark mode, text size)
- Internationalization (if needed)
- Performance optimization

---

**Last Updated:** March 18, 2025
