# Astroweb Mobile

## Tổng quan

Đây là **phiên bản mobile** của Astroweb, ứng dụng tử vi full-stack được xây dựng bằng **Flutter**.

- **Web App**: [astroweb-99-cyber-mystic-astrology](../astroweb-99-cyber-mystic-astrology) (React + Cloudflare Workers)
- **Mobile App**: [astroweb_mobile](./README.md) (Flutter - iOS/Android)

## Liên kết nhanh

- [Hướng dẫn setup](SETUP.md)
- [Tài liệu Flutter](https://flutter.dev/docs)
- [Astrology Engine](lib/astro_engine/)

## Bắt đầu nhanh

```bash
cd /Users/cao.lv/gitlab.citigo.com.vn/local/astroweb_mobile

# Cài dependencies
flutter pub get

# Chạy ứng dụng
flutter run
```

## Tính năng

- ✨ Lá số tử vi 12 cung
- 🌙 Tích hợp lịch âm
- 📱 Cross-platform (iOS + Android)
- 🎨 Giao diện tử vi tông tối
- 💾 Lưu trữ dữ liệu offline
- 🔄 Đồng bộ với backend web

## Kiến trúc

```
Ứng dụng Flutter
├── Tầng UI (Material 3)
├── Quản lý trạng thái (Riverpod)
├── Tầng dữ liệu (Hive + HTTP)
└── Astro Engine (Dart thuần)
```

## Trạng thái phát triển

- 🔧 Setup & scaffolding (đang thực hiện)
- ⏳ Triển khai tính năng (sắp tới)
- ⏳ Kiểm thử & tối ưu (sắp tới)

## Liên quan

- **Dự án Flutter khác**: [a_tuvi](../a_tuvi) - ứng dụng tử vi
