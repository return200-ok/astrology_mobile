import 'dart:math';

/// I Ching hexagram. Lines are stored bottom-to-top (line 1 first).
/// `true` = yang (─── solid), `false` = yin (─ ─ broken).
class IChingHexagram {
  const IChingHexagram({
    required this.number,
    required this.nameVi,
    required this.nameEn,
    required this.lines,
    required this.judgmentVi,
  });

  final int number;
  final String nameVi;
  final String nameEn;
  final List<bool> lines;
  final String judgmentVi;

  /// Cast a hexagram via simulated yarrow-stalk method.
  /// Each line is determined independently by a uniform random draw,
  /// then matched to the King Wen index by upper/lower trigram.
  static IChingHexagram cast([Random? random]) {
    final r = random ?? Random.secure();
    final lines = List<bool>.generate(6, (_) => r.nextBool());
    final lower = _trigramIndex(lines.sublist(0, 3));
    final upper = _trigramIndex(lines.sublist(3, 6));
    final number = _kingWenLookup[upper][lower];
    return kIChingHexagrams[number - 1];
  }

  static int _trigramIndex(List<bool> three) {
    // Bottom line is bit 0 in traditional ordering used by the lookup table.
    var idx = 0;
    if (three[0]) idx |= 1;
    if (three[1]) idx |= 2;
    if (three[2]) idx |= 4;
    return idx;
  }
}

// Trigram order (idx → meaning):
// 0=Khôn(Earth) 1=Chấn(Thunder) 2=Khảm(Water) 3=Đoài(Lake)
// 4=Cấn(Mountain) 5=Ly(Fire) 6=Tốn(Wind) 7=Càn(Heaven)
// Indexed as _kingWenLookup[upper][lower] → King Wen number.
const List<List<int>> _kingWenLookup = [
  [2, 24, 7, 19, 15, 36, 46, 11],   // upper Khôn
  [16, 51, 40, 54, 62, 55, 32, 34], // upper Chấn
  [8, 3, 29, 60, 39, 63, 48, 5],    // upper Khảm
  [45, 17, 47, 58, 31, 49, 28, 43], // upper Đoài
  [23, 27, 4, 41, 52, 22, 18, 26],  // upper Cấn
  [35, 21, 64, 38, 56, 30, 50, 14], // upper Ly
  [20, 42, 59, 61, 53, 37, 57, 9],  // upper Tốn
  [12, 25, 6, 10, 33, 13, 44, 1],   // upper Càn
];

const List<IChingHexagram> kIChingHexagrams = [
  IChingHexagram(number: 1, nameVi: 'Thuần Càn', nameEn: 'The Creative',
      lines: [true, true, true, true, true, true],
      judgmentVi: 'Sức mạnh sáng tạo nguyên thủy. Thời điểm khởi đầu đầy năng lượng — hành động chính trực sẽ mang lại tiến triển.'),
  IChingHexagram(number: 2, nameVi: 'Thuần Khôn', nameEn: 'The Receptive',
      lines: [false, false, false, false, false, false],
      judgmentVi: 'Sự tiếp nhận và nuôi dưỡng. Lúc nên lắng nghe, kiên nhẫn và đi theo dòng chảy hơn là cưỡng cầu.'),
  IChingHexagram(number: 3, nameVi: 'Thuỷ Lôi Truân', nameEn: 'Difficulty at the Beginning',
      lines: [true, false, false, false, true, false],
      judgmentVi: 'Khởi đầu gian nan. Cần kiên trì, không nóng vội — hỗn loạn ban đầu sẽ ổn định khi có cấu trúc.'),
  IChingHexagram(number: 4, nameVi: 'Sơn Thuỷ Mông', nameEn: 'Youthful Folly',
      lines: [false, true, false, false, false, true],
      judgmentVi: 'Sự non nớt cần được dạy. Khiêm tốn học hỏi và tìm người dẫn dắt là chìa khoá.'),
  IChingHexagram(number: 5, nameVi: 'Thuỷ Thiên Nhu', nameEn: 'Waiting',
      lines: [true, true, true, false, true, false],
      judgmentVi: 'Chờ đợi với niềm tin. Thời cơ chưa đến — duy trì sự bình tĩnh và sẵn sàng nội tại.'),
  IChingHexagram(number: 6, nameVi: 'Thiên Thuỷ Tụng', nameEn: 'Conflict',
      lines: [false, true, false, true, true, true],
      judgmentVi: 'Tranh chấp tiềm ẩn. Tốt nhất nên dừng giữa chừng, tìm trung gian thay vì thắng bằng mọi giá.'),
  IChingHexagram(number: 7, nameVi: 'Địa Thuỷ Sư', nameEn: 'The Army',
      lines: [false, true, false, false, false, false],
      judgmentVi: 'Cần kỷ luật và lãnh đạo có nguyên tắc. Tổ chức rõ ràng đem lại sức mạnh tập thể.'),
  IChingHexagram(number: 8, nameVi: 'Thuỷ Địa Tỷ', nameEn: 'Holding Together',
      lines: [false, false, false, false, true, false],
      judgmentVi: 'Đoàn kết và liên minh. Tham gia sớm, chân thành — kết nối đúng lúc tạo ra sức mạnh chung.'),
  IChingHexagram(number: 9, nameVi: 'Phong Thiên Tiểu Súc', nameEn: 'Small Taming',
      lines: [true, true, true, true, false, true],
      judgmentVi: 'Tích lũy nhỏ. Tiến triển bị hạn chế tạm thời — tinh chỉnh chi tiết, chờ thời cơ.'),
  IChingHexagram(number: 10, nameVi: 'Thiên Trạch Lý', nameEn: 'Treading',
      lines: [true, true, false, true, true, true],
      judgmentVi: 'Bước đi cẩn trọng giữa nguy hiểm. Sự lễ độ và tỉnh táo giúp vượt qua tình huống khó.'),
  IChingHexagram(number: 11, nameVi: 'Địa Thiên Thái', nameEn: 'Peace',
      lines: [true, true, true, false, false, false],
      judgmentVi: 'Hài hoà và thịnh vượng. Trời đất giao hoà — thời điểm tốt để xây dựng và mở rộng.'),
  IChingHexagram(number: 12, nameVi: 'Thiên Địa Bĩ', nameEn: 'Standstill',
      lines: [false, false, false, true, true, true],
      judgmentVi: 'Bế tắc, ngăn cách. Giữ đạo, thu mình lại — chờ đợi thời thế chuyển biến.'),
  IChingHexagram(number: 13, nameVi: 'Thiên Hoả Đồng Nhân', nameEn: 'Fellowship',
      lines: [true, false, true, true, true, true],
      judgmentVi: 'Đồng tâm hiệp lực. Hợp tác cởi mở với người chung lý tưởng đem lại thành công.'),
  IChingHexagram(number: 14, nameVi: 'Hoả Thiên Đại Hữu', nameEn: 'Great Possession',
      lines: [true, true, true, true, false, true],
      judgmentVi: 'Sở hữu lớn lao. Khiêm nhường khi giàu có, chia sẻ rộng rãi để duy trì phúc khí.'),
  IChingHexagram(number: 15, nameVi: 'Địa Sơn Khiêm', nameEn: 'Modesty',
      lines: [false, false, true, false, false, false],
      judgmentVi: 'Khiêm nhường. Người có tài giấu mình — sự nhún nhường mở ra cơ hội bền vững.'),
  IChingHexagram(number: 16, nameVi: 'Lôi Địa Dự', nameEn: 'Enthusiasm',
      lines: [false, false, false, true, false, false],
      judgmentVi: 'Hào hứng đúng lúc. Cảm hứng tập thể bùng lên — tận dụng khoảnh khắc nhưng tránh xa hoa.'),
  IChingHexagram(number: 17, nameVi: 'Trạch Lôi Tuỳ', nameEn: 'Following',
      lines: [true, false, false, true, true, false],
      judgmentVi: 'Tuỳ thuận thời thế. Linh hoạt theo hoàn cảnh, nhưng giữ nguyên tắc nội tại.'),
  IChingHexagram(number: 18, nameVi: 'Sơn Phong Cổ', nameEn: 'Work on the Decayed',
      lines: [false, true, true, false, false, true],
      judgmentVi: 'Sửa chữa cái cũ. Đối diện với di sản hư hỏng và khôi phục lại — cần cả can đảm và tỉ mỉ.'),
  IChingHexagram(number: 19, nameVi: 'Địa Trạch Lâm', nameEn: 'Approach',
      lines: [true, true, false, false, false, false],
      judgmentVi: 'Đến gần. Cơ hội tiến tới — hành động sớm với sự chân thành sẽ thuận lợi.'),
  IChingHexagram(number: 20, nameVi: 'Phong Địa Quan', nameEn: 'Contemplation',
      lines: [false, false, false, false, true, true],
      judgmentVi: 'Quan sát. Lùi lại để nhìn toàn cảnh — sự rõ ràng đến từ tĩnh tại, không phải hành động.'),
  IChingHexagram(number: 21, nameVi: 'Hoả Lôi Phệ Hạp', nameEn: 'Biting Through',
      lines: [true, false, false, true, false, true],
      judgmentVi: 'Cắt đứt trở ngại. Cần dứt khoát giải quyết vấn đề — không nên trì hoãn.'),
  IChingHexagram(number: 22, nameVi: 'Sơn Hoả Bí', nameEn: 'Grace',
      lines: [true, false, true, false, false, true],
      judgmentVi: 'Vẻ đẹp và hình thức. Trang nhã có giới hạn — đừng để hình thức lấn át bản chất.'),
  IChingHexagram(number: 23, nameVi: 'Sơn Địa Bác', nameEn: 'Splitting Apart',
      lines: [false, false, false, false, false, true],
      judgmentVi: 'Suy thoái. Không nên hành động lớn — bảo toàn cốt lõi, chờ chu kỳ mới.'),
  IChingHexagram(number: 24, nameVi: 'Địa Lôi Phục', nameEn: 'Return',
      lines: [true, false, false, false, false, false],
      judgmentVi: 'Trở về. Khởi đầu mới sau giai đoạn khó — bước đầu nhỏ nhưng đúng hướng.'),
  IChingHexagram(number: 25, nameVi: 'Thiên Lôi Vô Vọng', nameEn: 'Innocence',
      lines: [true, false, false, true, true, true],
      judgmentVi: 'Vô tư, tự nhiên. Hành động không vụ lợi mang lại kết quả tốt; toan tính sẽ phản tác dụng.'),
  IChingHexagram(number: 26, nameVi: 'Sơn Thiên Đại Súc', nameEn: 'Great Taming',
      lines: [true, true, true, false, false, true],
      judgmentVi: 'Tích luỹ lớn. Học hỏi sâu sắc và tích trữ năng lực — thời cơ chinh phục đang đến gần.'),
  IChingHexagram(number: 27, nameVi: 'Sơn Lôi Di', nameEn: 'Nourishment',
      lines: [true, false, false, false, false, true],
      judgmentVi: 'Nuôi dưỡng. Chú ý đến những gì bạn hấp thụ — thân, tâm, ngôn từ đều cần chọn lọc.'),
  IChingHexagram(number: 28, nameVi: 'Trạch Phong Đại Quá', nameEn: 'Great Excess',
      lines: [false, true, true, true, true, false],
      judgmentVi: 'Quá tải. Gánh nặng vượt sức — cần điều chỉnh trước khi sụp đổ.'),
  IChingHexagram(number: 29, nameVi: 'Thuần Khảm', nameEn: 'The Abysmal',
      lines: [false, true, false, false, true, false],
      judgmentVi: 'Vực thẳm lặp lại. Hiểm nguy chồng chất — giữ tâm vững như nước, tiếp tục tiến.'),
  IChingHexagram(number: 30, nameVi: 'Thuần Ly', nameEn: 'The Clinging',
      lines: [true, false, true, true, false, true],
      judgmentVi: 'Bám vào ánh sáng. Sự sáng suốt cần nương tựa vào điều đúng đắn — đừng đốt cháy bản thân.'),
  IChingHexagram(number: 31, nameVi: 'Trạch Sơn Hàm', nameEn: 'Mutual Influence',
      lines: [false, false, true, true, true, false],
      judgmentVi: 'Cảm ứng lẫn nhau. Sự thu hút chân thành — quan hệ phát triển tự nhiên không gượng ép.'),
  IChingHexagram(number: 32, nameVi: 'Lôi Phong Hằng', nameEn: 'Duration',
      lines: [false, true, true, true, false, false],
      judgmentVi: 'Bền vững. Kiên trì trên con đường đã chọn — sự ổn định lâu dài quan trọng hơn đột biến.'),
  IChingHexagram(number: 33, nameVi: 'Thiên Sơn Độn', nameEn: 'Retreat',
      lines: [false, false, true, true, true, true],
      judgmentVi: 'Rút lui có chiến lược. Biết khi nào nên dừng — bảo toàn sức để quay lại đúng thời.'),
  IChingHexagram(number: 34, nameVi: 'Lôi Thiên Đại Tráng', nameEn: 'Great Power',
      lines: [true, true, true, true, false, false],
      judgmentVi: 'Sức mạnh lớn. Hành động cương trực, nhưng tránh kiêu ngạo và sử dụng quyền lực thô bạo.'),
  IChingHexagram(number: 35, nameVi: 'Hoả Địa Tấn', nameEn: 'Progress',
      lines: [false, false, false, true, false, true],
      judgmentVi: 'Tiến triển. Thăng tiến rõ ràng — duy trì sự ngay thẳng và tiếp tục cống hiến.'),
  IChingHexagram(number: 36, nameVi: 'Địa Hoả Minh Di', nameEn: 'Darkening of the Light',
      lines: [true, false, true, false, false, false],
      judgmentVi: 'Ánh sáng bị che mờ. Giữ kín tài năng trong thời điểm bất lợi, kiên định bên trong.'),
  IChingHexagram(number: 37, nameVi: 'Phong Hoả Gia Nhân', nameEn: 'The Family',
      lines: [true, false, true, true, true, false],
      judgmentVi: 'Gia đình. Trật tự nội bộ là nền tảng — vai trò rõ ràng và yêu thương song hành.'),
  IChingHexagram(number: 38, nameVi: 'Hoả Trạch Khuê', nameEn: 'Opposition',
      lines: [true, true, false, true, false, true],
      judgmentVi: 'Bất đồng. Khác biệt vẫn có thể hợp tác việc nhỏ — tránh tham vọng lớn lúc này.'),
  IChingHexagram(number: 39, nameVi: 'Thuỷ Sơn Kiển', nameEn: 'Obstruction',
      lines: [false, false, true, false, true, false],
      judgmentVi: 'Trở ngại. Nghĩ lại con đường — đôi khi quay đầu là cách tiến nhanh hơn.'),
  IChingHexagram(number: 40, nameVi: 'Lôi Thuỷ Giải', nameEn: 'Deliverance',
      lines: [false, true, false, true, false, false],
      judgmentVi: 'Giải toả. Khó khăn được tháo gỡ — hành động nhanh chóng để khôi phục bình thường.'),
  IChingHexagram(number: 41, nameVi: 'Sơn Trạch Tổn', nameEn: 'Decrease',
      lines: [true, true, false, false, false, true],
      judgmentVi: 'Giảm bớt. Cắt giảm để tập trung — đơn giản hoá mang lại sức mạnh thực sự.'),
  IChingHexagram(number: 42, nameVi: 'Phong Lôi Ích', nameEn: 'Increase',
      lines: [true, false, false, false, true, true],
      judgmentVi: 'Gia tăng. Năng lượng đang chảy về phía bạn — mở rộng có trách nhiệm.'),
  IChingHexagram(number: 43, nameVi: 'Trạch Thiên Quải', nameEn: 'Breakthrough',
      lines: [true, true, true, true, true, false],
      judgmentVi: 'Đột phá. Phải dứt khoát loại bỏ tiêu cực — công khai và quyết đoán.'),
  IChingHexagram(number: 44, nameVi: 'Thiên Phong Cấu', nameEn: 'Coming to Meet',
      lines: [false, true, true, true, true, true],
      judgmentVi: 'Gặp gỡ bất ngờ. Thận trọng với những kết nối quá nhanh — chưa phải lúc cam kết.'),
  IChingHexagram(number: 45, nameVi: 'Trạch Địa Tuỵ', nameEn: 'Gathering Together',
      lines: [false, false, false, false, true, true],
      judgmentVi: 'Tụ họp. Tập hợp đúng người, đúng mục đích — lãnh đạo bằng tầm nhìn chung.'),
  IChingHexagram(number: 46, nameVi: 'Địa Phong Thăng', nameEn: 'Pushing Upward',
      lines: [true, true, false, false, false, false],
      judgmentVi: 'Vươn lên. Tiến triển từ từ và vững chắc — như cây mọc lên từ đất.'),
  IChingHexagram(number: 47, nameVi: 'Trạch Thuỷ Khốn', nameEn: 'Oppression',
      lines: [false, true, false, true, true, false],
      judgmentVi: 'Bức bách. Hoàn cảnh ngặt nghèo — giữ niềm tin nội tại, lời nói lúc này khó được nghe.'),
  IChingHexagram(number: 48, nameVi: 'Thuỷ Phong Tỉnh', nameEn: 'The Well',
      lines: [true, true, false, false, true, false],
      judgmentVi: 'Giếng nước. Nguồn lực sẵn có nhưng cần được duy trì và tiếp cận đúng cách.'),
  IChingHexagram(number: 49, nameVi: 'Trạch Hoả Cách', nameEn: 'Revolution',
      lines: [true, false, true, true, true, false],
      judgmentVi: 'Cách mạng. Đã đến lúc thay đổi cơ bản — chỉ làm khi thời cơ chín và mục đích chính đáng.'),
  IChingHexagram(number: 50, nameVi: 'Hoả Phong Đỉnh', nameEn: 'The Cauldron',
      lines: [false, true, true, true, false, true],
      judgmentVi: 'Cái đỉnh. Chuyển hoá thô thành tinh — đầu tư vào nuôi dưỡng tài năng và văn hoá.'),
  IChingHexagram(number: 51, nameVi: 'Thuần Chấn', nameEn: 'The Arousing',
      lines: [true, false, false, true, false, false],
      judgmentVi: 'Sấm động. Cú sốc khơi dậy ý thức — giữ bình tĩnh, sự sợ hãi sẽ qua.'),
  IChingHexagram(number: 52, nameVi: 'Thuần Cấn', nameEn: 'Keeping Still',
      lines: [false, false, true, false, false, true],
      judgmentVi: 'Tĩnh tại. Dừng lại đúng lúc — tâm yên định mới thấy được con đường.'),
  IChingHexagram(number: 53, nameVi: 'Phong Sơn Tiệm', nameEn: 'Gradual Progress',
      lines: [false, false, true, true, true, false],
      judgmentVi: 'Tiến từng bước. Phát triển từ từ và bền vững — kiên nhẫn là chìa khoá.'),
  IChingHexagram(number: 54, nameVi: 'Lôi Trạch Quy Muội', nameEn: 'The Marrying Maiden',
      lines: [true, true, false, true, false, false],
      judgmentVi: 'Vị trí phụ. Hoàn cảnh không lý tưởng — chấp nhận giới hạn, không cưỡng cầu.'),
  IChingHexagram(number: 55, nameVi: 'Lôi Hoả Phong', nameEn: 'Abundance',
      lines: [true, false, true, true, false, false],
      judgmentVi: 'Thịnh vượng. Đỉnh cao của chu kỳ — tận hưởng nhưng nhận biết sự vô thường.'),
  IChingHexagram(number: 56, nameVi: 'Hoả Sơn Lữ', nameEn: 'The Wanderer',
      lines: [false, false, true, true, false, true],
      judgmentVi: 'Lữ khách. Trên đường đi qua — khiêm nhường, thận trọng và linh hoạt.'),
  IChingHexagram(number: 57, nameVi: 'Thuần Tốn', nameEn: 'The Gentle',
      lines: [false, true, true, false, true, true],
      judgmentVi: 'Gió thâm nhập. Ảnh hưởng nhẹ nhàng và liên tục — kiên trì hơn là áp đặt.'),
  IChingHexagram(number: 58, nameVi: 'Thuần Đoài', nameEn: 'The Joyous',
      lines: [true, true, false, true, true, false],
      judgmentVi: 'Hân hoan. Niềm vui chia sẻ nhân lên — nhưng giữ thực chất, tránh hời hợt.'),
  IChingHexagram(number: 59, nameVi: 'Phong Thuỷ Hoán', nameEn: 'Dispersion',
      lines: [false, true, false, false, true, true],
      judgmentVi: 'Tan rã. Phá vỡ tắc nghẽn — quy tụ lại quanh mục đích chung sau khi đã thông thoáng.'),
  IChingHexagram(number: 60, nameVi: 'Thuỷ Trạch Tiết', nameEn: 'Limitation',
      lines: [true, true, false, false, true, false],
      judgmentVi: 'Giới hạn. Đặt ra ranh giới hợp lý — kỷ luật vừa phải tạo ra tự do thực sự.'),
  IChingHexagram(number: 61, nameVi: 'Phong Trạch Trung Phu', nameEn: 'Inner Truth',
      lines: [true, true, false, false, true, true],
      judgmentVi: 'Sự chân thành nội tâm. Niềm tin chân thật cảm hoá ngay cả những hoàn cảnh khó.'),
  IChingHexagram(number: 62, nameVi: 'Lôi Sơn Tiểu Quá', nameEn: 'Small Excess',
      lines: [false, false, true, true, false, false],
      judgmentVi: 'Vượt mức nhỏ. Việc nhỏ làm được, việc lớn nên dừng — khiêm tốn vượt qua giai đoạn.'),
  IChingHexagram(number: 63, nameVi: 'Thuỷ Hoả Ký Tế', nameEn: 'After Completion',
      lines: [true, false, true, false, true, false],
      judgmentVi: 'Đã hoàn thành. Mọi thứ đúng vị trí — nhưng cảnh giác, vì sau đỉnh là chu kỳ mới.'),
  IChingHexagram(number: 64, nameVi: 'Hoả Thuỷ Vị Tế', nameEn: 'Before Completion',
      lines: [false, true, false, true, false, true],
      judgmentVi: 'Sắp hoàn thành. Bước cuối quan trọng nhất — duy trì cảnh giác và chính trực đến cùng.'),
];
