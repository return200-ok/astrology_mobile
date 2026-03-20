# Astroweb Mobile - Hướng Dẫn Thiết Lập

## Bắt Đầu Nhanh

```bash
cd /Users/cao.lv/gitlab.citigo.com.vn/local/astroweb_mobile

# Cài dependencies
flutter pub get

# Chạy trên thiết bị/emulator đã kết nối
flutter run

# Chạy trên thiết bị cụ thể
flutter run -d iPhone
flutter run -d android
```

## Cấu Trúc Thư Mục

```
astroweb_mobile/
├── lib/
│   ├── features/          # Các module theo tính năng
│   │   ├── profile/       # Nhập hồ sơ khai sinh
│   │   └── chart/         # Hiển thị lá số tử vi
│   ├── astro_engine/      # Engine tính toán Dart thuần
│   ├── core/              # Theme, widget, tiện ích dùng chung
│   └── main.dart          # Điểm vào ứng dụng
├── test/                  # Unit test & widget test
├── pubspec.yaml           # Dependencies
├── analysis_options.yaml  # Quy tắc lint
└── README.md
```

## Tính Năng Chính

✅ **Astro Engine**: 14 chính tinh + 12 phụ tinh + 12 cung  
✅ **Theme Tối**: Giao diện tử vi đẹp mắt  
✅ **Lá Số Tương Tác**: Zoom, pan, tap để xem chi tiết  
✅ **Lịch Âm**: Tự động chuyển đổi ngày  
✅ **State Management**: Riverpod cho trạng thái phản ứng  
✅ **Lưu Trữ Cục Bộ**: Hive cho dữ liệu offline  

## Build

```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release
flutter build appbundle --release
```

## Kiểm Thử

```bash
flutter test
flutter test --coverage
```

## Mẹo Phát Triển

- Dùng `flutter analyze` để kiểm tra chất lượng mã
- Chạy `flutter pub upgrade` để cập nhật dependencies
- Dùng `flutter doctor` để xác nhận môi trường
- Bật hot reload: nhấn `r` trong terminal khi app đang chạy

## Repo Liên Quan

- **Web App**: [astroweb-99-cyber-mystic-astrology](../astroweb-99-cyber-mystic-astrology)
- **Flutter Tuvi App**: [a_tuvi](../a_tuvi)
