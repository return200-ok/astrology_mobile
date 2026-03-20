# Astroweb Mobile - Ứng Dụng Flutter

Ứng dụng đồng hành mobile-first cho web app tử vi Astroweb, được xây dựng bằng Flutter cho iOS và Android.

## Tính Năng

✨ **Lá Số Tử Vi Tương Tác**
- Hiển thị lá số Tử Vi 12 cung
- Tương tác zoom và pan (tỉ lệ 0.8x đến 2.5x)
- Chạm để chọn cung và xem thông tin sao chi tiết
- UI glassmorphism với hiệu ứng glow có animation
- Mã màu theo ngũ hành (Mộc, Hỏa, Thổ, Kim, Thủy)

🌙 **Nhập Hồ Sơ Khai Sinh**
- Form Material 3 với bộ chọn ngày và giờ
- Chọn giới tính
- Chọn Cục (hướng) từ 2-6
- Kiểm tra hợp lệ dữ liệu form

📊 **Hiển Thị Lá Số**
- 12 cung bố trí theo lưới 4×4
- Star chip với animation phát sáng theo nhịp
- House card với viền highlight
- Bottom sheet modal cho thông tin cung chi tiết

🎨 **Hệ Thống Thiết Kế**
- Theme tử vi tông tối (navy, cosmic purple, gold)
- Hiệu ứng glassmorphism (card bán trong suốt, viền phát sáng)
- Animation mượt (fade-in, scale, glow pulse)
- Màu sắc khớp chính xác với web app (Astroweb)

## Bắt Đầu

### Yêu Cầu Trước Khi Chạy

- Flutter 3.x (hoặc mới hơn)
- Dart 3.x
- iOS: Xcode 14+ (để build iOS)
- Android: Android Studio 4.1+ (để build Android)

### Cài Đặt

1. **Đi vào repo:**
   ```bash
   cd /Users/cao.lv/gitlab.citigo.com.vn/local/astroweb_mobile
   ```

2. **Cài dependencies:**
   ```bash
   flutter pub get
   ```

3. **Chạy ứng dụng:**
   ```bash
   # iOS (yêu cầu macOS)
   flutter run -d iphone

   # Android
   flutter run -d android

   # Web (phát triển)
   flutter run -d chrome
   ```

## Cấu Trúc Dự Án

```
lib/
├── main.dart                          # Điểm vào ứng dụng
├── astro_engine/                      # Astro engine viết bằng Dart thuần
│   ├── star_engine.dart              # Tính toán lõi (BirthData, Chart)
│   ├── main_star_rules.dart          # Quy tắc định vị 14 chính tinh
│   ├── secondary_star_rules.dart     # Sao theo giờ/năm, hiệu ứng phụ
│   └── chart_builder.dart            # Thuật toán sinh lá số
├── core/
│   └── theme/
│       └── astro_theme.dart          # Theme tối, màu sắc, trang trí
└── features/
    ├── profile/
    │   ├── domain/models/
    │   │   └── birth_profile.dart    # Data class BirthProfile
    │   └── presentation/pages/
    │       └── profile_input_page.dart # Form nhập liệu với picker
    └── chart/
        ├── domain/models/
        │   ├── birth_profile.dart    # (bản sao từ profile/)
        │   └── birth_chart.dart      # Dữ liệu kết quả lá số
        ├── data/providers/
        │   └── chart_provider.dart   # State management bằng Riverpod
        └── presentation/
            ├── pages/
            │   ├── chart_display_page.dart  # Điều hướng lá số
            │   └── tuvi_chart_screen.dart   # UI lá số chính
            └── widgets/
                ├── star_chip.dart       # Badge sao có animation
                └── house_card.dart      # Khung cung chứa sao
```

## Kiến Trúc

**Cấu trúc theo feature:**
- `profile/` - Nhập dữ liệu người dùng (tên, ngày/giờ sinh, giới tính)
- `chart/` - Tính toán và hiển thị lá số

**Tách lớp rõ ràng:**
- `domain/models/` - Data classes
- `data/providers/` - State management (Riverpod)
- `presentation/pages/` - Màn hình đầy đủ
- `presentation/widgets/` - UI component tái sử dụng

**Engine:**
- `astro_engine` Dart thuần, tách biệt khỏi UI
- Tính toán modulo-12 deterministic
- Tổng 40 sao: 14 chính + 12 phụ + 12 theo vòng vận

**State Management:**
- Riverpod cho trạng thái phản ứng
- ProfileProvider: dữ liệu hồ sơ sinh
- ChartProvider: sinh lá số (async)

## Màu Theme

| Tên | Hex | Mục đích |
|------|-----|-----|
| darkBg | #0a0e27 | Nền |
| cosmicPurple | #3d1a5c | Điểm nhấn phụ |
| accentGold | #d4af37 | Điểm nhấn chính |
| glowPurple | #8b5cf6 | Glow/viền |
| glowCyan | #06b6d4 | Màu ngũ hành |

## Animations

- **Fade-in:** Hiển thị lá số khi tải (800ms, easeOut)
- **Scale:** Vào trang lá số (scale 0.95 → 1.0)
- **Glow pulse:** Star chip phát sáng liên tục (1500ms, easeInOut)
- **Selection highlight:** Viền/glow house card khi chạm (300ms)

## Dependencies

```yaml
flutter_riverpod: ^2.4.0      # State management
hive: ^2.2.3                  # Lưu trữ cục bộ
hive_flutter: ^1.1.0          # Tích hợp Hive với Flutter
http: ^1.1.0                  # HTTP client
intl: ^0.19.0                 # Định dạng ngày tháng
```

## Phát Triển

### Chạy Test

```bash
flutter test
```

### Build

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

### Sinh Mã (nếu dùng freezed, json_serializable, ...)

```bash
flutter pub run build_runner build
```

## Trạng Thái Dự Án

✅ **Đã hoàn thành:**
- Astro engine (định vị sao, hệ 12 cung)
- Hệ thống theme (màu sắc, glassmorphism, animation)
- Trang nhập hồ sơ (Material 3, picker ngày/giờ)
- Màn hình lá số tương tác (TuViChartScreen)
- Star chip với animation phát sáng
- House card theo màu ngũ hành
- Điều hướng lá số (form → hiển thị)

⏳ **Đang thực hiện:**
- Tích hợp sinh lá số (engine → luồng dữ liệu UI)
- Riverpod state management (nối submit form)
- Tích hợp API (kết nối backend web)

⏭️ **Kế hoạch:**
- Phân tích tương hợp giữa hai hồ sơ
- Góc nhìn theo chu kỳ năm/tháng/ngày
- Tooltip chi tiết sao
- Tùy chỉnh theme (sáng/tối)
- Chế độ offline với Hive
- Chia sẻ lá số dạng ảnh

## Dự Án Liên Quan

- **astroweb-99-cyber-mystic-astrology** (React Web) - Bản web với backend Cloudflare Workers
- **a_tuvi** (Flutter Legacy) - Ứng dụng Tử Vi gốc (tách biệt mobile/web)

## Tham Chiếu Thiết Kế

Ứng dụng mobile bám sát hoàn toàn design system của web app:
- Cùng bảng màu và gradient tông tối
- Viền và bóng theo phong cách glassmorphism
- Thời lượng và đường cong animation tương ứng
- Component Material 3 (bản web tương đương shadcn/ui)

## Đóng Góp

Hoan nghênh pull request. Vui lòng đảm bảo:
1. Mã tuân thủ guideline Flutter/Dart
2. Test pass (`flutter test`)
3. Không có thay đổi phá vỡ tương thích nếu chưa thảo luận

## Giấy Phép

[Thông tin giấy phép tại đây]

## Liên Hệ

Nếu có lỗi, câu hỏi hoặc đề xuất tính năng, vui lòng tạo issue trong repository GitLab.

---

**Cập nhật lần cuối:** 18/03/2025  
**Phiên bản:** 0.1.0 (pre-release)
