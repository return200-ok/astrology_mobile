import 'star_engine.dart';

List<String> hourBasedStars(int hourBranch) {
  const starMap = {
    0: ['Văn Xương', 'Hóa Tinh'],
    1: ['Văn Khúc', 'Hóa Tinh'],
    2: ['Hóa Tinh', 'Linh Tinh'],
    3: ['Linh Tinh', 'Địa Không'],
    4: ['Địa Không', 'Địa Kiếp'],
    5: ['Địa Kiếp', 'Văn Xương'],
    6: ['Văn Xương', 'Văn Khúc'],
    7: ['Văn Khúc', 'Hóa Tinh'],
    8: ['Hóa Tinh', 'Linh Tinh'],
    9: ['Linh Tinh', 'Địa Không'],
    10: ['Địa Không', 'Địa Kiếp'],
    11: ['Địa Kiếp', 'Văn Xương'],
  };
  return starMap[hourBranch] ?? [];
}

List<String> yearBasedStars(int yearBranch) {
  const starMap = {
    0: ['Thiên Mã', 'Đạo Hoa'],
    1: ['Hồng Loan', 'Thiên Hỷ'],
    2: ['Thiên Mã', 'Đạo Hoa'],
    3: ['Hồng Loan', 'Thiên Hỷ'],
    4: ['Thiên Mã', 'Đạo Hoa'],
    5: ['Hồng Loan', 'Thiên Hỷ'],
    6: ['Thiên Mã', 'Đạo Hoa'],
    7: ['Hồng Loan', 'Thiên Hỷ'],
    8: ['Thiên Mã', 'Đạo Hoa'],
    9: ['Hồng Loan', 'Thiên Hỷ'],
    10: ['Thiên Mã', 'Đạo Hoa'],
    11: ['Hồng Loan', 'Thiên Hỷ'],
  };
  return starMap[yearBranch] ?? [];
}

String thienKhoiVietFromStem(int yearStem) {
  const map = [
    'Thiên Khôi',
    'Thiên Việt',
    'Thiên Khôi',
    'Thiên Việt',
    'Thiên Khôi',
    'Thiên Việt',
    'Thiên Khôi',
    'Thiên Việt',
    'Thiên Khôi',
    'Thiên Việt',
  ];
  return map[yearStem];
}

List<String> trangSinhPositions(int cucNumber) {
  const cycle = [
    'Tràng Sinh',
    'Mộc Dục',
    'Quan Đối',
    'Lâm Quan',
    'Đế Vương',
    'Suy',
    'Bệnh',
    'Tử',
    'Mộ',
    'Tuyệt',
    'Thai',
    'Dương',
  ];
  return cycle;
}
