class PalaceData {
  const PalaceData({
    required this.row,
    required this.col,
    required this.name,
    required this.mainStars,
    required this.minorStars,
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.element,
  });

  final int row;
  final int col;
  final String name;
  final List<String> mainStars;
  final List<String> minorStars;
  final String topLeft;
  final String topRight;
  final String bottomLeft;
  final String element;
}

const List<PalaceData> kImperialPalaces = [
  PalaceData(
    row: 0, col: 0, name: 'MỆNH',
    mainStars: ['TỬ VI', 'THIÊN PHỦ'],
    minorStars: ['HỒNG LOAN', 'HỈ THẦN', 'LỘC TỒN'],
    topLeft: 'Ất', topRight: 'Tý', bottomLeft: 'Đinh', element: 'Thủy',
  ),
  PalaceData(
    row: 0, col: 1, name: 'PHỤ MẪU',
    mainStars: ['LIÊM TRINH'],
    minorStars: ['VĂN XƯƠNG', 'HOA CÁI', 'THIÊN PHÚ'],
    topLeft: 'Đinh', topRight: 'Thìn', bottomLeft: 'Giáp', element: 'Mộc',
  ),
  PalaceData(
    row: 0, col: 2, name: 'PHÚC ĐỨC',
    mainStars: ['THÁI ÂM', 'VŨ KHÚC'],
    minorStars: ['THIÊN VIỆT', 'THIÊN SỨ'],
    topLeft: 'Canh', topRight: 'Tý', bottomLeft: 'Đinh', element: 'Kim',
  ),
  PalaceData(
    row: 1, col: 0, name: 'TÀI BẠCH',
    mainStars: ['THIÊN LƯƠNG'],
    minorStars: ['HỒNG LOAN', 'PHI THẦN', 'LỘC TỒN'],
    topLeft: 'Ất', topRight: 'Mùi', bottomLeft: 'Đinh', element: 'Thủy',
  ),
  PalaceData(
    row: 1, col: 2, name: 'ĐIỀN TRẠCH',
    mainStars: ['THIÊN CƠ'],
    minorStars: ['LONG TRÌ', 'PHƯỢNG CÁC'],
    topLeft: 'Tân', topRight: 'Sửu', bottomLeft: 'Đinh', element: 'Kim',
  ),
  PalaceData(
    row: 2, col: 0, name: 'THIÊN DI',
    mainStars: ['THAM LANG'],
    minorStars: ['ĐÀ LA', 'LINH TINH'],
    topLeft: 'Giáp', topRight: 'Tuất', bottomLeft: 'Ất', element: 'Thổ',
  ),
  PalaceData(
    row: 2, col: 1, name: 'NÔ BỘC',
    mainStars: ['CỰ MÔN'],
    minorStars: ['KHÔ', 'HƯ', 'TANG MÔN'],
    topLeft: 'Giáp', topRight: 'Thân', bottomLeft: 'Bính', element: 'Trung',
  ),
  PalaceData(
    row: 2, col: 2, name: 'QUAN LỘC',
    mainStars: ['THẤT SÁT', 'PHÁ QUÂN'],
    minorStars: ['QUỐC ẤN', 'TAM THAI'],
    topLeft: 'Tân', topRight: 'Ngọ', bottomLeft: 'Bính', element: 'Thủy',
  ),
];
