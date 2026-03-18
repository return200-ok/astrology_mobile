# Astroweb Mobile - Architecture & Components

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    Astroweb Mobile App (Flutter)                 │
└─────────────────────────────────────────────────────────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
        ┌───────────▼──────────┐   ┌──────────▼────────────┐
        │   Presentation Layer  │   │  State Management    │
        │  (UI, Screens, W.)   │   │   (Riverpod)        │
        └───────────┬──────────┘   └──────────┬────────────┘
                    │                         │
            ┌───────┼─────────┬───────────────┤
            │       │         │               │
   ┌────────▼───┐   │   ┌─────▼──────┐  ┌────▼─────────┐
   │  Profile   │   │   │   Chart    │  │  Providers   │
   │   Input    │   │   │  Display   │  │  (form data, │
   │   Page     │   │   │   Pages    │  │   chart)     │
   └────────────┘   │   └────────────┘  └──────────────┘
                    │
        ┌───────────▼──────────┐
        │   Business Logic     │
        │  (Astro Engine)      │
        └───────────┬──────────┘
                    │
         ┌──────────┼──────────┐
         │          │          │
    ┌────▼────┐ ┌──▼───┐ ┌───▼────┐
    │ Main    │ │Sec.  │ │Chart   │
    │ Stars   │ │Stars │ │Builder │
    │ Rules   │ │Rules │ │ (algo) │
    └─────────┘ └──────┘ └────────┘
                    │
        ┌───────────▼──────────┐
        │   Data Layer         │
        │  (Models, APIs)      │
        └───────────────────────┘
                    │
         ┌──────────┼──────────┐
         │          │          │
    ┌────▼────┐ ┌──▼───┐ ┌───▼────┐
    │BirthData│ │Chart │ │BirthPro│
    │         │ │      │ │file    │
    └─────────┘ └──────┘ └────────┘
```

## Screen Hierarchy

```
┌───────────────────────────────────────┐
│         Material App                   │
│      (main.dart)                       │
│     Dark Theme + AstroTheme            │
└───────────────────┬─────────────────────┘
                    │
         ┌──────────▼──────────┐
         │ ProfileInputPage    │
         │ (form entry point)  │
         └──────────┬──────────┘
                    │
                    │ Navigate with:
                    │ - name
                    │ - birthDate
                    │ - birthTime
                    │
         ┌──────────▼──────────────┐
         │ ChartDisplayPage        │
         │ (intermediate router)   │
         └──────────┬──────────────┘
                    │
                    │ Calls engine & passes
                    │ palaceStars to:
                    │
         ┌──────────▼──────────────┐
         │ TuViChartScreen         │
         │ (main chart display)    │
         ├─────────────────────────┤
         │ ┌─ InteractiveViewer    │
         │ │ (zoom/pan)            │
         │ │                       │
         │ │ ┌─ GridView 4×4       │
         │ │ │                     │
         │ │ ├─ HouseCard×12       │
         │ │ │ ├─ StarChip×N      │
         │ │ │ │ └─ Animation     │
         │ │ │ └─ onTap:Modal     │
         │ │ └─ Empty cells ×4    │
         │ └─ Button: reset zoom  │
         └─────────────────────────┘
```

## Feature Structure

```
lib/
│
├── main.dart
│   └── Theme + Navigation setup
│
├── astro_engine/
│   ├── star_engine.dart           [Core data structures]
│   │   ├── class BirthData
│   │   ├── class Star
│   │   ├── class Palace
│   │   └── class Chart
│   ├── main_star_rules.dart        [14 main star positioning]
│   │   ├── void addMainStars()
│   │   ├── calculateMenh()
│   │   ├── calculatePhucDuc()
│   │   └── ... (12 more)
│   ├── secondary_star_rules.dart   [Hour/year stars]
│   │   ├── void addSecondaryStars()
│   │   ├── calculateThienPhi()
│   │   └── ...
│   └── chart_builder.dart          [6-step generation]
│       └── Chart generateChart(BirthData)
│
├── core/
│   └── theme/
│       └── astro_theme.dart        [Colors + decorations]
│           ├── darkBackground
│           ├── accentGold
│           ├── glassCardStyle()
│           └── chartGradient()
│
└── features/
    │
    ├── profile/
    │   ├── domain/
    │   │   └── models/
    │   │       └── birth_profile.dart [Data class]
    │   │           └── class BirthProfile
    │   │
    │   └── presentation/
    │       └── pages/
    │           └── profile_input_page.dart [Form UI]
    │               ├── Material 3 TextField
    │               ├── showDatePicker
    │               ├── showTimePicker
    │               ├── SegmentedButton (gender)
    │               ├── FilterChip (cục)
    │               └── FilledButton (submit)
    │
    └── chart/
        ├── domain/
        │   └── models/
        │       ├── birth_profile.dart (duplicate*)
        │       └── birth_chart.dart [Chart result]
        │           └── class BirthChart
        │
        ├── data/
        │   └── providers/
        │       └── chart_provider.dart [Riverpod]
        │           ├── chartProvider (FutureProvider)
        │           └── profileProvider (StateProvider)
        │
        └── presentation/
            ├── pages/
            │   ├── chart_display_page.dart [Router]
            │   │   ├── Calls generateChart()
            │   │   └── Routes to TuViChartScreen
            │   │
            │   └── tuvi_chart_screen.dart [Main UI]
            │       ├── InteractiveViewer
            │       ├── GridView builder
            │       ├── HouseCard instances
            │       └── BottomSheet modal
            │
            └── widgets/
                ├── star_chip.dart [Star badge]
                │   ├── AnimationController
                │   ├── Glow pulse animation
                │   └── Tap interaction
                │
                └── house_card.dart [House container]
                    ├── Border + gradient
                    ├── Star list (Wrap)
                    └── Selection state
```

## Data Models

### BirthData (Engine Input)
```
BirthData {
  name: String
  birthDate: DateTime
  birthTime: TimeOfDay
  gender: String ('male'|'female')
  cuc: int (2-6)
}
```

### Chart (Engine Output)
```
Chart {
  name: String
  birthDate: DateTime
  palaces: List<Palace?>
}

Palace {
  index: int (0-11)
  name: String
  stars: List<Star>
  element: String
}

Star {
  name: String
  type: String ('main'|'secondary'|'fate')
  degree: double
  strength: double
}
```

### BirthProfile (UI State)
```
BirthProfile {
  name: String
  birthDate: DateTime
  birthTime: TimeOfDay
  gender: String
  cuc: int
}
```

### BirthChart (Display Model)
```
BirthChart {
  name: String
  birthDate: DateTime
  palaceStars: Map<int, List<String>>  // palace → star names
}
```

## Widget Hierarchy

```
MyApp (Material 3 dark theme)
  │
  └─ ProfileInputPage
      ├─ AppBar (Nhập Thông Tin Sinh)
      └─ SingleChildScrollView
          └─ Column
              ├─ TextField (name)
              ├─ ListTile (date picker)
              ├─ ListTile (time picker)
              ├─ Text (Gender label)
              ├─ SegmentedButton (male/female)
              ├─ Text (Cục label)
              ├─ Wrap
              │   └─ FilterChip × 5 (cục 2-6)
              └─ FilledButton (submit)
                  └─ Navigate to ChartDisplayPage

                      ↓

      └─ ChartDisplayPage
          ├─ Reads params: name, birthDate, birthTime
          ├─ Calls: generateChart(birthData)
          └─ Passes palaceStars to TuViChartScreen

                      ↓

          └─ TuViChartScreen
              ├─ AppBar
              │   ├─ Title: "Bảng Lá Số"
              │   └─ IconButton (zoom reset)
              ├─ Column
              │   ├─ Padding
              │   │   └─ Container (info card)
              │   │       ├─ Text: name
              │   │       └─ Text: date, time
              │   │
              │   └─ Expanded
              │       └─ FadeTransition
              │           └─ InteractiveViewer (zoom/pan)
              │               └─ GridView 4×4
              │                   ├─ HouseCard×12
              │                   │   ├─ AnimatedContainer
              │                   │   ├─ Column
              │                   │   │   ├─ Text: house name
              │                   │   │   └─ Wrap
              │                   │   │       └─ StarChip×N
              │                   │   │           ├─ AnimatedBuilder
              │                   │   │           └─ Container (glow)
              │                   │   └─ onTap: showModalBottomSheet
              │                   │
              │                   └─ Container × 4 (empty cells)
              │
              └─ ModalBottomSheet (house detail)
                  ├─ Text: house name
                  └─ Wrap: Chip × N (stars)
```

## Animation Timeline

### Page Load
```
TuViChartScreen init
  ├─ 0ms: _fadeController.forward()
  ├─ 0-800ms: 
  │   ├─ GridView: opacity 0→1 (fadeAnimation)
  │   └─ GridView: scale 0.95→1 (scaleAnimation)
  └─ 800ms: Complete
```

### Star Chip Glow
```
StarChip (_glowController repeating)
  ├─ 0-750ms: opacity 0.5→1 (easeInOut)
  ├─ 750-1500ms: opacity 1→0.5 (easeInOut)
  └─ Repeat indefinitely
```

### House Card Selection
```
HouseCard onTap
  ├─ 0-300ms: AnimatedContainer
  │   ├─ border: normal → gold
  │   └─ boxShadow: none → gold glow
  └─ 300ms: Highlight complete
           showModalBottomSheet (200ms material enter)
```

## Color System

### Theme Base
- darkBackground: `#0a0e27` (RGB 10, 14, 39)
- accentGold: `#d4af37` (RGB 212, 175, 55)
- glowPurple: `#8b5cf6` (RGB 139, 92, 246)
- cosmicPurple: `#3d1a5c` (RGB 61, 26, 92)
- glowCyan: `#06b6d4` (RGB 6, 182, 212)

### Element Colors (5-element system)
Mapped to house index % 5:
- Wood: `#10b981` (green)
- Fire: `#f97316` (orange)
- Earth: `#eab308` (yellow)
- Metal: `#d4af37` (gold)
- Water: `#06b6d4` (cyan)

### Opacity Usage
- Background glassmorphic: `white.withOpacity(0.05)`
- Border semi-transparent: `color.withOpacity(0.3-0.6)`
- Glow shadow: `color.withOpacity(0.2-0.4)`
- Disabled text: `Colors.white.withOpacity(0.5)`

## Interaction Flow

```
User opens app
  ↓
[ProfileInputPage]
  ├─ Fill name: TextEditingController
  ├─ Select date: showDatePicker dialog
  ├─ Select time: showTimePicker dialog
  ├─ Select gender: SegmentedButton onChange
  ├─ Select cục: FilterChip onSelected
  └─ Tap "Xem Bảng Lá Số"
      ↓
[ChartDisplayPage init]
  ├─ Extract params (name, date, time)
  ├─ Create BirthData()
  ├─ Call generateChart(birthData)
  ├─ Extract palaceStars from result
  └─ Navigate to TuViChartScreen
      ↓
[TuViChartScreen display]
  ├─ Fade-in animation (800ms)
  ├─ Show 4×4 grid with HouseCards
  ├─ StarChips start glow animation (1500ms loop)
  │
  ├─ User pinch: InteractiveViewer handles zoom
  ├─ User drag: InteractiveViewer handles pan
  ├─ User tap house:
  │   ├─ HouseCard highlight (300ms)
  │   └─ showModalBottomSheet with details
  │
  └─ User tap reset icon: Transform reset to identity
```

## Dependencies Map

```
main.dart
  │
  ├─ astro_theme.dart
  │   └─ Colors, BoxDecoration styles
  │
  ├─ ProfileInputPage
  │   ├─ intl (for date formatting)
  │   ├─ Material widgets
  │   └─ ChartDisplayPage (navigation)
  │
  ├─ ChartDisplayPage
  │   ├─ astro_engine/* (generateChart)
  │   ├─ TuViChartScreen (routing)
  │   └─ BirthData creation
  │
  ├─ TuViChartScreen
  │   ├─ HouseCard
  │   │   └─ StarChip
  │   │       └─ Animation
  │   ├─ InteractiveViewer (Flutter SDK)
  │   └─ astro_theme (colors)
  │
  └─ (Future) Riverpod providers
      ├─ chartProvider (FutureProvider)
      └─ profileProvider (StateProvider)
```

## Performance Considerations

### Grid Rendering
- 4×4 GridView: 16 items, most are empty containers
- HouseCards: Only 12 rendered (lazy indexing)
- StarChips: Variable count per palace, wrapped for efficient layout

### Animations
- FadeTransition: GPU-accelerated (efficient)
- AnimatedContainer: GPU-accelerated (efficient)
- AnimatedBuilder (StarChip): Rebuilds only the glow, not entire widget tree

### Memory
- BirthData + Chart: Small (~10KB per chart)
- Theme: Singleton pattern (AstroTheme static colors)
- Controllers: Disposed in onDispose() to prevent leaks

## Accessibility

### Current Features
- Dark mode (theme set to dark)
- Clear contrasts (gold on dark navy)
- Interactive elements: large touch targets (48dp+ padding)

### Recommended Additions
- Semantic labels for screen reader
- Text size settings
- High contrast mode option
- Gesture alternatives (e.g., buttons instead of pinch)

---

**Last Updated:** March 18, 2025  
**Architecture Version:** 0.1.0
