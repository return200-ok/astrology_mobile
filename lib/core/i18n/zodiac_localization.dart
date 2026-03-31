import 'package:flutter/widgets.dart';

class ZodiacLocalization {
  const ZodiacLocalization._();

  // ── Names ────────────────────────────────────────────────────────────────

  static const Map<String, String> _englishNames = <String, String>{
    'aries': 'Aries',
    'taurus': 'Taurus',
    'gemini': 'Gemini',
    'cancer': 'Cancer',
    'leo': 'Leo',
    'virgo': 'Virgo',
    'libra': 'Libra',
    'scorpio': 'Scorpio',
    'sagittarius': 'Sagittarius',
    'capricorn': 'Capricorn',
    'aquarius': 'Aquarius',
    'pisces': 'Pisces',
  };

  static const Map<String, String> _vietnameseNames = <String, String>{
    'aries': 'Bạch Dương',
    'taurus': 'Kim Ngưu',
    'gemini': 'Song Tử',
    'cancer': 'Cự Giải',
    'leo': 'Sư Tử',
    'virgo': 'Xử Nữ',
    'libra': 'Thiên Bình',
    'scorpio': 'Bọ Cạp',
    'sagittarius': 'Nhân Mã',
    'capricorn': 'Ma Kết',
    'aquarius': 'Bảo Bình',
    'pisces': 'Song Ngư',
  };

  // ── Date ranges ───────────────────────────────────────────────────────────

  static const Map<String, String> _englishRanges = <String, String>{
    'aries': 'Mar 21 - Apr 19',
    'taurus': 'Apr 20 - May 20',
    'gemini': 'May 21 - Jun 20',
    'cancer': 'Jun 21 - Jul 22',
    'leo': 'Jul 23 - Aug 22',
    'virgo': 'Aug 23 - Sep 22',
    'libra': 'Sep 23 - Oct 22',
    'scorpio': 'Oct 23 - Nov 21',
    'sagittarius': 'Nov 22 - Dec 21',
    'capricorn': 'Dec 22 - Jan 19',
    'aquarius': 'Jan 20 - Feb 18',
    'pisces': 'Feb 19 - Mar 20',
  };

  static const Map<String, String> _vietnameseRanges = <String, String>{
    'aries': '21/3 - 19/4',
    'taurus': '20/4 - 20/5',
    'gemini': '21/5 - 20/6',
    'cancer': '21/6 - 22/7',
    'leo': '23/7 - 22/8',
    'virgo': '23/8 - 22/9',
    'libra': '23/9 - 22/10',
    'scorpio': '23/10 - 21/11',
    'sagittarius': '22/11 - 21/12',
    'capricorn': '22/12 - 19/1',
    'aquarius': '20/1 - 18/2',
    'pisces': '19/2 - 20/3',
  };

  // ── Guidance ─────────────────────────────────────────────────────────────

  static const Map<String, String> _vietnameseGuidance = <String, String>{
    'aries':
        'CHỈ DẪN THIÊN CẦU: Ngọn lửa bên trong bạn đang bừng cháy. Một con đường mới đang hình thành. '
        'Hãy bước đi táo bạo và tin vào bản năng đầu tiên của bạn.',
    'taurus':
        'CHỈ DẪN THIÊN CẦU: Bám rễ vào sự tĩnh lặng. Thịnh vượng lớn lên qua sự kiên nhẫn và '
        'tận tâm với những gì thực sự nuôi dưỡng tâm hồn bạn.',
    'gemini':
        'CHỈ DẪN THIÊN CẦU: Thông điệp đang đến từ nhiều cõi. Hãy theo đuổi sự tò mò và '
        'để tiếng nói của bạn trở thành cây cầu ánh sáng.',
    'cancer':
        'CHỈ DẪN THIÊN CẦU: Những con sóng cảm xúc của bạn mang theo trí tuệ. Hãy bảo vệ sự mềm mại của mình '
        'và biến ngôi nhà thành nơi trú ẩn để tái sinh.',
    'leo':
        'CHỈ DẪN THIÊN CẦU: Hãy đứng trong ánh sáng của bạn không cần xin lỗi. '
        'Niềm vui của bạn là phương thuốc cho người khác và sự lãnh đạo là sự thức tỉnh.',
    'virgo':
        'CHỈ DẪN THIÊN CẦU: Hãy tinh chỉnh những nghi lễ của bạn và điều chỉnh theo mục đích. '
        'Mỗi hành động thiêng liêng nhỏ bé trở thành cánh cửa dẫn đến sự thành thạo.',
    'libra':
        'CHỈ DẪN THIÊN CẦU: Tìm kiếm sự hài hòa mà không đánh mất trung tâm của bạn. '
        'Món quà của bạn là mang lại vẻ đẹp, công bằng và sự cân bằng duyên dáng.',
    'scorpio':
        'CHỈ DẪN THIÊN CẦU: Biến đổi là địa hình thiêng liêng của bạn. Hãy buông bỏ những lớp vỏ cũ '
        'và tin tưởng vào sự tái sinh sau sự thật sâu thẳm.',
    'sagittarius':
        'CHỈ DẪN THIÊN CẦU: Sự mở rộng đang gọi tên bạn. Hãy theo đuổi sự thật, chuyển động '
        'và triết học giải phóng tâm hồn bạn.',
    'capricorn':
        'CHỈ DẪN THIÊN CẦU: Hãy xây dựng những gì trường tồn. Kỷ luật của bạn là thiêng liêng '
        'và sự tận tâm của bạn có thể biến núi thành con đường.',
    'aquarius':
        'CHỈ DẪN THIÊN CẦU: Hãy đổi mới từ tâm hồn. Những ý tưởng của bạn đến từ tương lai '
        'và được sinh ra để giải phóng ý thức tập thể.',
    'pisces':
        'CHỈ DẪN THIÊN CẦU: Hãy để lòng trắc ẩn dẫn dắt dòng chảy của bạn. '
        'Những giấc mơ và trực giác đang lên tiếng; hãy mềm lòng, lắng nghe và tiếp nhận.',
  };

  // ── Essence ───────────────────────────────────────────────────────────────

  static const Map<String, List<String>> _vietnameseEssence =
      <String, List<String>>{
    'aries': ['Người khởi xướng bẩm sinh', 'Năng lượng rực rỡ', 'Theo bản năng', 'Không sợ hãi'],
    'taurus': ['Trái tim kiên định', 'Vững chãi', 'Nhạy cảm giác quan', 'Đáng tin cậy'],
    'gemini': ['Linh hoạt', 'Tò mò', 'Hòa đồng', 'Tự do'],
    'cancer': ['Tâm hồn chăm sóc', 'Nhạy cảm', 'Bảo vệ', 'Tận tâm'],
    'leo': ['Sức hút mặt trời', 'Lửa sáng tạo', 'Cao quý', 'Ấm áp'],
    'virgo': ['Sáng suốt', 'Chính xác', 'Chữa lành', 'Khiêm tốn'],
    'libra': ['Thanh lịch', 'Ngoại giao', 'Tinh tế', 'Gắn kết'],
    'scorpio': ['Thu hút', 'Mãnh liệt', 'Biến đổi', 'Kín đáo'],
    'sagittarius': ['Có tầm nhìn', 'Phiêu lưu', 'Lạc quan', 'Trung thực'],
    'capricorn': ['Có kỷ luật', 'Tham vọng', 'Có trách nhiệm', 'Bền bỉ'],
    'aquarius': ['Độc đáo', 'Độc lập', 'Có tầm nhìn', 'Nhân đạo'],
    'pisces': ['Đồng cảm huyền bí', 'Giàu trí tưởng tượng', 'Từ bi', 'Linh hoạt'],
  };

  // ── Spiritual Flow ────────────────────────────────────────────────────────

  static const Map<String, List<String>> _vietnameseSpiritualFlow =
      <String, List<String>>{
    'aries': ['Thẳng thắn và tập trung', 'Trực giác nhanh nhạy', 'Logic thiêng liêng'],
    'taurus': ['Tiến bộ nhất quán', 'Trí tuệ đất', 'Kỷ luật thiêng liêng'],
    'gemini': ['Phân tích', 'Trí tuệ nhanh nhạy', 'Đa năng'],
    'cancer': ['Trực giác mặt trăng', 'Ký ức trái tim', 'Trí tuệ cảm xúc'],
    'leo': ['Biểu đạt chân thực', 'Tình yêu can đảm', 'Tinh thần rộng lượng'],
    'virgo': ['Rõ ràng có cấu trúc', 'Phục vụ có chủ tâm', 'Phép màu thực tế'],
    'libra': ['Trực giác thẩm mỹ', 'Hòa giải bình tĩnh', 'Cảm thức công lý'],
    'scorpio': ['Nội tâm không sợ hãi', 'Giả kim cảm xúc', 'Ý chí tập trung'],
    'sagittarius': ['Học hỏi cao hơn', 'Tự do tâm linh', 'Niềm tin toàn cảnh'],
    'capricorn': ['Tập trung chiến lược', 'Leo lên đều đặn', 'Tư duy di sản'],
    'aquarius': ['Rõ ràng tách biệt', 'Cái nhìn sáng tạo', 'Phục vụ tập thể'],
    'pisces': ['Trí tuệ giấc mơ', 'Buông mình tâm linh', 'Chữa lành tinh tế'],
  };

  // ── Drawn To ─────────────────────────────────────────────────────────────

  static const Map<String, List<String>> _vietnameseDrawnTo =
      <String, List<String>>{
    'aries': ['Tâm hồn năng động', 'Sức mạnh nội tâm', 'Linh hồn độc lập'],
    'taurus': ['Kết nối trung thành', 'Vẻ đẹp và nghệ thuật', 'Sự ổn định tâm hồn'],
    'gemini': ['Trí tuệ', 'Sự đa dạng', 'Sự dí dỏm'],
    'cancer': ['Gia đình tâm hồn', 'Sức mạnh dịu dàng', 'Sự gần gũi có ý nghĩa'],
    'leo': ['Người sáng tạo táo bạo', 'Đồng minh trung thành', 'Năng lượng lễ hội'],
    'virgo': ['Chính trực', 'Sự xuất sắc thầm lặng', 'Thói quen có mục đích'],
    'libra': ['Sự tôn trọng lẫn nhau', 'Không gian nghệ thuật', 'Tình bạn tâm hồn'],
    'scorpio': ['Sự chân thực', 'Bí ẩn', 'Tận tâm sâu sắc'],
    'sagittarius': ['Chân trời rộng mở', 'Người thầy khôn ngoan', 'Hành trình mở rộng'],
    'capricorn': ['Đồng minh đáng tin cậy', 'Tầm nhìn dài hạn', 'Thành tích có ý nghĩa'],
    'aquarius': ['Tâm hồn không thông thường', 'Mục tiêu chung', 'Tự do tư tưởng'],
    'pisces': ['Trái tim dịu dàng', 'Tâm hồn nghệ thuật', 'Kết nối tâm linh'],
  };

  // ── Radiates To ──────────────────────────────────────────────────────────

  static const Map<String, List<String>> _vietnameseRadiatesTo =
      <String, List<String>>{
    'aries': ['Người khao khát sự đổi thay', 'Người tiên phong', 'Người tìm kiếm can đảm'],
    'taurus': ['Người cần sự bình yên', 'Người xây dựng', 'Người sáng tạo tâm huyết'],
    'gemini': ['Người tìm kiếm cuộc sống', 'Người kể chuyện'],
    'cancer': ['Người cần sự quan tâm', 'Trẻ em', 'Vòng tròn thiêng liêng'],
    'leo': ['Người tìm kiếm sự tự tin', 'Nghệ sĩ', 'Cộng đồng'],
    'virgo': ['Người cần trật tự', 'Không gian chữa lành', 'Hệ thống'],
    'libra': ['Người tìm kiếm hòa bình', 'Đối tác', 'Nhóm sáng tạo'],
    'scorpio': ['Người trong giai đoạn chuyển đổi', 'Người tìm kiếm sự thật', 'Mối liên kết sâu sắc'],
    'sagittarius': ['Người tìm kiếm ý nghĩa', 'Người du hành', 'Học sinh'],
    'capricorn': ['Người cần cấu trúc', 'Đội nhóm', 'Người xây dựng tương lai'],
    'aquarius': ['Người tìm kiếm thay đổi', 'Cộng đồng', 'Người tư duy tương lai'],
    'pisces': ['Người cần sự an ủi', 'Nghệ sĩ', 'Không gian thiêng liêng'],
  };

  // ── Dharma Path ───────────────────────────────────────────────────────────

  static const Map<String, List<String>> _vietnameseDharmaPath =
      <String, List<String>>{
    'aries': ['Tiên phong', 'Bảo vệ', 'Thắp lửa', 'Lãnh đạo'],
    'taurus': ['Người ổn định', 'Người vun đắp', 'Người bảo vệ', 'Người giữ gìn giá trị'],
    'gemini': ['Người đưa tin', 'Nhà văn', 'Người xây cầu', 'Nhà tư tưởng'],
    'cancer': ['Người chữa lành', 'Người giữ gìn mái ấm', 'Hướng dẫn cảm xúc', 'Nữ tư tế mặt trăng'],
    'leo': ['Người sáng tạo', 'Nghệ sĩ biểu diễn', 'Người dẫn dắt trái tim', 'Nguồn cảm hứng'],
    'virgo': ['Nhà giả kim chi tiết', 'Bậc thầy thủ công', 'Người giải quyết vấn đề', 'Người thầy'],
    'libra': ['Người gìn giữ hòa bình', 'Người kết nối', 'Người tuyển chọn vẻ đẹp', 'Người mang công lý'],
    'scorpio': ['Người biến đổi', 'Người làm việc với bóng tối', 'Người tiết lộ sự thật', 'Người bảo vệ'],
    'sagittarius': ['Người khám phá', 'Người thầy', 'Triết gia', 'Người đưa tin lửa'],
    'capricorn': ['Kiến trúc sư', 'Người quản lý', 'Người leo núi', 'Người tạo di sản'],
    'aquarius': ['Người cải cách', 'Nhà phát minh', 'Người dệt mạng lưới', 'Người thức tỉnh'],
    'pisces': ['Người mơ mộng', 'Người chữa lành', 'Nhà thơ', 'Kênh huyền bí'],
  };

  // ── Sacred Needs ──────────────────────────────────────────────────────────

  static const Map<String, List<String>> _vietnameseSacredNeeds =
      <String, List<String>>{
    'aries': ['Thử thách', 'Tự chủ', 'Hành động'],
    'taurus': ['An toàn', 'Nhịp điệu', 'Vẻ đẹp'],
    'gemini': ['Kích thích tinh thần', 'Biểu đạt', 'Không gian'],
    'cancer': ['An toàn', 'Thuộc về', 'Trung thực cảm xúc'],
    'leo': ['Được công nhận', 'Vui chơi', 'Tình yêu trung thành'],
    'virgo': ['Mục đích', 'Năng lượng trong sạch', 'Đóng góp hữu ích'],
    'libra': ['Cân bằng', 'Đối tác', 'Đối thoại duyên dáng'],
    'scorpio': ['Tin tưởng', 'Chiều sâu', 'Lòng trung thành cảm xúc'],
    'sagittarius': ['Tự do', 'Phát triển', 'Sự thật'],
    'capricorn': ['Tôn trọng', 'Thành thạo', 'Mục tiêu rõ ràng'],
    'aquarius': ['Tự do', 'Cộng đồng có mục đích', 'Đổi mới'],
    'pisces': ['Nơi ẩn náu cảm xúc', 'Dòng chảy sáng tạo', 'Niềm tin tâm linh'],
  };

  // ── Public accessors ──────────────────────────────────────────────────────

  static bool _isVi(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'vi';

  static String name(BuildContext context, String signId) {
    final table = _isVi(context) ? _vietnameseNames : _englishNames;
    return table[signId] ?? signId;
  }

  static String range(BuildContext context, String signId) {
    final table = _isVi(context) ? _vietnameseRanges : _englishRanges;
    return table[signId] ?? '';
  }

  static String guidance(BuildContext context, String signId, String fallback) {
    if (!_isVi(context)) return fallback;
    return _vietnameseGuidance[signId] ?? fallback;
  }

  static List<String> essence(BuildContext context, String signId, List<String> fallback) {
    if (!_isVi(context)) return fallback;
    return _vietnameseEssence[signId] ?? fallback;
  }

  static List<String> spiritualFlow(BuildContext context, String signId, List<String> fallback) {
    if (!_isVi(context)) return fallback;
    return _vietnameseSpiritualFlow[signId] ?? fallback;
  }

  static List<String> drawnTo(BuildContext context, String signId, List<String> fallback) {
    if (!_isVi(context)) return fallback;
    return _vietnameseDrawnTo[signId] ?? fallback;
  }

  static List<String> radiatesTo(BuildContext context, String signId, List<String> fallback) {
    if (!_isVi(context)) return fallback;
    return _vietnameseRadiatesTo[signId] ?? fallback;
  }

  static List<String> dharmaPath(BuildContext context, String signId, List<String> fallback) {
    if (!_isVi(context)) return fallback;
    return _vietnameseDharmaPath[signId] ?? fallback;
  }

  static List<String> sacredNeeds(BuildContext context, String signId, List<String> fallback) {
    if (!_isVi(context)) return fallback;
    return _vietnameseSacredNeeds[signId] ?? fallback;
  }
}
