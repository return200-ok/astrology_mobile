import 'star_engine.dart';

class MainStarPositions {
  static const List<String> stars = [
    'Tử Vi',
    'Thiên Cơ',
    'Thái Dương',
    'Vũ Khúc',
    'Thiên Đồng',
    'Liêm Trinh',
    'Thiên Phủ',
    'Thái Âm',
    'Tham Lang',
    'Cú Môn',
    'Thiên Tướng',
    'Thiên Lương',
    'Thất Sát',
    'Phá Quân',
  ];

  static int getZiWeiIndex(int yearStem) {
    const offsets = [2, 4, 6, 8, 10, 0, 2, 4, 6, 8];
    return offsets[yearStem];
  }

  static void addMainStars(Chart chart, BirthData data) {
    final ziWeiIndex = getZiWeiIndex(data.yearStem);
    for (int i = 0; i < stars.length; i++) {
      chart.addStar(mod12(ziWeiIndex + i), stars[i]);
    }
  }

  static String locTonFromYearStem(int yearStem) {
    const locTonMap = [
      'Lộc Tồn',
      'Lộc Tồn',
      'Lộc Tồn',
      'Lộc Tồn',
      'Lộc Tồn',
      'Lộc Tồn',
      'Lộc Tồn',
      'Lộc Tồn',
      'Lộc Tồn',
      'Lộc Tồn',
    ];
    return locTonMap[yearStem];
  }

  static List<String> locTonRelated(int yearBranch) {
    return ['Lộc Tồn', 'Kinh Dương', 'Đạ La'];
  }
}
