import 'package:lunar/lunar.dart';

typedef Wuxing = String;

class TuviStar {
  final String name;
  final String type;

  TuviStar({required this.name, required this.type});
}

class TuviPalace {
  final int id;
  final String name;
  final List<TuviStar> stars;
  final String wuxing;
  final bool isMenh;
  final bool isThan;

  TuviPalace({
    required this.id,
    required this.name,
    required this.stars,
    required this.wuxing,
    required this.isMenh,
    required this.isThan,
  });
}

class TuviChart {
  final String ownerName;
  final String birthDate;
  final String lunarDate;
  final String menhElement;
  final String cucElement;
  final List<TuviPalace> palaces;

  TuviChart({
    required this.ownerName,
    required this.birthDate,
    required this.lunarDate,
    required this.menhElement,
    required this.cucElement,
    required this.palaces,
  });
}

const List<String> PALACE_ORDER_VN = [
  'Mệnh', 'Phụ Mẫu', 'Phúc Đức', 'Điền Trạch', 'Quan Lộc', 'Nô Bộc',
  'Thiên Di', 'Tật Ách', 'Tài Bạch', 'Tử Tức', 'Phu Thê', 'Huynh Đệ'
];

const List<String> TUVI_PALACE_WUXING = [
  'Thủy', 'Thổ', 'Mộc', 'Mộc', 'Thổ', 'Hỏa', 'Hỏa', 'Thổ', 'Kim', 'Kim', 'Thổ', 'Thủy'
];

TuviChart calculateTuviChart(String name, DateTime date, int hourIndex) {
  final solar = Solar.fromYmdHms(date.year, date.month, date.day, date.hour, date.minute, date.second);
  final lunar = solar.getLunar();

  // Calculate Mệnh index based on Month and Hour (Simplified from TS)
  final menhIndex = (2 + (lunar.getMonth() - 1) - hourIndex + 12) % 12;
  final thanIndex = (2 + (lunar.getMonth() - 1) + hourIndex) % 12;

  final List<TuviPalace> palaces = [];
  for (int i = 0; i < 12; i++) {
    final palaceNameIndex = (i - menhIndex + 12) % 12;
    palaces.add(TuviPalace(
      id: i,
      name: PALACE_ORDER_VN[palaceNameIndex],
      stars: [],
      wuxing: TUVI_PALACE_WUXING[i],
      isMenh: i == menhIndex,
      isThan: i == thanIndex,
    ));
  }

  // Placeholder star placement logic (Simplified)
  final seed = lunar.getDay() + lunar.getMonth() + lunar.getYear() + hourIndex;
  final mainStars = ['Tử Vi', 'Liêm Trinh', 'Thiên Đồng', 'Vũ Khúc', 'Thái Dương', 'Thiên Cơ'];
  
  for (int idx = 0; idx < mainStars.length; idx++) {
    final pos = (seed + idx * 3) % 12;
    palaces[pos].stars.add(TuviStar(name: mainStars[idx], type: 'Main'));
  }

  return TuviChart(
    ownerName: name.isEmpty ? 'ANONYMOUS_ENTITY' : name,
    birthDate: date.toIso8601String(),
    lunarDate: '${lunar.getDay()}/${lunar.getMonth()}/${lunar.getYear()}',
    menhElement: getElement(date),
    cucElement: 'Thổ', // Simplified
    palaces: palaces,
  );
}

String getElement(DateTime date) {
  final solar = Solar.fromYmdHms(date.year, date.month, date.day, date.hour, date.minute, date.second);
  final lunar = solar.getLunar();
  final elements = ['Kim', 'Mộc', 'Thủy', 'Hỏa', 'Thổ'];
  return elements[lunar.getYearZhiIndex() % 5];
}
