# Astroweb Mobile - Flutter

Ứng dụng tử vi di động full-stack được xây dựng bằng Flutter. Đây là ứng dụng đồng hành với nền tảng web Astroweb.

## Tính năng

- 📱 Cross-platform: iOS & Android
- ✨ Giao diện tử vi tông tối đẹp mắt
- 📊 Lá số 12 cung với UI tương tác
- 🌙 Tích hợp lịch âm
- 💾 Lưu trữ dữ liệu cục bộ
- 🔄 Tích hợp API với backend Astroweb

## Công nghệ sử dụng

- **Framework**: Flutter 3.x với Dart null safety
- **State Management**: Riverpod
- **Local Storage**: Hive
- **API Client**: HTTP + Retrofit
- **UI**: Material Design 3 + hiệu ứng tùy chỉnh

## Yêu cầu trước khi chạy

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.x trở lên)
- Xcode (để phát triển iOS)
- Android Studio (để phát triển Android)
- Dart SDK (đi kèm Flutter)

## Cài đặt

1. Clone repository:
```bash
git clone <repo-url>
cd astroweb_mobile
```

2. Cài dependencies:
```bash
flutter pub get
```

3. Chạy ứng dụng:
```bash
# Chế độ debug
flutter run

# Riêng iOS
flutter run -d iPhone

# Riêng Android
flutter run -d android
```

## Phát triển

### Cấu trúc dự án

```
lib/
├── features/          # Các module tính năng (chart, profile, ...)
├── astro_engine/      # Engine tính toán tử vi viết bằng Dart thuần
├── core/              # Tiện ích lõi, theme, widgets
└── main.dart          # Điểm vào của ứng dụng
```

### Các lệnh thường dùng

| Lệnh | Mục đích |
|---------|---------|
| `flutter pub get` | Cài dependencies |
| `flutter run` | Chạy ở chế độ debug |
| `flutter build apk` | Build APK cho Android |
| `flutter build ios` | Build ứng dụng iOS |
| `flutter test` | Chạy test |
| `flutter analyze` | Phân tích mã nguồn |

## Engine tử vi

Ứng dụng bao gồm một engine tử vi viết bằng Dart thuần (`lib/astro_engine/`) để tính:

- 14 chính tinh (Tử Vi, Thiên Cơ, Thái Dương, ...)
- 12 phụ tinh (Văn Xương, Hóa Tinh, ...)
- Chuyển đổi ngày âm lịch
- 12 cung tử vi

**Lưu ý**: Không cần thư viện thiên văn bên ngoài, toàn bộ phép tính mang tính xác định (deterministic).

## Tích hợp API

Kết nối với backend Astroweb:

```dart
// lib/data/services/astroweb_api.dart
class AstrowebApiClient {
  Future<BirthChart> generateChart(BirthProfile profile) async {
    // Gọi API đến backend
  }
}
```

## Build bản production

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
# Sau đó mở bằng Xcode để ký và phát hành
```

## Kiểm thử

```bash
# Chạy unit test
flutter test

# Chạy kèm coverage
flutter test --coverage
```

## Đóng góp

1. Tạo nhánh tính năng: `git checkout -b feature/your-feature`
2. Commit thay đổi: `git commit -m "feat: add feature"`
3. Push lên repo: `git push origin feature/your-feature`
4. Tạo pull request

## Giấy phép

MIT - Xem [LICENSE](LICENSE) để biết chi tiết

## Hỗ trợ

Nếu có lỗi hoặc thắc mắc:
- Tạo issue trên GitHub
- Xem [Astroweb Web](../astroweb-99-cyber-mystic-astrology) để biết chi tiết backend
# astrology_mobile
