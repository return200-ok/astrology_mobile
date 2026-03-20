# Astroweb Mobile - Kiến Trúc & Thành Phần

## Kiến Trúc Hệ Thống

```
┌─────────────────────────────────────────────────────────────────┐
│                  Ứng dụng Astroweb Mobile (Flutter)             │
└─────────────────────────────────────────────────────────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
        ┌───────────▼──────────┐   ┌──────────▼────────────┐
        │    Tầng Presentation │   │   Quản lý trạng thái  │
        │  (UI, Screen, Widget)│   │      (Riverpod)       │
        └───────────┬──────────┘   └──────────┬────────────┘
                    │                         │
            ┌───────┼─────────┬───────────────┤
            │       │         │               │
   ┌────────▼───┐   │   ┌─────▼──────┐  ┌────▼─────────┐
   │  Trang nhập│   │   │   Trang    │  │  Providers   │
   │  hồ sơ sinh│   │   │  hiển thị  │  │  (form data, │
   │            │   │   │   lá số    │  │   chart)     │
   └────────────┘   │   └────────────┘  └──────────────┘
                    │
        ┌───────────▼──────────┐
        │      Business Logic  │
        │     (Astro Engine)   │
        └───────────┬──────────┘
                    │
         ┌──────────┼──────────┐
         │          │          │
    ┌────▼────┐ ┌──▼───┐ ┌───▼────┐
    │ Quy tắc │ │Quy tắc│ │Chart   │
    │ chính   │ │phụ tinh││Builder│
    │ tinh    │ │       ││ (algo) │
    └─────────┘ └──────┘ └────────┘
                    │
        ┌───────────▼──────────┐
        │      Tầng dữ liệu    │
        │    (Model, API)      │
        └───────────────────────┘
                    │
         ┌──────────┼──────────┐
         │          │          │
    ┌────▼────┐ ┌──▼───┐ ┌───▼────┐
    │BirthData│ │Chart │ │BirthPro│
    │         │ │      │ │file    │
    └─────────┘ └──────┘ └────────┘
```

## Cây Màn Hình

```
┌───────────────────────────────────────┐
│           Material App                 │
│            (main.dart)                 │
│       Dark Theme + AstroTheme          │
└───────────────────┬─────────────────────┘
                    │
         ┌──────────▼──────────┐
         │ ProfileInputPage    │
         │ (điểm vào form)     │
         └──────────┬──────────┘
                    │
                    │ Điều hướng với:
                    │ - name
                    │ - birthDate
                    │ - birthTime
                    │
         ┌──────────▼──────────────┐
         │ ChartDisplayPage        │
         │ (trang router trung gian)│
         └──────────┬──────────────┘
                    │
                    │ Gọi engine và truyền
                    │ palaceStars vào:
                    │
         ┌──────────▼──────────────┐
         │ TuViChartScreen         │
         │ (màn hình lá số chính)  │
         ├─────────────────────────┤
         │ ┌─ InteractiveViewer    │
         │ │ (zoom/pan)            │
         │ │                       │
         │ │ ┌─ GridView 4×4       │
         │ │ │                     │
         │ │ ├─ HouseCard×12       │
         │ │ │ ├─ StarChip×N       │
         │ │ │ │ └─ Animation      │
         │ │ │ └─ onTap:Modal      │
         │ │ └─ Ô trống ×4         │
         │ └─ Nút reset zoom       │
         └─────────────────────────┘
```

## Cấu Trúc Theo Feature

```
lib/
│
├── main.dart
│   └── Cấu hình Theme + Navigation
│
├── astro_engine/
│   ├── star_engine.dart            [Cấu trúc dữ liệu lõi]
│   │   ├── class BirthData
│   │   ├── class Star
│   │   ├── class Palace
│   │   └── class Chart
│   ├── main_star_rules.dart        [Quy tắc định vị 14 chính tinh]
│   │   ├── void addMainStars()
│   │   ├── calculateMenh()
│   │   ├── calculatePhucDuc()
│   │   └── ... (12 hàm nữa)
│   ├── secondary_star_rules.dart   [Sao theo giờ/năm]
│   │   ├── void addSecondaryStars()
│   │   ├── calculateThienPhi()
│   │   └── ...
│   └── chart_builder.dart          [Sinh lá số qua 6 bước]
│       └── Chart generateChart(BirthData)
│
├── core/
│   └── theme/
│       └── astro_theme.dart        [Màu sắc + trang trí]
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
    │           └── profile_input_page.dart [UI form]
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
        │       └── birth_chart.dart [Kết quả lá số]
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
            │   │   ├── Gọi generateChart()
            │   │   └── Điều hướng tới TuViChartScreen
            │   │
            │   └── tuvi_chart_screen.dart [UI chính]
            │       ├── InteractiveViewer
            │       ├── GridView builder
            │       ├── HouseCard instances
            │       └── BottomSheet modal
            │
            └── widgets/
                ├── star_chip.dart [Badge sao]
                │   ├── AnimationController
                │   ├── Glow pulse animation
                │   └── Tap interaction
                │
                └── house_card.dart [Khung cung]
                    ├── Border + gradient
                    ├── Danh sách sao (Wrap)
                    └── Trạng thái được chọn
```

## Data Models

### BirthData (Input cho Engine)
```
BirthData {
  name: String
  birthDate: DateTime
  birthTime: TimeOfDay
  gender: String ('male'|'female')
  cuc: int (2-6)
}
```

### Chart (Output từ Engine)
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

### BirthProfile (Trạng thái UI)
```
BirthProfile {
  name: String
  birthDate: DateTime
  birthTime: TimeOfDay
  gender: String
  cuc: int
}
```

### BirthChart (Model hiển thị)
```
BirthChart {
  name: String
  birthDate: DateTime
  palaceStars: Map<int, List<String>>  // cung → tên sao
}
```

## Cây Widget

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
              ├─ Text (nhãn giới tính)
              ├─ SegmentedButton (male/female)
              ├─ Text (nhãn Cục)
              ├─ Wrap
              │   └─ FilterChip × 5 (cục 2-6)
              └─ FilledButton (submit)
                  └─ Navigate to ChartDisplayPage

                      ↓

      └─ ChartDisplayPage
          ├─ Đọc params: name, birthDate, birthTime
          ├─ Gọi: generateChart(birthData)
          └─ Truyền palaceStars sang TuViChartScreen

                      ↓

          └─ TuViChartScreen
              ├─ AppBar
              │   ├─ Title: "Bảng Lá Số"
              │   └─ IconButton (reset zoom)
              ├─ Column
              │   ├─ Padding
              │   │   └─ Container (thẻ thông tin)
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
              │                   │   │   ├─ Text: tên cung
              │                   │   │   └─ Wrap
              │                   │   │       └─ StarChip×N
              │                   │   │           ├─ AnimatedBuilder
              │                   │   │           └─ Container (glow)
              │                   │   └─ onTap: showModalBottomSheet
              │                   │
              │                   └─ Container × 4 (ô trống)
              │
              └─ ModalBottomSheet (chi tiết cung)
                  ├─ Text: tên cung
                  └─ Wrap: Chip × N (các sao)
```

## Dòng Thời Gian Animation

### Khi tải trang
```
TuViChartScreen init
  ├─ 0ms: _fadeController.forward()
  ├─ 0-800ms:
  │   ├─ GridView: opacity 0→1 (fadeAnimation)
  │   └─ GridView: scale 0.95→1 (scaleAnimation)
  └─ 800ms: Hoàn tất
```

### Glow của Star Chip
```
StarChip (_glowController lặp liên tục)
  ├─ 0-750ms: opacity 0.5→1 (easeInOut)
  ├─ 750-1500ms: opacity 1→0.5 (easeInOut)
  └─ Lặp vô hạn
```

### Chọn House Card
```
HouseCard onTap
  ├─ 0-300ms: AnimatedContainer
  │   ├─ border: bình thường → vàng
  │   └─ boxShadow: không có → glow vàng
  └─ 300ms: Highlight hoàn tất
           showModalBottomSheet (material enter 200ms)
```

## Hệ Màu

### Màu nền tảng
- darkBackground: `#0a0e27` (RGB 10, 14, 39)
- accentGold: `#d4af37` (RGB 212, 175, 55)
- glowPurple: `#8b5cf6` (RGB 139, 92, 246)
- cosmicPurple: `#3d1a5c` (RGB 61, 26, 92)
- glowCyan: `#06b6d4` (RGB 6, 182, 212)

### Màu ngũ hành (hệ 5 hành)
Ánh xạ theo `house index % 5`:
- Wood: `#10b981` (green)
- Fire: `#f97316` (orange)
- Earth: `#eab308` (yellow)
- Metal: `#d4af37` (gold)
- Water: `#06b6d4` (cyan)

### Cách dùng opacity
- Nền glassmorphic: `white.withOpacity(0.05)`
- Viền bán trong suốt: `color.withOpacity(0.3-0.6)`
- Bóng glow: `color.withOpacity(0.2-0.4)`
- Chữ disabled: `Colors.white.withOpacity(0.5)`

## Luồng Tương Tác

```
Người dùng mở app
  ↓
[ProfileInputPage]
  ├─ Điền tên: TextEditingController
  ├─ Chọn ngày: dialog showDatePicker
  ├─ Chọn giờ: dialog showTimePicker
  ├─ Chọn giới tính: SegmentedButton onChange
  ├─ Chọn cục: FilterChip onSelected
  └─ Bấm "Xem Bảng Lá Số"
      ↓
[ChartDisplayPage init]
  ├─ Lấy params (name, date, time)
  ├─ Tạo BirthData()
  ├─ Gọi generateChart(birthData)
  ├─ Trích xuất palaceStars từ kết quả
  └─ Điều hướng sang TuViChartScreen
      ↓
[TuViChartScreen display]
  ├─ Fade-in animation (800ms)
  ├─ Hiển thị lưới 4×4 với HouseCard
  ├─ StarChip chạy glow animation (vòng lặp 1500ms)
  │
  ├─ Người dùng pinch: InteractiveViewer xử lý zoom
  ├─ Người dùng drag: InteractiveViewer xử lý pan
  ├─ Người dùng tap cung:
  │   ├─ HouseCard highlight (300ms)
  │   └─ showModalBottomSheet hiển thị chi tiết
  │
  └─ Người dùng tap icon reset: Transform về identity
```

## Bản Đồ Dependencies

```
main.dart
  │
  ├─ astro_theme.dart
  │   └─ Colors, BoxDecoration styles
  │
  ├─ ProfileInputPage
  │   ├─ intl (định dạng ngày)
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
  └─ (Tương lai) Riverpod providers
      ├─ chartProvider (FutureProvider)
      └─ profileProvider (StateProvider)
```

## Lưu Ý Hiệu Năng

### Render Grid
- GridView 4×4: 16 item, phần lớn là ô trống
- HouseCard: chỉ 12 ô được render
- StarChip: số lượng thay đổi theo cung, dùng Wrap để layout hiệu quả

### Animation
- FadeTransition: GPU-accelerated (hiệu quả)
- AnimatedContainer: GPU-accelerated (hiệu quả)
- AnimatedBuilder (StarChip): chỉ rebuild phần glow, không rebuild toàn cây widget

### Bộ nhớ
- BirthData + Chart: nhỏ (~10KB mỗi lá số)
- Theme: mô hình singleton (AstroTheme static colors)
- Controller: dispose trong onDispose() để tránh rò rỉ

## Accessibility

### Hiện có
- Dark mode (theme đặt sẵn tông tối)
- Tương phản rõ (vàng trên nền navy tối)
- Thành phần tương tác có vùng chạm lớn (padding 48dp+)

### Khuyến nghị bổ sung
- Semantic labels cho screen reader
- Tuỳ chỉnh cỡ chữ
- Chế độ độ tương phản cao
- Tùy chọn thao tác thay thế cử chỉ (ví dụ nút thay vì pinch)

---

**Cập nhật lần cuối:** 18/03/2025  
**Phiên bản kiến trúc:** 0.1.0
