# Hướng Dẫn Tích Hợp - astroweb_mobile

Tài liệu này kết nối các phần của ứng dụng astroweb_mobile: form nhập liệu → engine tính toán → màn hình lá số tương tác.

## Luồng Dữ Liệu

```
ProfileInputPage (submit form)
    ↓
    └→ ChartDisplayPage (điều hướng kèm params)
        ↓
        └→ TuViChartScreen (hiển thị lá số với dữ liệu mock)
            ├─→ HouseCard × 12 (khung cung)
            └─→ StarChip × N (badge sao có glow)
```

## Trạng Thái Triển Khai Hiện Tại

### ✅ Giai đoạn 1: UI/UX Hoàn Thành
- `lib/features/profile/presentation/pages/profile_input_page.dart` - Form nhập liệu đã sẵn sàng
- `lib/features/chart/presentation/pages/tuvi_chart_screen.dart` - Lá số tương tác đã sẵn sàng
- `lib/features/chart/presentation/widgets/house_card.dart` - Widget house card hoàn chỉnh
- `lib/features/chart/presentation/widgets/star_chip.dart` - Star chip với animation phát sáng
- `lib/core/theme/astro_theme.dart` - Theme tối với màu khớp web
- `lib/main.dart` - Điểm vào ứng dụng đã cấu hình

### ✅ Giai đoạn 2: Sẵn Sàng Tích Hợp Engine
- `lib/astro_engine/star_engine.dart` - Các class BirthData, Chart
- `lib/astro_engine/main_star_rules.dart` - 14 chính tinh
- `lib/astro_engine/secondary_star_rules.dart` - Sao theo giờ/năm
- `lib/astro_engine/chart_builder.dart` - Hàm `generateChart()`

### ⏳ Giai đoạn 3: State Management (Tiếp Theo)
- `lib/features/chart/data/providers/chart_provider.dart` - Riverpod providers (khung)

## Các Bước Hoàn Tất Tích Hợp

### Bước 1: Nối Engine vào ChartDisplayPage

Cập nhật `ChartDisplayPage` để gọi astro engine:

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
      // TODO: Thêm gender và cục từ form
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

### Bước 2: Cập Nhật ProfileInputPage để Truyền Thêm Dữ Liệu

Sửa `profile_input_page.dart` để truyền gender và cục:

```dart
void _submit() {
  if (!_isFormValid()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
    );
    return;
  }

  // Truyền gender và cục sang ChartDisplayPage
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

### Bước 3: Thêm Riverpod State Management (Tùy Chọn Nhưng Khuyến Nghị)

Tạo providers cho trạng thái form và sinh lá số:

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

### Bước 4: Model BirthProfile Bị Trùng (nếu tách layer riêng)

Hiện tại có 2 model `BirthProfile`:
- `lib/features/profile/domain/models/birth_profile.dart`
- `lib/features/chart/domain/models/birth_profile.dart` (được tạo cho chart layer)

**Phương án A: Bỏ trùng lặp (khuyến nghị)**
Xóa bản trong chart và import từ profile:

```dart
// Trong chart files, import từ profile:
import '../../../features/profile/domain/models/birth_profile.dart';
```

**Phương án B: Giữ tách biệt (nếu cần độc lập)**
Dùng tên rõ ràng hơn hoặc tổ chức khác đi.

## Kiểm Thử Luồng Tích Hợp

1. **Chạy ứng dụng:**
   ```bash
   flutter run
   ```

2. **Test luồng input → display:**
   - Điền form hồ sơ (tên, ngày, giờ)
   - Chọn giới tính và cục
   - Bấm "Xem Bảng Lá Số"
   - Ứng dụng phải điều hướng đến màn hình lá số tương tác

3. **Test tương tác lá số:**
   - Zoom (pinch) - tỉ lệ 0.8x đến 2.5x
   - Pan (drag) - lá số di chuyển theo thao tác
   - Tap cung - highlight và hiển thị bottom sheet
   - Tap nút reset - trả về trạng thái zoom/pan mặc định

## Phụ Thuộc Giữa Các File

```
main.dart
├── core/theme/astro_theme.dart
└── features/profile/presentation/pages/profile_input_page.dart
    ├── intl (định dạng ngày)
    └── chart/presentation/pages/chart_display_page.dart
        ├── chart/presentation/pages/tuvi_chart_screen.dart
        │   ├── chart/presentation/widgets/house_card.dart
        │   │   └── chart/presentation/widgets/star_chip.dart
        │   └── core/theme/astro_theme.dart (colors, decorations)
        ├── astro_engine/star_engine.dart (BirthData, Chart)
        └── astro_engine/chart_builder.dart (generateChart)
```

## Astro Engine API

### Lớp BirthData
```dart
BirthData(
  name: String,
  birthDate: DateTime,
  birthTime: TimeOfDay,
  gender: String, // 'male' hoặc 'female'
  cuc: int,       // 2-6 (hướng/vùng)
)
```

### Lớp Chart
```dart
Chart {
  name: String,
  birthDate: DateTime,
  palaces: List<Palace?>, // 12 cung, mỗi cung chứa danh sách sao
}

Palace {
  index: int,
  name: String,
  stars: List<Star>, // Các sao trong cung
}

Star {
  name: String,
  type: String, // 'main', 'secondary', 'fate'
  degree: double,
  strength: double,
}
```

### Hàm generateChart()
```dart
Chart generateChart(BirthData data)
```

Hàm trả về lá số hoàn chỉnh với 40 sao được đặt vào 12 cung dựa trên dữ liệu khai sinh.

## Tham Chiếu Style

Tất cả màu và animation bám theo web app:

### Màu sắc
- Nền: `#0a0e27` (dark navy)
- Chính: `#d4af37` (gold)
- Phụ: `#3d1a5c` (cosmic purple)
- Glow: `#8b5cf6` (bright purple)
- Hành Thủy: `#06b6d4` (cyan)

### Animation
- Fade-in: 800ms, easeOut
- Scale: 0.95 → 1.0, 800ms
- Glow pulse: 1500ms, easeInOut, opacity 0.5 → 1.0

### Trang trí
- Glassmorphic cards: nền `Colors.white.withOpacity(0.05)`, viền vàng/tím
- Đổ bóng: `blurRadius: 8-12`, màu bóng theo ngũ hành
- Bo góc: 8-12dp cho đa số thành phần

## Lỗi Thường Gặp & Cách Xử Lý

### Lỗi: "BirthProfile imported from multiple sources"
**Cách xử lý:** Chỉ dùng một model BirthProfile trong `features/profile/domain/models/`, sau đó import thống nhất ở mọi nơi.

### Lỗi: "Chart generation is async but UI not updating"
**Cách xử lý:** Bọc phần sinh chart trong `setState()` hoặc dùng Riverpod `FutureProvider`.

### Lỗi: "Stars not showing in houses"
**Cách xử lý:** Kiểm tra engine đã gán sao đúng vào cung chưa. Đối chiếu output trong `chart_builder.dart`.

### Lỗi: "Theme colors don't match web"
**Cách xử lý:** So lại mã màu hex trong `astro_theme.dart` với design system của web app.

## Lộ Trình Chuyển Đổi

Khi tích hợp đầy đủ, luồng dữ liệu sẽ thành:

```
Provider Input (trạng thái form)
    ↓
    └→ chartProvider (tính toán engine)
        ↓
        └→ Chart display (UI layer tiêu thụ dữ liệu từ provider)
```

Cách này cho phép:
- Chia sẻ chart state giữa nhiều màn hình
- Cache offline với Hive
- Undo/redo thao tác
- Xuất hình ảnh/PDF

## Các Giai Đoạn Tiếp Theo

### Giai đoạn 4: Tích hợp Backend
- Kết nối Astroweb API (Cloudflare Workers)
- Thêm xác thực nếu cần
- Đồng bộ profile giữa mobile và web

### Giai đoạn 5: Tính năng Nâng cao
- Bộ tính Tương hợp
- Góc nhìn chu kỳ năm/tháng/ngày
- Trang chi tiết sao
- Chia sẻ và xuất lá số

### Giai đoạn 6: Hoàn thiện
- Tùy chỉnh theme
- Accessibility (dark mode, cỡ chữ)
- Quốc tế hóa (nếu cần)
- Tối ưu hiệu năng

---

**Cập nhật lần cuối:** 18/03/2025
