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
    'aries': 'Mar 21 – Apr 19',
    'taurus': 'Apr 20 – May 20',
    'gemini': 'May 21 – Jun 20',
    'cancer': 'Jun 21 – Jul 22',
    'leo': 'Jul 23 – Aug 22',
    'virgo': 'Aug 23 – Sep 22',
    'libra': 'Sep 23 – Oct 22',
    'scorpio': 'Oct 23 – Nov 21',
    'sagittarius': 'Nov 22 – Dec 21',
    'capricorn': 'Dec 22 – Jan 19',
    'aquarius': 'Jan 20 – Feb 18',
    'pisces': 'Feb 19 – Mar 20',
  };

  static const Map<String, String> _vietnameseRanges = <String, String>{
    'aries': '21/3 – 19/4',
    'taurus': '20/4 – 20/5',
    'gemini': '21/5 – 20/6',
    'cancer': '21/6 – 22/7',
    'leo': '23/7 – 22/8',
    'virgo': '23/8 – 22/9',
    'libra': '23/9 – 22/10',
    'scorpio': '23/10 – 21/11',
    'sagittarius': '22/11 – 21/12',
    'capricorn': '22/12 – 19/1',
    'aquarius': '20/1 – 18/2',
    'pisces': '19/2 – 20/3',
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
}
