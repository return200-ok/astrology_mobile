class SignGenderAnalysis {
  const SignGenderAnalysis({
    required this.personality,
    required this.inLove,
    required this.career,
    required this.weakness,
  });

  final String personality;
  final String inLove;
  final String career;
  final String weakness;
}

class SignDecan {
  const SignDecan({
    required this.dateRange,
    required this.planetInfluence,
    required this.description,
    required this.strengths,
    required this.weaknesses,
  });

  final String dateRange;
  final String planetInfluence;
  final String description;
  final String strengths;
  final String weaknesses;
}

class SignLayer {
  const SignLayer({
    required this.essence,
    required this.description,
  });

  final String essence;
  final String description;
}

class OracleSign {
  const OracleSign({
    required this.id,
    required this.name,
    required this.symbol,
    required this.dateRange,
    required this.element,
    required this.modality,
    required this.summary,
    required this.male,
    required this.female,
    required this.decan1,
    required this.decan2,
    required this.decan3,
    required this.sunLayer,
    required this.moonLayer,
    required this.risingLayer,
  });

  final String id;
  final String name;
  final String symbol;
  final String dateRange;
  final String element;
  final String modality;
  final String summary;
  final SignGenderAnalysis male;
  final SignGenderAnalysis female;
  final SignDecan decan1;
  final SignDecan decan2;
  final SignDecan decan3;
  final SignLayer sunLayer;
  final SignLayer moonLayer;
  final SignLayer risingLayer;
}

const List<OracleSign> oracleSigns = [

  // ── ARIES ──────────────────────────────────────────────────────────────────
  OracleSign(
    id: 'aries',
    name: 'ARIES',
    symbol: '♈',
    dateRange: '21/3 – 19/4',
    element: 'Lửa',
    modality: 'Thống lĩnh (Cardinal)',
    summary:
        'Cung đầu tiên của hoàng đạo, thuộc nguyên tố Lửa và là cung Thống lĩnh (Cardinal). '
        'Bạch Dương là cung của sự khởi đầu thuần túy — họ không phân tích, họ hành động. '
        'Nguyên mẫu của họ là chiến binh: không phải vì họ thích chiến tranh, '
        'mà vì họ cần một thứ gì đó để vượt qua.',
    male: SignGenderAnalysis(
      personality:
          'Người bảo vệ qua hành động. Họ thể hiện quan tâm bằng cách làm, không bằng cách nói. '
          'Cái tôi mạnh nhưng không hay thể hiện — họ cần được thách thức để cảm thấy sống.',
      inLove:
          'Chinh phục nhiệt tình và bốc đồng, nhưng dễ mất hứng nếu đối phương quá dễ đoán. '
          'Cần người có thể kéo họ trở lại bằng sức hút riêng, không bằng cách van nài.',
      career:
          'Lãnh đạo tự nhiên khi được trao quyền tự chủ. Không hợp với môi trường nhiều tầng cấp '
          'bậc và quy trình. Làm tốt nhất trong vai trò khởi sự dự án.',
      weakness:
          'Bốc đồng, dễ gây xung đột không cần thiết và thiếu khả năng nhìn lại '
          'hậu quả trước khi hành động.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ không chờ đợi sự cho phép. Họ chiếm lĩnh không gian một cách tự nhiên '
          'và trực tiếp — điều này thường bị xã hội gán nhãn sai.',
      inLove:
          'Chủ động và thẳng thắn. Có xu hướng nói thẳng điều mình muốn '
          'và kỳ vọng đối phương cũng giao tiếp cởi mở.',
      career:
          'Tiên phong trong vai trò họ chọn. Không chịu đựng được sự bất công im lặng '
          '— nếu có vấn đề, họ nói.',
      weakness:
          'Dễ bị xem là "quá quyết liệt" và đôi khi bỏ qua những tín hiệu cảm xúc tinh tế '
          'của người khác vì họ xử lý thế giới theo logic hành động.',
    ),
    decan1: SignDecan(
      dateRange: '21/03 – 31/03',
      planetInfluence: 'Sao Hỏa (Mars)',
      description:
          'Bạch Dương thuần khiết nhất. Không có lớp lọc, không có sự pha trộn. '
          'Năng lượng Sao Hỏa biểu hiện trực tiếp nhất ở đây.',
      strengths: 'Quyết đoán, không sợ hãi, khởi đầu mọi thứ với toàn bộ năng lượng.',
      weaknesses: 'Nổi giận nhanh, thiếu kiên nhẫn, hành động trước khi suy nghĩ.',
    ),
    decan2: SignDecan(
      dateRange: '01/04 – 10/04',
      planetInfluence: 'Mặt Trời (Sư Tử)',
      description:
          'Thêm sự tự hào và lòng hào hiệp vào ngọn lửa Bạch Dương. '
          'Năng động, đầy lôi cuốn và có cảm giác thiên mệnh rõ hơn.',
      strengths: 'Lãnh đạo tự nhiên, hào phóng, có sức hút cá nhân mạnh.',
      weaknesses:
          'Kiêu ngạo, khó chấp nhận thất bại trước mặt người khác, '
          'đôi khi diễn hơn là sống thật.',
    ),
    decan3: SignDecan(
      dateRange: '11/04 – 19/04',
      planetInfluence: 'Sao Mộc (Nhân Mã)',
      description:
          'Bạch Dương với tầm nhìn rộng hơn. Năng lượng hành động kết hợp với '
          'khát vọng mở rộng và triết học.',
      strengths: 'Lạc quan, phóng khoáng, nhìn bức tranh lớn hơn hầu hết Bạch Dương khác.',
      weaknesses:
          'Hứa hẹn nhiều hơn khả năng thực hiện, dễ lãng mạn hóa thực tế thay vì đối mặt với nó.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi hành động" — bản thể được định nghĩa bằng việc làm',
      description:
          'Họ tìm thấy bản thân qua thử thách và hành động, không phải qua suy ngẫm. '
          'Khi bị bắt buộc đứng yên quá lâu, họ không chỉ bất an — họ mất cảm giác về bản thân.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc bùng phát nhanh và tắt lẹ',
      description:
          'Cảm xúc của họ không sâu nhưng mãnh liệt. Họ không ủ giận — bùng nổ rồi qua. '
          'Nhưng người xung quanh thì không quên nhanh như vậy.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: năng lượng và sự quyết đoán',
      description:
          'Người ta cảm nhận được họ trước khi nghe họ nói. Dáng vẻ trực tiếp, ánh mắt thẳng thắn. '
          'Ấn tượng đầu tiên luôn là "người này biết mình muốn gì".',
    ),
  ),

  // ── TAURUS ─────────────────────────────────────────────────────────────────
  OracleSign(
    id: 'taurus',
    name: 'TAURUS',
    symbol: '♉',
    dateRange: '20/4 – 20/5',
    element: 'Đất',
    modality: 'Cố định (Fixed)',
    summary:
        'Cung thứ hai của hoàng đạo, thuộc nguyên tố Đất và là cung Cố định (Fixed). '
        'Sau năng lượng khởi đầu của Bạch Dương, Kim Ngưu đến để xây dựng và giữ vững. '
        'Họ là hiện thân của sự bền vững — và cả sự kháng cự thay đổi.',
    male: SignGenderAnalysis(
      personality:
          'Người đàn ông của sự ổn định. Thực tế, đáng tin cậy và xây dựng mọi thứ để trường tồn. '
          'Sức mạnh của họ không ồn ào — nó âm thầm và chắc chắn.',
      inLove:
          'Chậm mở lòng nhưng khi đã cam kết thì trung thành tuyệt đối. '
          'Thể hiện tình cảm qua hành động cụ thể hơn lời nói. '
          'Cần cảm thấy an toàn trước khi thực sự cho người khác vào cuộc sống mình.',
      career:
          'Thường phù hợp với tài chính, bất động sản và bất kỳ lĩnh vực nào cần sự kiên nhẫn dài hạn. '
          'Không hợp với môi trường thay đổi liên tục.',
      weakness:
          'Cứng nhắc, chậm thích nghi và dễ trở nên chiếm hữu khi cảm thấy không an toàn.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ có tiêu chuẩn và biết điều mình xứng đáng. '
          'Họ không thỏa hiệp với sự kém cỏi — trong tình yêu, công việc hay môi trường sống.',
      inLove:
          'Cần sự ổn định và rõ ràng. Họ không hợp với người hay thay đổi và không nhất quán. '
          'Khi đã yêu, họ cho đi nhiều hơn họ biểu lộ.',
      career:
          'Có tài năng trong các lĩnh vực thẩm mỹ, ẩm thực, kinh doanh '
          'và bất kỳ thứ gì cần sự bền bỉ tỉ mỉ.',
      weakness:
          'Dễ bảo thủ, khó tha thứ khi lòng tin bị phá vỡ và đôi khi '
          'cố chấp đến mức bỏ lỡ cơ hội thực sự.',
    ),
    decan1: SignDecan(
      dateRange: '20/04 – 30/04',
      planetInfluence: 'Sao Kim (Venus)',
      description:
          'Kim Ngưu thuần khiết nhất. Tất cả những đặc tính cốt lõi — khoái lạc giác quan, '
          'tình yêu với vẻ đẹp và sự ổn định — đều ở mức độ cao nhất.',
      strengths: 'Đáng tin cậy, thẩm mỹ tinh tế, kiên nhẫn và nhạy cảm với cái đẹp.',
      weaknesses: 'Ì ạch, quá chú trọng vật chất, khó thay đổi dù hoàn cảnh đã thay đổi.',
    ),
    decan2: SignDecan(
      dateRange: '01/05 – 10/05',
      planetInfluence: 'Sao Thủy (Xử Nữ)',
      description:
          'Kim Ngưu với trí óc thực tế hơn. Sự kết hợp giữa bền bỉ của Kim Ngưu '
          'và sự phân tích của Xử Nữ tạo ra người cực kỳ giỏi giải quyết vấn đề thực tế.',
      strengths: 'Phân tích tốt, kỹ lưỡng và đáng tin cậy trong những vấn đề cần chi tiết.',
      weaknesses:
          'Dễ lo lắng thái quá và đôi khi quá chú tâm vào tiểu tiết mà bỏ qua bức tranh lớn.',
    ),
    decan3: SignDecan(
      dateRange: '11/05 – 20/05',
      planetInfluence: 'Sao Thổ (Ma Kết)',
      description:
          'Kim Ngưu có tham vọng nhất. Sự kết hợp giữa bền vững của Kim Ngưu '
          'và kỷ luật của Ma Kết tạo ra người có khả năng xây dựng đế chế.',
      strengths: 'Kỷ luật cao, tham vọng bền bỉ, quản lý tiền bạc và tài nguyên rất tốt.',
      weaknesses:
          'Cứng nhắc, công thức và dễ trở nên lạnh lùng trong các mối quan hệ '
          'vì quá tập trung vào mục tiêu.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi sở hữu" — bản thể được xây dựng qua những gì bền vững',
      description:
          'Kim Ngưu Sun không cần nhiều thứ — nhưng những gì họ có phải thật và phải của họ. '
          'Cảm giác an toàn là nhu cầu cốt lõi, không phải sự tham lam.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc ổn định, sâu và khó lay chuyển',
      description:
          'Họ không bộc phát cảm xúc, nhưng điều đó không có nghĩa là họ không cảm. '
          'Kim Ngưu Moon xử lý cảm xúc trong im lặng và đôi khi quá lâu. '
          'Khi họ đau, họ ăn, ngủ, hoặc làm việc — bất kỳ thứ gì giúp cơ thể ổn định '
          'khi cảm xúc không.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: điềm tĩnh và đáng tin cậy',
      description:
          'Họ tạo ra cảm giác "người này không vội vàng và không dễ bị xáo trộn". '
          'Gặp lần đầu bạn không thấy họ nổi bật, nhưng sau đó bạn nhận ra '
          'họ đã ở đó từ đầu, vững như tường.',
    ),
  ),

  // ── GEMINI ─────────────────────────────────────────────────────────────────
  OracleSign(
    id: 'gemini',
    name: 'GEMINI',
    symbol: '♊',
    dateRange: '21/5 – 20/6',
    element: 'Khí',
    modality: 'Biến đổi (Mutable)',
    summary:
        'Cung thứ ba của hoàng đạo, thuộc nguyên tố Khí và là cung Biến đổi (Mutable). '
        'Song Tử không phải người không nhất quán — họ chỉ thực sự chứa đựng nhiều chiều '
        'khác nhau cùng một lúc. Không phải mâu thuẫn, mà là đa dạng.',
    male: SignGenderAnalysis(
      personality:
          'Người đàn ông với nhiều lớp mặt nạ. Vui vẻ, thông minh và rất dễ nói chuyện '
          '— nhưng bạn không bao giờ chắc mình đang tiếp xúc với lớp nào của họ.',
      inLove:
          'Cần sự kích thích trí tuệ liên tục. Dễ chán nếu mối quan hệ trở nên quá dễ đoán. '
          'Cần người vừa là bạn đồng hành trí tuệ vừa là đối tác.',
      career:
          'Thường phù hợp với truyền thông, viết lách, giảng dạy và bất kỳ lĩnh vực nào '
          'cần xử lý và truyền tải thông tin nhanh.',
      weakness:
          'Thiếu nhất quán, dễ bị phân tâm và đôi khi thao túng bằng ngôn từ '
          'mà không nhận ra.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ thông minh và đa dạng. Họ có thể thích nghi với mọi môi trường '
          'xã hội và thường là người thú vị nhất trong phòng.',
      inLove:
          'Cần người có thể theo kịp tốc độ tư duy của họ. '
          'Họ không tìm người ổn định — họ tìm người không đoán trước được.',
      career:
          'Giỏi trong nhiều lĩnh vực cùng lúc. Thành công nhất khi tìm được môi trường '
          'cho phép họ đa nhiệm và sáng tạo.',
      weakness:
          'Dễ lo lắng quá mức, khó tập trung lâu dài và đôi khi bề nổi trong cảm xúc '
          'vì di chuyển quá nhanh giữa các trạng thái.',
    ),
    decan1: SignDecan(
      dateRange: '21/05 – 31/05',
      planetInfluence: 'Sao Thủy (Mercury)',
      description:
          'Song Tử thuần khiết nhất. Trí tuệ sắc bén, nhanh và linh hoạt ở mức cao nhất.',
      strengths: 'Giao tiếp xuất sắc, tư duy nhanh, thích nghi tốt với mọi hoàn cảnh.',
      weaknesses: 'Thiếu chiều sâu, dễ phân tán và đôi khi nói nhiều hơn lắng nghe.',
    ),
    decan2: SignDecan(
      dateRange: '01/06 – 11/06',
      planetInfluence: 'Sao Kim (Thiên Bình)',
      description:
          'Song Tử với sức hút xã hội cao hơn. Kết hợp giữa trí tuệ và duyên dáng '
          'tạo ra người có khả năng đặc biệt trong các mối quan hệ.',
      strengths: 'Duyên dáng, có tài ngoại giao, dễ tạo thiện cảm ngay lần đầu gặp.',
      weaknesses:
          'Dễ quá cầu toàn về vẻ bề ngoài và đôi khi tránh né xung đột '
          'đến mức mất đi quan điểm thật của mình.',
    ),
    decan3: SignDecan(
      dateRange: '12/06 – 20/06',
      planetInfluence: 'Thiên Vương Tinh (Bảo Bình)',
      description:
          'Song Tử với tư duy độc đáo và tiên phong hơn. '
          'Họ không chỉ xử lý thông tin — họ tạo ra các ý tưởng mới.',
      strengths: 'Sáng tạo, độc đáo, không ngại phá vỡ khuôn mẫu.',
      weaknesses: 'Khó đoán, đôi khi lập dị đến mức khó kết nối với người khác.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi tư duy" — bản thể được định nghĩa qua sự kết nối ý tưởng',
      description:
          'Song Tử Sun sống trong thế giới của ý tưởng và ngôn từ. '
          'Họ không tìm kiếm sự thật — họ tìm kiếm các góc độ mới của sự thật. '
          'Đây là điểm mạnh và cũng là điểm yếu của họ.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc qua lăng kính của ngôn từ',
      description:
          'Song Tử Moon xử lý cảm xúc bằng cách nói về nó, viết về nó hoặc phân tích nó '
          '— không phải bằng cách cảm nhận trực tiếp. Điều này đôi khi khiến họ '
          'xa cách với chính cảm xúc của mình hơn so với những người xung quanh.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: vui vẻ và dễ tiếp cận',
      description:
          'Người gặp Song Tử lần đầu thường nghĩ họ là người cởi mở nhất thế giới. '
          'Đó là sự thật — nhưng chỉ một phần. '
          'Phần còn lại của họ vẫn đứng sau cánh gà và quan sát.',
    ),
  ),

  // ── CANCER ─────────────────────────────────────────────────────────────────
  OracleSign(
    id: 'cancer',
    name: 'CANCER',
    symbol: '♋',
    dateRange: '21/6 – 22/7',
    element: 'Nước',
    modality: 'Thống lĩnh (Cardinal)',
    summary:
        'Cung thứ tư của hoàng đạo, thuộc nguyên tố Nước và là cung Thống lĩnh (Cardinal). '
        'Cự Giải là cung của sự bảo tồn và nuôi dưỡng. Điểm mạnh lớn nhất là sự tận tụy '
        'và trực giác, nhưng điểm yếu lớn nhất là sự bất ổn về tâm trạng và xu hướng '
        'bám víu vào quá khứ. Họ mạnh mẽ nhất khi có một "hậu phương" vững chắc để bảo vệ.',
    male: SignGenderAnalysis(
      personality:
          'Người bảo vệ thầm lặng. Họ có xu hướng che giấu cảm xúc thật sau vẻ ngoài '
          'lạnh lùng hoặc lịch thiệp. Sự quan tâm của họ thể hiện qua hành động, '
          'không phải lời nói.',
      inLove:
          'Thận trọng, thực tế và có xu hướng chiếm hữu cao. '
          'Họ cần sự an toàn tuyệt đối trước khi mở lòng. '
          'Khi đã yêu, họ là người đối tác tận tâm hiếm có.',
      career:
          'Kiên trì, có đầu óc kinh doanh và quản lý tài chính tốt. '
          'Thường chọn con đường an toàn nhưng có nền tảng vững chắc.',
      weakness:
          'Dễ rơi vào trạng thái thụ động-hung hãn (passive-aggressive) khi bị tổn thương '
          'và khó thoát khỏi những nỗi đau trong quá khứ.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người nuôi dưỡng tâm hồn. Sự nhạy cảm thể hiện rõ hơn qua ánh mắt '
          'và hành động chăm sóc người khác. Bản năng bảo vệ của họ rất mạnh.',
      inLove:
          'Lãng mạn, mộng mơ nhưng rất sắc sảo. Có xu hướng quan tâm, chăm sóc '
          'đối phương và đặt cảm giác an toàn cảm xúc lên hàng đầu.',
      career:
          'Sáng tạo, có thiên hướng nghệ thuật hoặc các ngành dịch vụ, '
          'cộng đồng và tâm lý học.',
      weakness:
          'Dễ bi lụy, suy diễn quá mức và khó thoát khỏi những nỗi đau trong quá khứ.',
    ),
    decan1: SignDecan(
      dateRange: '21/06 – 01/07',
      planetInfluence: 'Mặt Trăng (Moon)',
      description:
          'Cự Giải thuần khiết nhất. Họ cực kỳ nhạy cảm, trực giác sắc bén '
          'và tâm trạng biến đổi theo chu kỳ như thủy triều.',
      strengths:
          'Khả năng thấu cảm tuyệt vời, coi trọng các giá trị truyền thống và gia đình.',
      weaknesses:
          'Dễ bị lấn át bởi cảm xúc, thiếu sự quyết đoán khi đứng trước '
          'các lựa chọn đòi hỏi lý trí.',
    ),
    decan2: SignDecan(
      dateRange: '02/07 – 12/07',
      planetInfluence: 'Diêm Vương Tinh (Bọ Cạp)',
      description:
          'Kết hợp giữa sự nhạy cảm của Cự Giải và sự quyết liệt, sâu sắc của Bọ Cạp. '
          'Họ có nội tâm mạnh mẽ và bí ẩn hơn.',
      strengths:
          'Kiên cường, khả năng phục hồi sau tổn thương rất tốt, '
          'tính chiếm hữu và lòng trung thành cực cao.',
      weaknesses:
          'Dễ cực đoan, hay ghen tuông và có xu hướng kiểm soát các mối quan hệ.',
    ),
    decan3: SignDecan(
      dateRange: '13/07 – 22/07',
      planetInfluence: 'Hải Vương Tinh (Song Ngư)',
      description:
          'Những người mộng mơ, có tâm hồn nghệ sĩ và lòng trắc ẩn bao la. '
          'Đây là decan nhạy cảm và sáng tạo nhất của Cự Giải.',
      strengths:
          'Sáng tạo vô hạn, vị tha, thích giúp đỡ người khác mà không cần đền đáp.',
      weaknesses:
          'Dễ xa rời thực tế, hay lý tưởng hóa mọi chuyện và dễ bị lợi dụng '
          'do lòng tốt của mình.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi cảm thấy" — bản thể được định nghĩa qua cảm xúc',
      description:
          'Mục tiêu chính của họ là xây dựng sự an toàn về mặt cảm xúc. '
          'Giống như con cua, họ xây dựng một lớp vỏ cứng cáp để bảo vệ phần mềm yếu bên trong. '
          'Mọi hành động đều xuất phát từ việc bảo vệ những gì họ yêu thương.',
    ),
    moonLayer: SignLayer(
      essence: 'Vị trí đắc địa — cảm xúc ở mức mạnh mẽ nhất',
      description:
          'Mặt Trăng là hành tinh chủ quản của Cự Giải, nên ở vị trí này, cảm xúc đạt mức '
          'mạnh mẽ nhất. Họ có nhu cầu cực lớn về việc được nuôi dưỡng và chăm sóc. '
          'Ký ức đối với họ là kho báu; họ có xu hướng hoài cổ và khó quên '
          'những kỷ niệm cũ — cả vui lẫn buồn.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: ấm áp nhưng dè dặt',
      description:
          'Gương mặt thường tạo cảm giác phúc hậu, dễ gần. '
          'Khi gặp môi trường mới, họ quan sát và thăm dò cảm xúc của người xung quanh '
          'trước khi thực sự bước vào cuộc trò chuyện. '
          'Họ thường bị nhầm là nhút nhát, nhưng thực chất đó là cơ chế tự vệ tự nhiên.',
    ),
  ),

  // ── LEO ────────────────────────────────────────────────────────────────────
  OracleSign(
    id: 'leo',
    name: 'LEO',
    symbol: '♌',
    dateRange: '23/7 – 22/8',
    element: 'Lửa',
    modality: 'Cố định (Fixed)',
    summary:
        'Cung thứ năm của hoàng đạo, thuộc nguyên tố Lửa và là cung Cố định (Fixed). '
        'Sư Tử không chỉ muốn được nhìn nhận — họ cần điều đó như cơ thể cần ánh sáng mặt trời. '
        'Không phải vì sự nông cạn, mà vì đó là cách họ biết mình đang tồn tại.',
    male: SignGenderAnalysis(
      personality:
          'Người đàn ông với sự hiện diện không thể bỏ qua. Hào phóng, ấm áp và có sức lôi cuốn '
          'tự nhiên — miễn là họ đang ở trung tâm của sự chú ý.',
      inLove:
          'Tặng quà hào phóng, tôn thờ người yêu — nhưng kỳ vọng tôn thờ lại tương đương. '
          'Cần đối tác ngưỡng mộ họ mà không bị đắm chìm trong họ.',
      career:
          'Lãnh đạo tự nhiên. Thường tiến lên đỉnh không phải vì khả năng quản lý '
          'mà vì khả năng truyền cảm hứng và trình diễn.',
      weakness:
          'Cái tôi dễ bị tổn thương, khó chấp nhận thất bại trước công chúng '
          'và đôi khi tạo ra drama không cần thiết để lấy lại sự chú ý.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ biết sức mạnh của mình và không ngại sử dụng. '
          'Họ thu hút sự chú ý không phải vì cố gắng — mà vì đó là trạng thái tự nhiên của họ.',
      inLove:
          'Cần người tôn trọng cái tôi của họ, không cố gắng làm mờ họ. '
          'Trung thành và bảo vệ đối tác hết mình, nhưng không dung thứ sự coi thường.',
      career:
          'Thường phù hợp với nghệ thuật, diễn xuất, lãnh đạo, giáo dục '
          'và bất kỳ vai trò nào cần sức hút cá nhân.',
      weakness:
          'Dễ bị tổn thương bởi sự phê bình và đôi khi phóng đại cảm xúc để được chú ý.',
    ),
    decan1: SignDecan(
      dateRange: '23/07 – 02/08',
      planetInfluence: 'Mặt Trời (Sun)',
      description:
          'Sư Tử thuần khiết nhất. Tất cả đặc tính của Sư Tử đều ở mức độ nguyên bản '
          'và mạnh mẽ nhất.',
      strengths: 'Lôi cuốn, hào phóng, lãnh đạo tự nhiên và đầy sức sống.',
      weaknesses: 'Cái tôi cực kỳ nhạy cảm, khó chia sẻ ánh hào quang với người khác.',
    ),
    decan2: SignDecan(
      dateRange: '03/08 – 12/08',
      planetInfluence: 'Sao Mộc (Nhân Mã)',
      description:
          'Sư Tử với tầm nhìn và lý tưởng cao hơn. Kết hợp giữa sự hào phóng của Sư Tử '
          'và tầm nhìn của Nhân Mã tạo ra người lãnh đạo có tư tưởng.',
      strengths:
          'Lý tưởng cao, truyền cảm hứng mạnh mẽ, hào phóng và sẵn lòng đứng về phía yếu thế.',
      weaknesses:
          'Dễ thuyết phục bản thân rằng ý chí của mình là điều tốt cho người khác, '
          'dù người khác không đồng ý.',
    ),
    decan3: SignDecan(
      dateRange: '13/08 – 22/08',
      planetInfluence: 'Sao Hỏa (Bạch Dương)',
      description:
          'Sư Tử mạnh mẽ và quyết liệt nhất. Thêm năng lượng chiến đấu của Bạch Dương '
          'vào sự hào phóng của Sư Tử.',
      strengths: 'Dũng cảm, quyết đoán, không sợ đối mặt với thử thách trực tiếp.',
      weaknesses:
          'Dễ nóng tính, đôi khi hung hãn và khó chịu khi bị thách thức công khai.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi tỏa sáng" — bản thể được thể hiện qua sự sáng tạo và lãnh đạo',
      description:
          'Sư Tử Sun không cần phải tìm kiếm vị trí trung tâm — họ tạo ra nó '
          'bất cứ đâu họ xuất hiện. Vấn đề là khi không có ai ở đó để chứng kiến, '
          'họ bắt đầu nghi ngờ về giá trị của chính mình.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc mãnh liệt, nhu cầu được công nhận sâu sắc',
      description:
          'Sư Tử Moon không chỉ muốn được yêu — họ muốn bạn nói ra điều đó, '
          'nhiều lần, theo những cách khác nhau. '
          'Đây không phải bất an — đó là ngôn ngữ tình yêu của họ.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: sự hiện diện không thể phớt lờ',
      description:
          'Họ vào phòng và mọi người biết. Không phải vì ồn ào — mà vì có gì đó trong '
          'cách họ chiếm không gian khiến mắt người khác tự nhiên hướng về phía họ.',
    ),
  ),

  // ── VIRGO ──────────────────────────────────────────────────────────────────
  OracleSign(
    id: 'virgo',
    name: 'VIRGO',
    symbol: '♍',
    dateRange: '23/8 – 22/9',
    element: 'Đất',
    modality: 'Biến đổi (Mutable)',
    summary:
        'Cung thứ sáu của hoàng đạo, thuộc nguyên tố Đất và là cung Biến đổi (Mutable). '
        'Xử Nữ không hoàn hảo vì muốn hơn người — họ hoàn hảo vì không thể chịu đựng '
        'sự bất cẩn. Đằng sau sự tỉ mỉ của họ là một trí óc đang liên tục cải thiện '
        'mọi thứ có thể được cải thiện.',
    male: SignGenderAnalysis(
      personality:
          'Người đàn ông chú trọng chi tiết và thực tế. Họ không phô trương nhưng '
          'thầm lặng giải quyết mọi thứ trước khi ai kịp nhận ra có vấn đề.',
      inLove:
          'Thể hiện tình cảm qua việc làm — sửa cái gì đó hỏng, nhớ ngày quan trọng của bạn, '
          'chuẩn bị mọi thứ trước khi bạn cần. Đây là ngôn ngữ tình yêu của họ.',
      career:
          'Thường phù hợp với y tế, phân tích, kế toán, nghiên cứu '
          'và bất kỳ lĩnh vực nào cần sự chính xác.',
      weakness:
          'Hay phê bình, cầu toàn đến mức tê liệt và đôi khi khó chịu '
          'về sự bừa bộn của người khác.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ với chuẩn mực cao và trí tuệ sắc bén. '
          'Họ không bao giờ làm việc qua loa và kỳ vọng điều tương tự từ người xung quanh.',
      inLove:
          'Không dễ mở lòng vì họ phân tích rủi ro quá kỹ. Nhưng khi đã yêu, '
          'họ tận tâm theo cách hiếm có — chú ý từng chi tiết nhỏ về người họ yêu.',
      career:
          'Người thực thi và cải thiện hệ thống. '
          'Thường trở thành người không thể thiếu trong bất kỳ tổ chức nào.',
      weakness:
          'Dễ lo lắng quá mức, tự phê bình và đôi khi quá khắt khe với bản thân '
          'đến mức không thể nhận ra thành tích của chính mình.',
    ),
    decan1: SignDecan(
      dateRange: '23/08 – 02/09',
      planetInfluence: 'Sao Thủy (Mercury)',
      description:
          'Xử Nữ thuần khiết nhất. Tư duy phân tích và kỹ năng ngôn ngữ ở mức đỉnh cao.',
      strengths: 'Chính xác, tư duy sắc bén, kỹ năng giao tiếp và viết tốt.',
      weaknesses:
          'Dễ lo lắng, suy nghĩ quá nhiều và đôi khi bị mắc kẹt trong '
          'vòng phân tích không hồi kết.',
    ),
    decan2: SignDecan(
      dateRange: '03/09 – 12/09',
      planetInfluence: 'Sao Thổ (Ma Kết)',
      description:
          'Xử Nữ với kỷ luật và tham vọng cao hơn. Kết hợp giữa sự tỉ mỉ của Xử Nữ '
          'và kỷ luật của Ma Kết tạo ra người hiếm có về khả năng thực thi.',
      strengths: 'Kỷ luật cao, đáng tin cậy, xây dựng nền tảng vững chắc cho mọi thứ họ làm.',
      weaknesses:
          'Quá nghiêm khắc, khó buông bỏ và đôi khi hy sinh niềm vui '
          'vì quá chú trọng trách nhiệm.',
    ),
    decan3: SignDecan(
      dateRange: '13/09 – 22/09',
      planetInfluence: 'Sao Kim (Kim Ngưu)',
      description:
          'Xử Nữ với cảm xúc và thẩm mỹ cao hơn. Kết hợp giữa sự phân tích của Xử Nữ '
          'và cái đẹp của Kim Ngưu tạo ra người có năng khiếu đặc biệt trong '
          'các lĩnh vực kết hợp kỹ thuật và nghệ thuật.',
      strengths:
          'Có thẩm mỹ, tỉ mỉ trong chi tiết và biết cách tạo ra cái đẹp có chức năng.',
      weaknesses:
          'Dễ chủ nghĩa hoàn hảo, khó ra mắt sản phẩm vì luôn muốn thêm '
          'một lần chỉnh sửa nữa.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi phân tích" — bản thể được định nghĩa qua sự cải thiện',
      description:
          'Xử Nữ Sun không tìm kiếm sự hoàn hảo vì muốn hơn người — họ tìm kiếm nó '
          'vì bất kỳ thứ gì kém hơn đều cảm thấy như đang lãng phí tiềm năng. '
          'Đây là sức mạnh lớn nhất và cũng là nguồn gốc của sự kiệt sức của họ.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc qua lăng kính lo lắng và phân tích',
      description:
          'Xử Nữ Moon không dễ bày tỏ cảm xúc trực tiếp. Thay vào đó, họ thể hiện '
          'quan tâm bằng cách hỏi "bạn đã ăn chưa?" hay sắp xếp lại ngăn kéo của bạn. '
          'Phân tích là cách họ kiểm soát điều mà cảm xúc không thể kiểm soát được.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: điềm đạm và quan sát',
      description:
          'Xử Nữ Rising thường bị hiểu lầm là lạnh lùng hoặc xa cách. '
          'Thực ra, họ đang quan sát và đánh giá tình huống — '
          'một khi họ thấy an toàn, họ trở nên cởi mở hơn bạn tưởng.',
    ),
  ),

  // ── LIBRA ──────────────────────────────────────────────────────────────────
  OracleSign(
    id: 'libra',
    name: 'LIBRA',
    symbol: '♎',
    dateRange: '23/9 – 22/10',
    element: 'Khí',
    modality: 'Thống lĩnh (Cardinal)',
    summary:
        'Cung thứ bảy của hoàng đạo, thuộc nguyên tố Khí và là cung Thống lĩnh (Cardinal). '
        'Điều thú vị là cung "cân bằng" nhất lại thường là người đang tìm kiếm cân bằng '
        '— không phải người đã có nó. Thiên Bình tìm thấy bản thân qua mối quan hệ '
        'với người khác.',
    male: SignGenderAnalysis(
      personality:
          'Người đàn ông duyên dáng, biết cách làm người khác cảm thấy thoải mái. '
          'Họ không ồn ào — họ tinh tế và luôn biết nói điều đúng lúc đúng chỗ.',
      inLove:
          'Lãng mạn và chú trọng thẩm mỹ trong mọi thứ. Nhưng khó ra quyết định '
          'và đôi khi giữ hai chân trong hai tình huống quá lâu.',
      career:
          'Thường phù hợp với luật, nghệ thuật, thiết kế, ngoại giao '
          'và bất kỳ lĩnh vực nào cần sự cân bằng và giao tiếp.',
      weakness:
          'Thiếu quyết đoán, dễ thay đổi lập trường theo người đang nói chuyện '
          'và đôi khi né tránh xung đột đến mức tích lũy ẩn ức.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ với khiếu thẩm mỹ tinh tế và khả năng kết nối người với người '
          'đặc biệt. Họ tạo ra không khí dễ chịu ở bất cứ đâu họ xuất hiện.',
      inLove:
          'Coi trọng sự đối xứng trong mối quan hệ — khi cho nhiều, mong muốn nhận lại '
          'tương đương. Cần lưu ý giữ vững bản sắc cá nhân thay vì cố làm hài lòng quá mức.',
      career:
          'Có tài trong việc xây dựng mạng lưới, hòa giải '
          'và làm việc trong môi trường sáng tạo hoặc pháp lý.',
      weakness:
          'Dễ bị ảnh hưởng bởi ý kiến của người khác, khó giữ vững lập trường '
          'và đôi khi tự xóa mờ bản thân.',
    ),
    decan1: SignDecan(
      dateRange: '23/09 – 03/10',
      planetInfluence: 'Sao Kim (Venus)',
      description:
          'Thiên Bình thuần khiết nhất. Tình yêu với vẻ đẹp, sự hài hòa '
          'và các mối quan hệ ở mức đỉnh cao.',
      strengths: 'Duyên dáng, thẩm mỹ cao, tài giao tiếp và tạo thiện cảm.',
      weaknesses: 'Dễ phụ thuộc vào mối quan hệ, khó tự quyết định khi không có ai xác nhận.',
    ),
    decan2: SignDecan(
      dateRange: '04/10 – 13/10',
      planetInfluence: 'Thiên Vương Tinh (Bảo Bình)',
      description:
          'Thiên Bình với trí tuệ độc lập hơn. Kết hợp giữa sự cân bằng của Thiên Bình '
          'và tư duy độc lập của Bảo Bình tạo ra người có quan điểm riêng hơn.',
      strengths:
          'Tư duy độc lập, có tầm nhìn xã hội, không ngại đứng về phía quan điểm '
          'không phổ biến nếu nó công bằng.',
      weaknesses:
          'Đôi khi lạnh lùng về mặt cảm xúc và khó kết nối cá nhân sâu sắc.',
    ),
    decan3: SignDecan(
      dateRange: '14/10 – 22/10',
      planetInfluence: 'Sao Thủy (Song Tử)',
      description:
          'Thiên Bình với khả năng giao tiếp sắc bén nhất. '
          'Kết hợp giữa sự ngoại giao của Thiên Bình và trí tuệ ngôn ngữ của Song Tử.',
      strengths: 'Nói và viết đặc biệt tốt, thuyết phục giỏi, lý luận sắc bén.',
      weaknesses:
          'Dễ dùng ngôn từ để né tránh cảm xúc thật và đôi khi lý luận thay vì cảm nhận.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi cân bằng" — bản thể được định nghĩa qua mối quan hệ',
      description:
          'Thiên Bình Sun tìm thấy bản thân qua việc phản chiếu qua người khác. '
          'Đây không phải yếu đuối — đây là cách họ hiểu thế giới. '
          'Vấn đề là họ đôi khi mất đi bản thân trong quá trình phản chiếu.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc cần sự cân bằng và hài hòa',
      description:
          'Thiên Bình Moon không thể thoải mái trong môi trường đầy xung đột. '
          'Họ không trốn tránh vấn đề — họ muốn giải quyết nó một cách đẹp đẽ. '
          'Khi không thể, họ bị căng thẳng theo cách mà người ngoài không nhận ra.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: duyên dáng và khó chối từ',
      description:
          'Thiên Bình Rising tạo ấn tượng đầu tiên xuất sắc nhất trong 12 cung. '
          'Họ biết cách làm người đối diện cảm thấy được chú ý và đánh giá cao. '
          'Vấn đề là ấn tượng đó dễ chịu đến mức người khác cảm thấy thân thiết '
          'hơn mức Thiên Bình thực sự muốn.',
    ),
  ),

  // ── SCORPIO ────────────────────────────────────────────────────────────────
  OracleSign(
    id: 'scorpio',
    name: 'SCORPIO',
    symbol: '♏',
    dateRange: '23/10 – 21/11',
    element: 'Nước',
    modality: 'Cố định (Fixed)',
    summary:
        'Cung thứ tám của hoàng đạo, thuộc nguyên tố Nước và là cung Cố định (Fixed). '
        'Bọ Cạp là cung bị hiểu lầm nhiều nhất. Không phải vì họ bí ẩn cố tình — mà vì '
        'chiều sâu thực sự của họ rất khó diễn đạt bằng ngôn ngữ thông thường.',
    male: SignGenderAnalysis(
      personality:
          'Người đàn ông với sức hút khó giải thích. Họ không nhiều lời nhưng khi họ nói, '
          'người ta lắng nghe. Bề ngoài kiểm soát, bên trong mãnh liệt đến mức đáng sợ.',
      inLove:
          'Tất cả hoặc không có gì. Không có khái niệm "chỉ bạn bè" hay "tình cảm nhẹ". '
          'Khi yêu, họ đặt cược toàn bộ — và kỳ vọng đối phương làm điều tương tự.',
      career:
          'Thường phù hợp với nghiên cứu, điều tra, tài chính, tâm lý học '
          'và bất kỳ lĩnh vực nào cần đào sâu vào bề mặt.',
      weakness:
          'Ghen tuông, chiếm hữu và dễ trở nên hả hê khi trả thù '
          '— điều mà họ thường hối tiếc về sau.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ không phải kiểu người ai cũng hiểu — và họ không cần điều đó. '
          'Họ chọn ai có thể chịu đựng được chiều sâu của mình, không phải ai tiện nhất.',
      inLove:
          'Cần thời gian để xây dựng niềm tin trước khi thực sự mở lòng. Coi trọng '
          'chiều sâu cảm xúc và mong muốn đối phương đồng hành ở mức độ tương xứng.',
      career:
          'Giỏi trong các vị trí đòi hỏi sức chịu đựng tâm lý cao, '
          'khả năng đọc người và quyết định trong tình huống áp lực.',
      weakness:
          'Dễ mang theo hận thù quá lâu và đôi khi tạo ra kịch bản phức tạp '
          'không cần thiết trong mối quan hệ.',
    ),
    decan1: SignDecan(
      dateRange: '23/10 – 02/11',
      planetInfluence: 'Diêm Vương Tinh / Sao Hỏa (Pluto/Mars)',
      description:
          'Bọ Cạp thuần khiết nhất. Cường độ, chiều sâu và khả năng biến đổi '
          'ở mức cao nhất.',
      strengths: 'Ý chí sắt đá, không sợ đối mặt với bóng tối, khả năng phục hồi phi thường.',
      weaknesses:
          'Dễ cực đoan, khó buông bỏ và đôi khi biến đau khổ thành bản sắc.',
    ),
    decan2: SignDecan(
      dateRange: '03/11 – 12/11',
      planetInfluence: 'Hải Vương Tinh / Sao Mộc (Song Ngư)',
      description:
          'Bọ Cạp với lòng trắc ẩn và tâm linh sâu hơn. '
          'Kết hợp giữa chiều sâu của Bọ Cạp và trực giác của Song Ngư.',
      strengths: 'Thấu cảm sâu sắc, trực giác mạnh mẽ, có khả năng chữa lành người khác.',
      weaknesses:
          'Dễ hấp thụ năng lượng tiêu cực của người xung quanh và đôi khi '
          'không phân biệt được đau của mình và đau của người khác.',
    ),
    decan3: SignDecan(
      dateRange: '13/11 – 21/11',
      planetInfluence: 'Mặt Trăng (Cự Giải)',
      description:
          'Bọ Cạp với cảm xúc gia đình và ký ức sâu hơn. '
          'Thêm chiều hướng bảo vệ và nuôi dưỡng vào sức mạnh của Bọ Cạp.',
      strengths:
          'Trung thành tuyệt đối, bảo vệ mạnh mẽ những người thân, '
          'có trí nhớ cảm xúc phi thường.',
      weaknesses:
          'Khó tha thứ những tổn thương trong quá khứ, và đôi khi '
          'kéo theo những nỗi đau cũ vào các mối quan hệ mới.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi biến đổi" — bản thể được định nghĩa qua sự chết và tái sinh',
      description:
          'Bọ Cạp Sun sống qua nhiều "cuộc đời" trong một đời người. '
          'Mỗi lần mất mát lớn không phá hủy họ — nó thay đổi họ. '
          'Nhưng họ không bao giờ trở về trạng thái cũ, '
          'và đó là điều người ngoài thường không hiểu.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc như nham thạch — yên lặng nhưng sôi sục bên trong',
      description:
          'Bọ Cạp Moon kiểm soát bề mặt hoàn toàn — nhưng bên dưới là một thế giới cảm xúc '
          'mà ngay cả họ cũng không lúc nào hiểu hết. '
          'Họ không cho thấy cảm xúc cho đến khi quá muộn.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: sức hút khó giải thích và ánh mắt xuyên thấu',
      description:
          'Bọ Cạp Rising khiến người khác cảm thấy như đang được nhìn thấu qua. '
          'Ánh mắt của họ có chiều sâu hiếm gặp và ít người thực sự thoải mái '
          'dưới cái nhìn đó — dù họ không làm gì có hại.',
    ),
  ),

  // ── SAGITTARIUS ────────────────────────────────────────────────────────────
  OracleSign(
    id: 'sagittarius',
    name: 'SAGITTARIUS',
    symbol: '♐',
    dateRange: '22/11 – 21/12',
    element: 'Lửa',
    modality: 'Biến đổi (Mutable)',
    summary:
        'Cung thứ chín của hoàng đạo, thuộc nguyên tố Lửa và là cung Biến đổi (Mutable). '
        'Nhân Mã là cung của sự tìm kiếm ý nghĩa. Không phải du lịch hay tự do theo '
        'nghĩa thông thường — mà là khát khao liên tục tìm hiểu tại sao mọi thứ tồn tại.',
    male: SignGenderAnalysis(
      personality:
          'Người đàn ông của những ý tưởng lớn và chuyến đi xa. Nhiệt tình, thẳng thắn '
          'đến mức đôi khi thiếu tế nhị và không thể ở yên khi có điều gì thú vị hơn ở chỗ khác.',
      inLove:
          'Cần tự do trong mối quan hệ — không phải quyền đi chơi với người khác, '
          'mà là tự do về mặt tinh thần. Cần người có thể phát triển cùng họ.',
      career:
          'Thường phù hợp với giáo dục đại học, xuất bản, triết học, du lịch '
          'và bất kỳ lĩnh vực nào cần tầm nhìn và sự nhiệt tình.',
      weakness:
          'Không thực tế, thường xuyên bắt đầu nhiều hơn kết thúc '
          'và dễ nói thật theo cách làm đau người khác.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ không chịu bị giới hạn bởi kỳ vọng. '
          'Họ có quan điểm riêng về mọi thứ và không ngại bày tỏ.',
      inLove:
          'Không tìm người kiểm soát — tìm đồng hành. '
          'Họ cần ai đó có thể sánh bước cùng họ, không phải ai đang cố gắng dừng họ lại.',
      career:
          'Làm tốt nhất khi được tự do về tư duy và không bị giới hạn bởi quy trình. '
          'Thường thành công trong vai trò tiên phong hoặc người có tầm ảnh hưởng.',
      weakness:
          'Dễ lý tưởng hóa, hay hứa hẹn nhiều và đôi khi thiếu tính nhất quán '
          'về mặt cảm xúc trong mối quan hệ.',
    ),
    decan1: SignDecan(
      dateRange: '22/11 – 01/12',
      planetInfluence: 'Sao Mộc (Jupiter)',
      description:
          'Nhân Mã thuần khiết nhất. Sự lạc quan, tầm nhìn và khát vọng phát triển '
          'ở mức nguyên bản nhất.',
      strengths:
          'Lạc quan bẩm sinh, bao dung, tầm nhìn xa và khuyến khích người khác phát triển.',
      weaknesses:
          'Không thực tế, thiếu chú ý đến chi tiết và hay thổi phồng khả năng của bản thân.',
    ),
    decan2: SignDecan(
      dateRange: '02/12 – 11/12',
      planetInfluence: 'Sao Hỏa (Bạch Dương)',
      description:
          'Nhân Mã quyết liệt và hành động hơn. '
          'Kết hợp giữa tầm nhìn của Nhân Mã và năng lượng của Bạch Dương.',
      strengths: 'Dũng cảm, hành động quyết đoán, không ngại đặt cược vào tầm nhìn của mình.',
      weaknesses:
          'Bốc đồng, thiếu kiên nhẫn và dễ đốt cầu trong quá trình theo đuổi ý tưởng tiếp theo.',
    ),
    decan3: SignDecan(
      dateRange: '12/12 – 21/12',
      planetInfluence: 'Mặt Trời (Sư Tử)',
      description:
          'Nhân Mã với sức hút lãnh đạo và tầm nhìn lớn hơn. '
          'Kết hợp giữa triết học của Nhân Mã và sự lôi cuốn của Sư Tử.',
      strengths:
          'Truyền cảm hứng mạnh mẽ, lãnh đạo tư tưởng, '
          'có khả năng kéo người khác theo tầm nhìn của mình.',
      weaknesses:
          'Dễ trở nên thuyết giáo và khó chấp nhận rằng người khác '
          'có thể không chia sẻ sự hứng khởi của họ.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi nhìn xa" — bản thể được định nghĩa qua sự tìm kiếm ý nghĩa',
      description:
          'Nhân Mã Sun không thể sống trong một thế giới không có "tại sao". '
          'Khi không còn gì để tìm hiểu, họ không chỉ chán — '
          'họ cảm thấy như đang mất đi lý do tồn tại.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc cần tự do và không gian',
      description:
          'Nhân Mã Moon dễ choáng ngợp khi bị giam hãm trong cảm xúc nặng nề quá lâu. '
          'Họ xử lý cảm xúc bằng cách di chuyển — theo nghĩa đen và theo nghĩa bóng. '
          'Đứng yên trong nỗi đau không phải là phong cách của họ.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: nhiệt tình và rộng mở',
      description:
          'Nhân Mã Rising tạo cảm giác như gặp một người bạn cũ ngay lần đầu gặp. '
          'Họ dễ tiếp cận, vui vẻ và làm không khí trở nên nhẹ nhàng hơn. '
          'Nhưng đừng nhầm sự dễ tính bề ngoài đó với khả năng cam kết sâu sắc.',
    ),
  ),

  // ── CAPRICORN ──────────────────────────────────────────────────────────────
  OracleSign(
    id: 'capricorn',
    name: 'CAPRICORN',
    symbol: '♑',
    dateRange: '22/12 – 19/1',
    element: 'Đất',
    modality: 'Thống lĩnh (Cardinal)',
    summary:
        'Cung thứ mười của hoàng đạo, thuộc nguyên tố Đất và là cung Thống lĩnh (Cardinal). '
        'Ma Kết không chỉ muốn thành công — họ muốn xây dựng thứ gì đó còn lại sau khi họ ra đi. '
        'Đây là cung của kỷ luật và di sản.',
    male: SignGenderAnalysis(
      personality:
          'Người đàn ông của sự kiên định và tham vọng. Họ không nói nhiều về kế hoạch — '
          'họ thực hiện. Bề ngoài lạnh lùng nhưng bên trong là người đang gánh '
          'nhiều trách nhiệm hơn bất kỳ ai biết.',
      inLove:
          'Không dễ mở lòng. Họ cần thấy bạn là người đáng tin cậy lâu dài '
          'trước khi đặt cảm xúc vào. Nhưng khi đã cam kết, họ là đối tác thực sự.',
      career:
          'Có xu hướng thiên về vai trò lãnh đạo và quản lý. Thường phù hợp với kinh doanh, tài chính, '
          'chính trị và bất kỳ lĩnh vực nào cần tầm nhìn dài hạn.',
      weakness:
          'Dễ trở nên lạnh lùng cảm xúc khi quá tập trung vào mục tiêu, '
          'khó cân bằng giữa công việc và cuộc sống cá nhân.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ không cần ai xác nhận giá trị của mình. '
          'Họ tự xây dựng và tự biết mình đang đứng ở đâu.',
      inLove:
          'Thực tế và có cấu trúc ngay trong tình cảm. Họ không giỏi biểu lộ cảm xúc '
          'nhưng thể hiện tình yêu qua sự ổn định và hành động.',
      career:
          'Người leo núi bền bỉ nhất hoàng đạo. Họ không vội vàng — '
          'họ biết mình sẽ đến đỉnh vào đúng thời điểm của mình.',
      weakness:
          'Dễ quá khắt khe với bản thân, khó thư giãn và đôi khi không nhận ra '
          'khi nào nên dừng để tận hưởng những gì đã xây dựng.',
    ),
    decan1: SignDecan(
      dateRange: '22/12 – 31/12',
      planetInfluence: 'Sao Thổ (Saturn)',
      description:
          'Ma Kết thuần khiết nhất. Kỷ luật, tham vọng và cảm giác trách nhiệm '
          'ở mức nguyên bản.',
      strengths: 'Kỷ luật sắt, tham vọng bền vững, khả năng chịu đựng gian khổ phi thường.',
      weaknesses:
          'Cứng nhắc, lạnh lùng về mặt cảm xúc và đôi khi quá khắt khe '
          'với cả bản thân lẫn người khác.',
    ),
    decan2: SignDecan(
      dateRange: '01/01 – 10/01',
      planetInfluence: 'Sao Kim (Kim Ngưu)',
      description:
          'Ma Kết với giá trị và thẩm mỹ rõ hơn. Kết hợp giữa kỷ luật của Ma Kết '
          'và tình yêu với sự dư dả của Kim Ngưu.',
      strengths:
          'Biết thưởng thức thành quả, có thẩm mỹ tốt '
          'và xây dựng cuộc sống vừa vững chắc vừa đẹp.',
      weaknesses:
          'Dễ trở nên vật chất và đo lường thành công quá nhiều bằng tiêu chí bên ngoài.',
    ),
    decan3: SignDecan(
      dateRange: '11/01 – 19/01',
      planetInfluence: 'Sao Thủy (Xử Nữ)',
      description:
          'Ma Kết với trí óc phân tích sắc bén hơn. '
          'Kết hợp giữa tham vọng của Ma Kết và sự tỉ mỉ của Xử Nữ.',
      strengths: 'Phân tích xuất sắc, chính xác trong kế hoạch, biết cách tối ưu hóa từng bước.',
      weaknesses:
          'Dễ bị mắc kẹt trong chi tiết đến mức chậm ra quyết định lớn, '
          'đôi khi lo lắng thái quá.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi sử dụng" — bản thể được định nghĩa qua công trình để lại',
      description:
          'Ma Kết Sun không sống cho hiện tại — họ sống cho di sản. '
          'Mỗi quyết định đều đặt trong bối cảnh "điều này sẽ dẫn đến đâu trong 10 năm tới?" '
          'Điều này cho họ sức mạnh phi thường — và đôi khi cướp đi niềm vui hiện tại.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc kiểm soát và che giấu',
      description:
          'Ma Kết Moon hiếm khi để người khác thấy họ đang không ổn. '
          'Đây không phải sức mạnh — đây là thói quen tự vệ được xây dựng từ rất sớm. '
          'Họ thường cần ai đó đủ kiên nhẫn để ở lại đủ lâu để thấy lớp bên trong.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: nghiêm túc và đáng tin cậy',
      description:
          'Ma Kết Rising trông già dặn hơn tuổi thật. '
          'Họ tạo cảm giác "người này biết cách thực hiện mọi thứ" ngay từ đầu. '
          'Điều thú vị là họ càng lớn tuổi thì lại càng trở nên nhẹ nhàng hơn '
          '— như thể họ và thời gian đang đi ngược chiều nhau.',
    ),
  ),

  // ── AQUARIUS ───────────────────────────────────────────────────────────────
  OracleSign(
    id: 'aquarius',
    name: 'AQUARIUS',
    symbol: '♒',
    dateRange: '20/1 – 18/2',
    element: 'Khí',
    modality: 'Cố định (Fixed)',
    summary:
        'Cung thứ mười một của hoàng đạo, thuộc nguyên tố Khí và là cung Cố định (Fixed). '
        'Bảo Bình bị hiểu lầm theo hướng ngược — người ta nghĩ họ lạnh lùng vì họ ít biểu cảm, '
        'nhưng thực ra họ quan tâm đến nhân loại theo cách mà hầu hết mọi người '
        'không thể tiếp cận được.',
    male: SignGenderAnalysis(
      personality:
          'Người đàn ông của những ý tưởng đột phá. '
          'Họ không quan tâm đến việc làm hài lòng đám đông — '
          'họ quan tâm đến việc làm đám đông tiến hóa.',
      inLove:
          'Cần không gian cá nhân và không chịu được sự sở hữu. '
          'Yêu theo cách của riêng họ, thường khác với những gì người yêu kỳ vọng. '
          'Cần người yêu họ vì tư duy của họ, không phải dù tư duy của họ.',
      career:
          'Thường phù hợp với công nghệ, khoa học, hoạt động xã hội '
          'và bất kỳ lĩnh vực nào cần tư duy đột phá.',
      weakness:
          'Dễ trở nên xa cách cảm xúc, khó tiếp cận trong các mối quan hệ cá nhân '
          'và đôi khi cứng đầu về quan điểm đến mức không tiếp thu phản hồi.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ không cần được phê duyệt và không sợ trở nên khác biệt. '
          'Họ thường là người đi trước thời đại trong tư duy.',
      inLove:
          'Tìm người đồng hành tư tưởng hơn là người che chở. '
          'Họ cần tự do tinh thần và không thể ở trong mối quan hệ kiểm soát.',
      career:
          'Người thay đổi thế giới. Làm tốt nhất trong môi trường cho phép '
          'họ đặt câu hỏi về mọi giả định hiện hữu.',
      weakness:
          'Dễ sống quá trong đầu và đôi khi thiếu kết nối với '
          'thực tế cảm xúc của người xung quanh.',
    ),
    decan1: SignDecan(
      dateRange: '20/01 – 29/01',
      planetInfluence: 'Thiên Vương Tinh / Sao Thổ (Uranus/Saturn)',
      description:
          'Bảo Bình thuần khiết nhất. Sự độc lập, tư duy đột phá '
          'và cảm giác thiên mệnh tập thể ở mức nguyên bản.',
      strengths:
          'Tư duy độc lập, không ngại phá vỡ khuôn mẫu, có tầm nhìn xa về xã hội.',
      weaknesses:
          'Cứng đầu về quan điểm, khó thay đổi dù bằng chứng trái chiều, '
          'đôi khi quá tách biệt khỏi thực tế cảm xúc.',
    ),
    decan2: SignDecan(
      dateRange: '30/01 – 08/02',
      planetInfluence: 'Sao Thủy (Song Tử)',
      description:
          'Bảo Bình với khả năng giao tiếp ý tưởng xuất sắc hơn. '
          'Kết hợp giữa tầm nhìn của Bảo Bình và sự linh hoạt ngôn từ của Song Tử.',
      strengths:
          'Giỏi truyền đạt ý tưởng phức tạp, dễ kết nối với nhiều người '
          'ở nhiều tầng khác nhau.',
      weaknesses: 'Dễ nói nhiều hơn làm và đôi khi ý tưởng hay hơn việc thực thi.',
    ),
    decan3: SignDecan(
      dateRange: '09/02 – 18/02',
      planetInfluence: 'Sao Kim (Thiên Bình)',
      description:
          'Bảo Bình với sự quan tâm đến công lý và hài hòa hơn. '
          'Kết hợp giữa tầm nhìn xã hội của Bảo Bình và tình yêu với công bằng của Thiên Bình.',
      strengths:
          'Nhân đạo, công bằng và biết cách xây dựng liên minh vì những mục tiêu lớn hơn.',
      weaknesses:
          'Dễ lý tưởng hóa các mối quan hệ và khó chấp nhận khi người khác '
          'không chia sẻ tầm nhìn của mình.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi biết" — bản thể được định nghĩa qua tầm nhìn tập thể',
      description:
          'Bảo Bình Sun sống với cảm giác rằng họ đang nhìn thấy thứ gì đó quan trọng '
          'mà người khác chưa thấy. Đây không phải kiêu ngạo — đây là cách não họ xử lý '
          'thông tin. Vấn đề là khi không ai hiểu, họ cảm thấy cô đơn '
          'theo một cách rất khó diễn đạt.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc được lý trí hóa',
      description:
          'Bảo Bình Moon phân tích cảm xúc như phân tích một vấn đề kỹ thuật '
          '— điều này giúp họ không bị lấn át, nhưng cũng có nghĩa là họ đôi khi '
          'bỏ lỡ chính cảm xúc của mình.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: khác biệt và khó nắm bắt',
      description:
          'Bảo Bình Rising tạo ấn tượng khó quên nhưng cũng khó phân loại. '
          'Người ta biết họ là người thú vị nhưng không chắc tại sao. '
          'Họ có thứ gì đó vừa quen vừa lạ — '
          'như đang nói chuyện với người đến từ một thế giới song song.',
    ),
  ),

  // ── PISCES ─────────────────────────────────────────────────────────────────
  OracleSign(
    id: 'pisces',
    name: 'PISCES',
    symbol: '♓',
    dateRange: '19/2 – 20/3',
    element: 'Nước',
    modality: 'Biến đổi (Mutable)',
    summary:
        'Cung cuối cùng của hoàng đạo, thuộc nguyên tố Nước và là cung Biến đổi (Mutable). '
        'Song Ngư mang trong mình dấu ấn của tất cả 11 cung trước — đây vừa là chiều sâu '
        'lớn nhất vừa là nguồn gốc của sự phức tạp của họ. Họ không phức tạp vì muốn vậy '
        '— họ phức tạp vì thấu cảm quá sâu.',
    male: SignGenderAnalysis(
      personality:
          'Người đàn ông mà thế giới vật chất không bao giờ là nơi họ thực sự sống. '
          'Trực giác mạnh, nhạy cảm và có khả năng kết nối cảm xúc hiếm có.',
      inLove:
          'Lãng mạn sâu sắc và tận tụy. Dễ lý tưởng hóa người yêu đến mức đau khổ '
          'khi thực tế không khớp với tưởng tượng.',
      career:
          'Thường phù hợp với nghệ thuật, âm nhạc, tâm lý học, chăm sóc sức khỏe '
          'và bất kỳ lĩnh vực nào cần trực giác và lòng trắc ẩn.',
      weakness:
          'Dễ trốn tránh thực tế, ranh giới cá nhân mờ nhạt '
          'và dễ bị ảnh hưởng bởi năng lượng tiêu cực của môi trường.',
    ),
    female: SignGenderAnalysis(
      personality:
          'Người phụ nữ mà bạn không bao giờ hoàn toàn hiểu — không phải vì họ bí ẩn '
          'cố tình, mà vì họ còn đang tìm hiểu chính mình.',
      inLove:
          'Có xu hướng cho đi nhiều trong mối quan hệ. Việc thiết lập ranh giới '
          'lành mạnh và giữ cân bằng cho – nhận sẽ giúp duy trì kết nối bền vững.',
      career:
          'Thường tìm thấy mục đích trong công việc chữa lành — y tế, tư vấn, '
          'nghệ thuật trị liệu. Cần môi trường có ý nghĩa, không chỉ thu nhập.',
      weakness:
          'Cần lưu ý củng cố ranh giới cá nhân và đôi khi có xu hướng né tránh '
          'thực tại thay vì đối diện với khó khăn.',
    ),
    decan1: SignDecan(
      dateRange: '19/02 – 29/02',
      planetInfluence: 'Hải Vương Tinh / Sao Mộc (Neptune/Jupiter)',
      description:
          'Song Ngư thuần khiết nhất. Trực giác, lòng trắc ẩn và kết nối tâm linh '
          'ở mức nguyên bản.',
      strengths:
          'Thấu cảm sâu sắc, trực giác phi thường, khả năng nghệ thuật và chữa lành tự nhiên.',
      weaknesses:
          'Ranh giới gần như không tồn tại, dễ mất bản thân trong người khác hoặc hoàn cảnh.',
    ),
    decan2: SignDecan(
      dateRange: '01/03 – 10/03',
      planetInfluence: 'Mặt Trăng (Cự Giải)',
      description:
          'Song Ngư với nhu cầu gia đình và ký ức sâu hơn. '
          'Kết hợp giữa trực giác của Song Ngư và sự nuôi dưỡng của Cự Giải.',
      strengths:
          'Yêu thương chân thành, nhớ từng chi tiết nhỏ về người thân, '
          'có khả năng chữa lành cảm xúc cho người khác.',
      weaknesses:
          'Dễ hoài cổ đến mức bị kẹt trong quá khứ, '
          'khó thoát khỏi những mối quan hệ không còn lành mạnh.',
    ),
    decan3: SignDecan(
      dateRange: '11/03 – 20/03',
      planetInfluence: 'Diêm Vương Tinh / Sao Hỏa (Bọ Cạp)',
      description:
          'Song Ngư với ý chí và khả năng biến đổi mạnh hơn. '
          'Kết hợp giữa trực giác của Song Ngư và chiều sâu của Bọ Cạp.',
      strengths:
          'Kiên cường hơn các decan khác, có khả năng chuyển đổi đau thương thành sức mạnh.',
      weaknesses:
          'Dễ cực đoan về mặt cảm xúc và đôi khi bị cuốn vào vòng xoáy của nỗi đau '
          'thay vì thoát ra.',
    ),
    sunLayer: SignLayer(
      essence: '"Tôi tin tưởng" — bản thể được định nghĩa qua sự kết nối với cái vô hình',
      description:
          'Song Ngư Sun không sống trong thế giới vật chất hoàn toàn. Họ có một chân ở đây '
          'và một chân ở nơi khác — nơi đó có thể là nghệ thuật, tâm linh, '
          'hay chỉ là một vũ trụ riêng trong đầu họ. '
          'Đây là nguồn gốc của thiên tài và cũng là nguồn gốc của sự lạc lối.',
    ),
    moonLayer: SignLayer(
      essence: 'Cảm xúc như đại dương — không có ranh giới rõ ràng',
      description:
          'Song Ngư Moon hấp thụ cảm xúc của môi trường xung quanh như miếng bọt biển. '
          'Họ thường không biết cảm xúc nào là của mình và cảm xúc nào là của người xung quanh. '
          'Điều này cần được nhận ra và quản lý, không phải coi là điểm yếu cố định.',
    ),
    risingLayer: SignLayer(
      essence: 'Ấn tượng đầu tiên: mơ màng và khó nắm bắt',
      description:
          'Song Ngư Rising tạo ấn tượng như đang nói chuyện với ai đó '
          'không hoàn toàn ở đây. Ánh mắt thường hướng vào một nơi nào đó bên trong. '
          'Người ta thường muốn bảo vệ họ, nhưng đôi khi bản thân Song Ngư '
          'không muốn được bảo vệ — họ muốn được thấu hiểu.',
    ),
  ),
];
