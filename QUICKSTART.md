# Hướng Dẫn Bắt Đầu Nhanh - astroweb_mobile

Chạy ứng dụng Tử Vi Flutter trong 5 phút.

## Yêu cầu trước khi bắt đầu

Xác nhận bạn đã cài các thành phần sau:

```bash
# Kiểm tra phiên bản Flutter (3.0+)
flutter --version

# Kiểm tra phiên bản Dart (3.0+)
dart --version

# Kiểm tra khả năng build
flutter doctor
```

**Kết quả mong đợi:** Không có lỗi, hoặc chỉ thiếu các thành phần tùy chọn.

## Thiết lập (30 giây)

```bash
# 1. Di chuyển vào project
cd /Users/cao.lv/gitlab.citigo.com.vn/local/astroweb_mobile

# 2. Cài dependencies
flutter pub get

# 3. Xong! Sẵn sàng chạy ứng dụng
```

## Chạy ứng dụng

### iOS (chỉ macOS)
```bash
flutter run -d iphone
# hoặc
flutter run --device-id=D86DC16A-65D9-4A6A-A9B6-02B4B5730B8E
```

### Android
```bash
flutter run -d android
# hoặc kết nối thiết bị thật rồi chạy
```

### Web (để test, phát triển)
```bash
flutter run -d chrome
```

## Khởi chạy lần đầu

Khi mở ứng dụng, bạn sẽ thấy:

1. Màn hình **"Nhập Thông Tin Sinh"** (Input Birth Info)
2. Điền thông tin:
   - Tên: ví dụ `"Lý Văn Cao"`
   - Ngày sinh: chạm vào ô ngày
   - Giờ sinh: chạm vào ô giờ
   - Giới tính: chọn Nam/Nữ
   - Cục: chọn từ 2-6
3. Chạm **"Xem Bảng Lá Số"** (View Chart)
4. Xem lá số tương tác gồm 12 cung

## Tương tác với lá số

| Thao tác | Hiệu ứng |
|--------|--------|
| **Pinch** | Phóng to/thu nhỏ (0.8x đến 2.5x) |
| **Drag** | Kéo để di chuyển lá số |
| **Tap House** | Làm nổi bật và hiển thị chi tiết cung |
| **Tap Reset Icon** | Đưa mức zoom về 1.0x |
| **Bottom Sheet Modal** | Xem toàn bộ sao trong cung đang chọn |

## Các file quan trọng

```
lib/
├── main.dart                          # Khởi động app, cấu hình theme
├── features/profile/.../profile_input_page.dart  # Form nhập liệu
├── features/chart/.../tuvi_chart_screen.dart     # UI lá số
├── astro_engine/chart_builder.dart    # Tính toán sao
└── core/theme/astro_theme.dart        # Màu sắc và style
```

## Tác vụ thường gặp

### Xem mô hình dữ liệu lá số
```dart
// Trong tuvi_chart_screen.dart, kiểm tra _mockPalaceStars
final Map<int, List<String>> _mockPalaceStars = {
  0: ['Tử Vệ', 'Thiên Cơ'],  // Cung Mệnh
  // ...
};
```

### Đổi màu giao diện
Sửa file `lib/core/theme/astro_theme.dart`:
```dart
static const Color accentGold = Color(0xFFd4af37);  // Sửa giá trị này
```

### Thêm cung mới
Sửa file `lib/features/chart/presentation/pages/tuvi_chart_screen.dart`:
```dart
static const Map<int, int> gridIndexMap = {
  0: 0,   // Mệnh
  // Thêm mapping tại đây
};
```

### Chạy test
```bash
flutter test
```

### Build bản phát hành

**iOS:**
```bash
flutter build ios --release
# Làm theo hướng dẫn submit iOS App Store
```

**Android:**
```bash
flutter build appbundle --release
# Upload lên Google Play Store
```

**Web:**
```bash
flutter build web --release
# Kết quả nằm trong build/web/
```

## Xử lý sự cố

### App không khởi động
```bash
# Clean build
flutter clean
flutter pub get
flutter run
```

### "No devices available"
```bash
# Liệt kê thiết bị khả dụng
flutter devices

# Mở emulator/simulator trước rồi chạy lại
flutter run -d <device-id>
```

### Màu theme hiển thị không đúng
- Kiểm tra giá trị màu trong `astro_theme.dart`
- Xác nhận Material3 đã bật trong `main.dart`

### Lá số không hiển thị
- Kiểm tra dữ liệu `_mockPalaceStars` trong `chart_display_page.dart`
- Xác nhận `TuViChartScreen` nhận được map `palaceStars` hợp lệ

### Zoom/pan không hoạt động
- Kiểm tra `InteractiveViewer` trong `tuvi_chart_screen.dart`
- Kiểm tra gesture detector không chặn tương tác

## Bước tiếp theo

1. **Tích hợp engine thật:** Cập nhật `ChartDisplayPage` để gọi `generateChart()`
2. **Bổ sung state management:** Dùng Riverpod providers trong `chart_provider.dart`
3. **Kết nối backend:** Gọi các endpoint API của Astroweb
4. **Tùy chỉnh theme:** Sửa màu trong `astro_theme.dart`

## Tổng quan cấu trúc dự án

```
astroweb_mobile/
├── pubspec.yaml           # Dependencies (riverpod, hive, http, intl)
├── README.md              # Tổng quan dự án
├── SETUP.md              # Hướng dẫn setup chi tiết
├── IMPLEMENTATION.md     # Tính năng & trạng thái
├── INTEGRATION.md        # Cách kết nối các phần
├── ARCHITECTURE.md       # Thiết kế hệ thống
├── lib/
│   ├── main.dart        # Entry point (trang Profile)
│   ├── astro_engine/    # Tính toán sao (Dart thuần)
│   ├── core/theme/      # Theme tối & màu sắc
│   └── features/
│       ├── profile/     # Form nhập thông tin
│       └── chart/       # Hiển thị lá số
└── test/                # Unit tests (TODO)
```

## Tài liệu

- **IMPLEMENTATION.md** - Checklist tính năng & trạng thái hiện tại
- **INTEGRATION.md** - Cách kết nối form → engine → chart
- **ARCHITECTURE.md** - Thiết kế hệ thống & luồng dữ liệu
- **SETUP.md** - Hướng dẫn môi trường phát triển chi tiết
- **README.md** - Tổng quan dự án

## Thông tin môi trường

**Đã kiểm thử trên:**
- Flutter 3.13.0+
- Dart 3.1.0+
- macOS (phát triển iOS)
- Android Studio (phát triển Android)

**Nền tảng mục tiêu:**
- iOS 12.0+
- Android 21.0+ (Android 5.0+)

## Hỗ trợ & sự cố

- 📖 Xem **INTEGRATION.md** để kết nối các thành phần
- 🏗️ Xem **ARCHITECTURE.md** để nắm tổng quan hệ thống
- 🐛 Tài liệu Flutter: https://flutter.dev/docs

## Mẹo

1. **Hot reload** - Nhấn `r` trong terminal để tải lại thay đổi không cần restart
2. **Hot restart** - Nhấn `R` để restart toàn bộ (khi hot reload không đủ)
3. **Dùng DevTools** - `flutter pub global activate devtools` rồi chạy `devtools`
4. **Kiểm tra widget** - Dùng Flutter Inspector để debug layout UI

---

**Checklist nhanh:**
- [ ] Đã cài Flutter 3.x
- [ ] Đã cài Xcode/Android Studio
- [ ] Đã chạy `flutter pub get`
- [ ] Đã mở iOS simulator/Android emulator
- [ ] Đã chạy `flutter run`
- [ ] Đã điền form và xem lá số
- [ ] Đã test tương tác zoom/pan

**Thời gian:** ~5 phút setup + 2 phút chạy lần đầu = 7 phút tổng

**Cập nhật gần nhất:** 18/03/2025
