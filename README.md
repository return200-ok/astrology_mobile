# Mystic Cosmos — Flutter

Ứng dụng tâm lý, tâm linh và huyền học đa nền tảng xây dựng bằng Flutter. Tích hợp Tử Vi, chiêm tinh Tây phương, Kinh Dịch, trắc nghiệm nhân cách và các tính năng tâm linh khác.

---

## Mục lục

1. [Cài đặt & chạy](#cài-đặt--chạy)
2. [Cấu trúc dự án](#cấu-trúc-dự-án)
3. [Chỉnh sửa nội dung diễn giải](#chỉnh-sửa-nội-dung-diễn-giải) ← **quan trọng nhất**
4. [Đa ngôn ngữ (i18n)](#đa-ngôn-ngữ-i18n)
5. [Engine Tử Vi](#engine-tử-vi)
6. [Build production](#build-production)

---

## Cài đặt & chạy

```bash
flutter pub get
flutter run          # debug
flutter run -d iPhone
flutter run -d android
```

Yêu cầu: Flutter SDK 3.x, Xcode (iOS), Android Studio (Android).

---

## Cấu trúc dự án

```
lib/
├── features/
│   ├── oracle/          # Tiên Tri — đọc cung hoàng đạo
│   ├── alignment/       # Tương Hợp — tương hợp cung hoàng đạo
│   ├── iching/          # Kinh Dịch — xin quẻ
│   ├── soul_revelation/ # KHÁM PHÁ TÍNH CÁCH — trắc nghiệm BFI-44
│   ├── imperial/        # Tử Vi — lá số tử vi
│   └── cosmic_void/     # MANIFEST — thì thầm cộng đồng
├── core/
│   ├── i18n/            # Bản địa hóa bổ sung (zodiac_localization.dart)
│   └── theme/           # Giao diện, màu sắc
├── astro_engine/        # Engine tính toán tử vi thuần Dart
├── l10n/                # File ngôn ngữ (.arb + generated .dart)
└── main.dart
```

---

## Chỉnh sửa nội dung diễn giải

> Đây là phần quan trọng nhất của ứng dụng. Mỗi tính năng có file nội dung riêng biệt, tách hoàn toàn khỏi code giao diện.

---

### 1. Tiên Tri (Oracle) — Lời giải đáp 12 cung hoàng đạo

Mỗi cung có 7 trường nội dung: chỉ dẫn thiên cầu, bản chất, dòng chảy tinh thần, thu hút, lan toả, đường dharma, nhu cầu thiêng liêng.

#### Nội dung tiếng Anh

**File:** `lib/features/oracle/domain/models/oracle_sign.dart`

```dart
OracleSign(
  id: 'aries',
  name: 'ARIES',
  guidance: 'CELESTIAL GUIDANCE: Your inner flame is rising...',  // ← lời chỉ dẫn
  essence: ['Born initiator', 'Radiant energy', ...],            // ← bản chất (4 mục)
  spiritualFlow: ['Direct and focused', ...],                    // ← dòng chảy tinh thần (3 mục)
  drawnTo: ['Dynamic spirits', ...],                             // ← thu hút về (3 mục)
  radiatesTo: ['People craving momentum', ...],                  // ← lan toả đến (3 mục)
  dharmaPath: ['Pioneer', 'Protector', ...],                     // ← đường dharma (4 mục)
  sacredNeeds: ['Challenge', 'Autonomy', 'Action'],              // ← nhu cầu thiêng liêng (3 mục)
),
```

Sửa trực tiếp các chuỗi trong file này để thay đổi nội dung tiếng Anh cho cả 12 cung.

#### Nội dung tiếng Việt

**File:** `lib/core/i18n/zodiac_localization.dart`

File này chứa 7 bảng `Map<String, ...>` tương ứng với 7 trường nội dung, mỗi bảng có 12 entry (một per cung). Ví dụ:

```dart
static const Map<String, String> _vietnameseGuidance = {
  'aries': 'CHỈ DẪN THIÊN CẦU: Ngọn lửa bên trong bạn đang bừng cháy...',
  'taurus': 'CHỈ DẪN THIÊN CẦU: Bám rễ vào sự tĩnh lặng...',
  // ... 10 cung còn lại
};

static const Map<String, List<String>> _vietnameseEssence = {
  'aries': ['Người khởi xướng bẩm sinh', 'Năng lượng rực rỡ', ...],
  // ...
};
```

Sửa các giá trị trong map để thay đổi nội dung tiếng Việt. Các key (`'aries'`, `'taurus'`, ...) **không được thay đổi**.

---

### 2. Tương Hợp (Alignment) — Thông điệp kết quả

#### Thuật toán điểm số

**File:** `lib/features/alignment/presentation/pages/alignment_page.dart`

Điểm tương hợp được tính dựa trên ngũ hành tương sinh/tương khắc:

| Điều kiện | Điểm |
|-----------|------|
| Cùng ngũ hành | 90% |
| Hỏa–Phong / Thủy–Thổ (tương sinh) | 84% |
| Khác nguyên tố | 68–79% |
| Đặc biệt (Song Tử–Xử Nữ) | 99% |

Để thay đổi logic tính điểm, tìm hàm `_calcScore()` trong file trên.

#### Thông điệp diễn giải (4 mức)

**File:** `lib/l10n/app_en.arb` (tiếng Anh) và `lib/l10n/app_vi.arb` (tiếng Việt)

```json
"alignmentMessageOptimized": "OPTIMIZED ALIGNMENT: Your spiritual paths complement each other.",
"alignmentMessageHarmonic":  "HARMONIC ALIGNMENT: Your resonance is strong and naturally supportive.",
"alignmentMessageGrowth":    "GROWTH ALIGNMENT: This bond expands through patience and dialogue.",
"alignmentMessageChallenging": "CHALLENGING ALIGNMENT: Contrast is high; empathy unlocks balance."
```

Mỗi mức được kích hoạt theo ngưỡng điểm:
- **≥ 95%** → `alignmentMessageOptimized`
- **85–94%** → `alignmentMessageHarmonic`
- **75–84%** → `alignmentMessageGrowth`
- **< 75%** → `alignmentMessageChallenging`

Sau khi sửa `.arb`, chạy lại `flutter gen-l10n` (hoặc `flutter pub get`) để tái tạo file dart.

---

### 3. Kinh Dịch (I Ching) — Lời giải quẻ

**File:** `lib/l10n/app_en.arb` và `lib/l10n/app_vi.arb`

Hiện có 3 bộ lời giải, được chọn dựa trên từ khoá câu hỏi của người dùng:

| Bộ | Từ khoá kích hoạt | Các key |
|----|-------------------|---------|
| Tình cảm | "love", "tình", "relationship" | `ichingQuoteLove`, `ichingAnalysisLove`, `ichingGuidanceLove1/2/3` |
| Công việc | "work", "career", "job" | `ichingQuoteWork`, `ichingAnalysisWork`, `ichingGuidanceWork1/2/3` |
| Mặc định | (tất cả các câu hỏi khác) | `ichingQuoteDefault`, `ichingAnalysisDefault`, `ichingGuidanceDefault1/2/3` |

Ví dụ file `app_vi.arb`:

```json
"ichingQuoteLove": "Trời Đất trong trạng thái chuyển hoá.",
"ichingAnalysisLove": "Sự chuyển tiếp từ Thuần Kiền sang Thuần Khôn gợi lên một quá trình đang vận hành...",
"ichingGuidanceLove1": "Giữ vững chính trực trong mọi hành động",
"ichingGuidanceLove2": "Chờ đợi sự kết thúc tự nhiên của sự kiện",
"ichingGuidanceLove3": "Chỉ hành động khi la bàn nội tâm đã ổn định"
```

Logic chọn bộ lời giải nằm trong:
**File:** `lib/features/iching/presentation/pages/iching_result_page.dart` — hàm `_pickReading(String query)`

Để thêm bộ lời giải mới (ví dụ cho chủ đề "sức khoẻ"), thêm từ khoá vào điều kiện trong hàm đó và thêm các key mới vào cả 2 file `.arb`.

---

### 4. KHÁM PHÁ TÍNH CÁCH (Soul Revelation) — Trắc nghiệm & kết quả

#### 44 câu hỏi BFI

**File:** `lib/features/soul_revelation/domain/models/soul_revelation_models.dart`

Mỗi câu hỏi có cấu trúc:

```dart
BfiQuestion(
  en: 'Is talkative',           // ← câu hỏi tiếng Anh
  vi: 'Hay nói chuyện',         // ← câu hỏi tiếng Việt
  trait: BfiTrait.extraversion, // ← nhóm tính cách (5 nhóm)
  reversed: false,              // ← true nếu câu hỏi tính ngược điểm
),
```

Thang đo trả lời (5 mức) cũng nằm trong file này — có thể thay đổi nhãn hiển thị mà không ảnh hưởng điểm số.

#### Diễn giải kết quả BFI (3 mức × 5 nhóm = 15 đoạn văn)

**File:** `lib/features/soul_revelation/presentation/pages/soul_revelation_result_page.dart`

Tìm hàm `_traitDescription(BfiTrait trait, double score, String lang)`. Mỗi nhóm tính cách có 3 cấp độ (thấp/trung/cao) với mô tả riêng bằng cả hai ngôn ngữ:

```dart
BfiTrait.extraversion => score >= 67
  ? (lang == 'vi' ? 'Bạn là người hướng ngoại rõ rệt...' : 'You are highly extraverted...')
  : score >= 34
    ? (lang == 'vi' ? 'Bạn cân bằng giữa hướng nội và hướng ngoại...' : 'You balance introversion...')
    : (lang == 'vi' ? 'Bạn có xu hướng hướng nội...' : 'You tend toward introversion...'),
```

Đây là nơi để tinh chỉnh ngôn ngữ tâm lý học và chiều sâu diễn giải cho từng nhóm tính cách.

---

### 5. Tử Vi (Imperial) — Lá số & cung

#### Tên cung (12 cung tử vi)

**File:** `lib/l10n/app_en.arb` / `app_vi.arb` — các key `chartHouseMenh`, `chartHousePhuMau`, ..., `chartHouseHuynhDe`

#### Dữ liệu sao trong lá số mẫu

**File:** `lib/features/imperial/presentation/pages/imperial_result_page.dart`

Phần đầu file có danh sách `_kPalaces` — dữ liệu ví dụ minh hoạ giao diện bảng lá số. Nội dung thực tế được tính bởi engine.

#### Engine tính toán

**File:** `lib/astro_engine/` — toàn bộ phép tính tử vi (an sao, xác định cung, chuyển âm lịch). Sửa file này ảnh hưởng đến kết quả tính toán thực, không phải nội dung diễn giải.

---

### Tổng hợp: File nào cần sửa khi nào

| Muốn thay đổi | File cần sửa |
|---------------|-------------|
| Lời chỉ dẫn / diễn giải cung hoàng đạo (EN) | `lib/features/oracle/domain/models/oracle_sign.dart` |
| Lời chỉ dẫn / diễn giải cung hoàng đạo (VI) | `lib/core/i18n/zodiac_localization.dart` |
| Thông điệp kết quả tương hợp | `lib/l10n/app_en.arb` + `app_vi.arb` (key `alignmentMessage*`) |
| Lời giải quẻ Kinh Dịch | `lib/l10n/app_en.arb` + `app_vi.arb` (key `iching*`) |
| Câu hỏi trắc nghiệm BFI-44 | `lib/features/soul_revelation/domain/models/soul_revelation_models.dart` |
| Diễn giải kết quả nhân cách | `lib/features/soul_revelation/presentation/pages/soul_revelation_result_page.dart` |
| Nhãn UI (nút, tiêu đề, thông báo) | `lib/l10n/app_en.arb` + `app_vi.arb` |
| Tên cung tử vi | `lib/l10n/app_en.arb` + `app_vi.arb` (key `chartHouse*`) |

---

## Đa ngôn ngữ (i18n)

Ứng dụng hỗ trợ Tiếng Anh và Tiếng Việt. Có 2 hệ thống song song:

### Hệ thống ARB (nhãn UI & nội dung ngắn)

```
lib/l10n/
├── app_en.arb          ← source of truth cho tiếng Anh
├── app_vi.arb          ← source of truth cho tiếng Việt
├── app_localizations.dart         ← abstract class (generated)
├── app_localizations_en.dart      ← implementation EN (generated)
└── app_localizations_vi.dart      ← implementation VI (generated)
```

**Quy trình sửa:**
1. Sửa giá trị trong `app_en.arb` và/hoặc `app_vi.arb`
2. Sửa tương ứng trong `app_localizations_en.dart` / `app_localizations_vi.dart`
3. Nếu thêm key mới: thêm abstract getter vào `app_localizations.dart`

> Các file `app_localizations*.dart` hiện được duy trì thủ công (không dùng `flutter gen-l10n`). Sửa cả ARB lẫn dart để giữ đồng bộ.

### Hệ thống ZodiacLocalization (nội dung dài — Oracle)

**File:** `lib/core/i18n/zodiac_localization.dart`

Dùng cho nội dung Oracle vì mỗi cung có nhiều đoạn văn dài. Mỗi ngôn ngữ là một `Map` riêng; tiếng Anh là fallback nếu bản dịch chưa có.

---

## Engine Tử Vi

**Thư mục:** `lib/astro_engine/`

Engine thuần Dart, không phụ thuộc thư viện thiên văn ngoài. Tính toán:
- 14 chính tinh (Tử Vi, Thiên Cơ, Thái Dương, ...)
- 12 phụ tinh (Văn Xương, Hóa Tinh, ...)
- Chuyển đổi dương lịch → âm lịch (dùng package `lunar`)
- An sao theo giờ sinh, năm sinh

---

## Build production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# iOS (sau đó mở Xcode để ký)
flutter build ios --release
```

---

## Các lệnh thường dùng

| Lệnh | Mục đích |
|------|---------|
| `flutter pub get` | Cài dependencies |
| `flutter run` | Chạy debug |
| `flutter analyze` | Kiểm tra lỗi tĩnh |
| `flutter test` | Chạy unit test |
| `flutter build apk --release` | Build Android |
| `flutter build ios --release` | Build iOS |
