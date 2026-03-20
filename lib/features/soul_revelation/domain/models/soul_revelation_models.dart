import 'package:flutter/widgets.dart';

enum BigFiveTrait {
  openness,
  conscientiousness,
  extraversion,
  agreeableness,
  neuroticism,
}

extension BigFiveTraitText on BigFiveTrait {
  String label(Locale locale) {
    final vi = locale.languageCode == 'vi';
    switch (this) {
      case BigFiveTrait.openness:
        return vi ? 'CỞI MỞ TRẢI NGHIỆM' : 'OPENNESS';
      case BigFiveTrait.conscientiousness:
        return vi ? 'TẬN TÂM / KỶ LUẬT' : 'CONSCIENTIOUSNESS';
      case BigFiveTrait.extraversion:
        return vi ? 'HƯỚNG NGOẠI' : 'EXTRAVERSION';
      case BigFiveTrait.agreeableness:
        return vi ? 'DỄ CHỊU / HÒA HỢP' : 'AGREEABLENESS';
      case BigFiveTrait.neuroticism:
        return vi ? 'BẤT ỔN CẢM XÚC' : 'NEUROTICISM';
    }
  }
}

enum BigFiveLevel {
  low,
  medium,
  high,
}

extension BigFiveLevelText on BigFiveLevel {
  String label(Locale locale) {
    final vi = locale.languageCode == 'vi';
    switch (this) {
      case BigFiveLevel.low:
        return vi ? 'Thấp' : 'Low';
      case BigFiveLevel.medium:
        return vi ? 'Trung bình' : 'Medium';
      case BigFiveLevel.high:
        return vi ? 'Cao' : 'High';
    }
  }
}

class BfiQuestion {
  const BfiQuestion({
    required this.id,
    required this.trait,
    required this.reverseScored,
    required this.promptEn,
    required this.promptVi,
  });

  final int id;
  final BigFiveTrait trait;
  final bool reverseScored;
  final String promptEn;
  final String promptVi;

  String promptFor(Locale locale) {
    return locale.languageCode == 'vi' ? promptVi : promptEn;
  }
}

class BfiScaleOption {
  const BfiScaleOption({
    required this.value,
    required this.labelEn,
    required this.labelVi,
  });

  final int value;
  final String labelEn;
  final String labelVi;

  String labelFor(Locale locale) {
    return locale.languageCode == 'vi' ? labelVi : labelEn;
  }
}

const List<BfiScaleOption> bfiScaleOptions = [
  BfiScaleOption(
    value: 1,
    labelEn: 'Strongly disagree',
    labelVi: 'Hoàn toàn không đồng ý',
  ),
  BfiScaleOption(
    value: 2,
    labelEn: 'Disagree',
    labelVi: 'Không đồng ý',
  ),
  BfiScaleOption(
    value: 3,
    labelEn: 'Neutral',
    labelVi: 'Trung lập',
  ),
  BfiScaleOption(
    value: 4,
    labelEn: 'Agree',
    labelVi: 'Đồng ý',
  ),
  BfiScaleOption(
    value: 5,
    labelEn: 'Strongly agree',
    labelVi: 'Hoàn toàn đồng ý',
  ),
];

// Keep the original BFI-44 mixed order so the traits stay interleaved.
const List<BfiQuestion> bfi44Questions = [
  BfiQuestion(
    id: 1,
    trait: BigFiveTrait.extraversion,
    reverseScored: false,
    promptEn: 'I am talkative.',
    promptVi: 'Tôi là người hay nói chuyện.',
  ),
  BfiQuestion(
    id: 2,
    trait: BigFiveTrait.agreeableness,
    reverseScored: true,
    promptEn: 'I tend to find fault with others.',
    promptVi: 'Tôi có xu hướng hay bắt lỗi người khác.',
  ),
  BfiQuestion(
    id: 3,
    trait: BigFiveTrait.conscientiousness,
    reverseScored: false,
    promptEn: 'I do a thorough job.',
    promptVi: 'Tôi làm việc kỹ lưỡng và cẩn thận.',
  ),
  BfiQuestion(
    id: 4,
    trait: BigFiveTrait.neuroticism,
    reverseScored: false,
    promptEn: 'I feel depressed or blue.',
    promptVi: 'Tôi dễ cảm thấy buồn bã hoặc chán nản.',
  ),
  BfiQuestion(
    id: 5,
    trait: BigFiveTrait.openness,
    reverseScored: false,
    promptEn: 'I come up with original ideas.',
    promptVi: 'Tôi thường nghĩ ra những ý tưởng mới.',
  ),
  BfiQuestion(
    id: 6,
    trait: BigFiveTrait.extraversion,
    reverseScored: true,
    promptEn: 'I am reserved.',
    promptVi: 'Tôi khá kín tiếng, ít nói.',
  ),
  BfiQuestion(
    id: 7,
    trait: BigFiveTrait.agreeableness,
    reverseScored: false,
    promptEn: 'I am helpful and unselfish with others.',
    promptVi: 'Tôi sẵn sàng giúp đỡ người khác, không ích kỷ.',
  ),
  BfiQuestion(
    id: 8,
    trait: BigFiveTrait.conscientiousness,
    reverseScored: true,
    promptEn: 'I can be somewhat careless.',
    promptVi: 'Tôi đôi khi khá cẩu thả.',
  ),
  BfiQuestion(
    id: 9,
    trait: BigFiveTrait.neuroticism,
    reverseScored: true,
    promptEn: 'I am relaxed and handle stress well.',
    promptVi: 'Tôi thoải mái và xử lý áp lực khá tốt.',
  ),
  BfiQuestion(
    id: 10,
    trait: BigFiveTrait.openness,
    reverseScored: false,
    promptEn: 'I am curious about many different things.',
    promptVi: 'Tôi tò mò về nhiều thứ khác nhau.',
  ),
  BfiQuestion(
    id: 11,
    trait: BigFiveTrait.extraversion,
    reverseScored: false,
    promptEn: 'I am full of energy.',
    promptVi: 'Tôi có nhiều năng lượng.',
  ),
  BfiQuestion(
    id: 12,
    trait: BigFiveTrait.agreeableness,
    reverseScored: true,
    promptEn: 'I start quarrels with others.',
    promptVi: 'Tôi dễ gây cãi vã với người khác.',
  ),
  BfiQuestion(
    id: 13,
    trait: BigFiveTrait.conscientiousness,
    reverseScored: false,
    promptEn: 'I am a reliable worker.',
    promptVi: 'Tôi là người làm việc đáng tin cậy.',
  ),
  BfiQuestion(
    id: 14,
    trait: BigFiveTrait.neuroticism,
    reverseScored: false,
    promptEn: 'I can be tense.',
    promptVi: 'Tôi dễ rơi vào trạng thái căng thẳng.',
  ),
  BfiQuestion(
    id: 15,
    trait: BigFiveTrait.openness,
    reverseScored: false,
    promptEn: 'I am ingenious and a deep thinker.',
    promptVi: 'Tôi là người suy nghĩ sâu sắc.',
  ),
  BfiQuestion(
    id: 16,
    trait: BigFiveTrait.extraversion,
    reverseScored: false,
    promptEn: 'I generate a lot of enthusiasm.',
    promptVi: 'Tôi dễ truyền cảm hứng cho người khác.',
  ),
  BfiQuestion(
    id: 17,
    trait: BigFiveTrait.agreeableness,
    reverseScored: false,
    promptEn: 'I have a forgiving nature.',
    promptVi: 'Tôi là người dễ tha thứ.',
  ),
  BfiQuestion(
    id: 18,
    trait: BigFiveTrait.conscientiousness,
    reverseScored: true,
    promptEn: 'I tend to be disorganized.',
    promptVi: 'Tôi có xu hướng thiếu ngăn nắp.',
  ),
  BfiQuestion(
    id: 19,
    trait: BigFiveTrait.neuroticism,
    reverseScored: false,
    promptEn: 'I worry a lot.',
    promptVi: 'Tôi hay lo lắng nhiều.',
  ),
  BfiQuestion(
    id: 20,
    trait: BigFiveTrait.openness,
    reverseScored: false,
    promptEn: 'I have an active imagination.',
    promptVi: 'Tôi có trí tưởng tượng phong phú.',
  ),
  BfiQuestion(
    id: 21,
    trait: BigFiveTrait.extraversion,
    reverseScored: true,
    promptEn: 'I tend to be quiet.',
    promptVi: 'Tôi có xu hướng trầm lặng.',
  ),
  BfiQuestion(
    id: 22,
    trait: BigFiveTrait.agreeableness,
    reverseScored: false,
    promptEn: 'I am generally trusting.',
    promptVi: 'Tôi thường tin tưởng người khác.',
  ),
  BfiQuestion(
    id: 23,
    trait: BigFiveTrait.conscientiousness,
    reverseScored: true,
    promptEn: 'I tend to be lazy.',
    promptVi: 'Tôi có xu hướng lười biếng.',
  ),
  BfiQuestion(
    id: 24,
    trait: BigFiveTrait.neuroticism,
    reverseScored: true,
    promptEn: 'I am emotionally stable, not easily upset.',
    promptVi: 'Tôi ổn định cảm xúc, không dễ bị ảnh hưởng.',
  ),
  BfiQuestion(
    id: 25,
    trait: BigFiveTrait.openness,
    reverseScored: false,
    promptEn: 'I am inventive.',
    promptVi: 'Tôi sáng tạo, có nhiều ý tưởng mới.',
  ),
  BfiQuestion(
    id: 26,
    trait: BigFiveTrait.extraversion,
    reverseScored: false,
    promptEn: 'I have an assertive personality.',
    promptVi: 'Tôi có cá tính quyết đoán.',
  ),
  BfiQuestion(
    id: 27,
    trait: BigFiveTrait.agreeableness,
    reverseScored: true,
    promptEn: 'I can be cold and aloof.',
    promptVi: 'Tôi có thể lạnh lùng và xa cách.',
  ),
  BfiQuestion(
    id: 28,
    trait: BigFiveTrait.conscientiousness,
    reverseScored: false,
    promptEn: 'I persevere until the task is finished.',
    promptVi: 'Tôi kiên trì cho đến khi hoàn thành công việc.',
  ),
  BfiQuestion(
    id: 29,
    trait: BigFiveTrait.neuroticism,
    reverseScored: false,
    promptEn: 'I can be moody.',
    promptVi: 'Tâm trạng tôi có thể thay đổi thất thường.',
  ),
  BfiQuestion(
    id: 30,
    trait: BigFiveTrait.openness,
    reverseScored: false,
    promptEn: 'I value artistic and aesthetic experiences.',
    promptVi: 'Tôi trân trọng các trải nghiệm nghệ thuật và thẩm mỹ.',
  ),
  BfiQuestion(
    id: 31,
    trait: BigFiveTrait.extraversion,
    reverseScored: true,
    promptEn: 'I am sometimes shy or inhibited.',
    promptVi: 'Tôi đôi khi nhút nhát, ngại ngùng.',
  ),
  BfiQuestion(
    id: 32,
    trait: BigFiveTrait.agreeableness,
    reverseScored: false,
    promptEn: 'I am considerate and kind to almost everyone.',
    promptVi: 'Tôi chu đáo và tử tế với hầu hết mọi người.',
  ),
  BfiQuestion(
    id: 33,
    trait: BigFiveTrait.conscientiousness,
    reverseScored: false,
    promptEn: 'I do things efficiently.',
    promptVi: 'Tôi làm việc hiệu quả.',
  ),
  BfiQuestion(
    id: 34,
    trait: BigFiveTrait.neuroticism,
    reverseScored: true,
    promptEn: 'I remain calm in tense situations.',
    promptVi: 'Tôi vẫn giữ bình tĩnh trong tình huống căng thẳng.',
  ),
  BfiQuestion(
    id: 35,
    trait: BigFiveTrait.openness,
    reverseScored: true,
    promptEn: 'I prefer work that is routine.',
    promptVi: 'Tôi thích công việc lặp lại, quen thuộc.',
  ),
  BfiQuestion(
    id: 36,
    trait: BigFiveTrait.extraversion,
    reverseScored: false,
    promptEn: 'I am outgoing and sociable.',
    promptVi: 'Tôi hướng ngoại, thích giao tiếp.',
  ),
  BfiQuestion(
    id: 37,
    trait: BigFiveTrait.agreeableness,
    reverseScored: true,
    promptEn: 'I am sometimes rude to others.',
    promptVi: 'Đôi khi tôi cư xử thiếu nhã nhặn với người khác.',
  ),
  BfiQuestion(
    id: 38,
    trait: BigFiveTrait.conscientiousness,
    reverseScored: false,
    promptEn: 'I make plans and follow through with them.',
    promptVi: 'Tôi lập kế hoạch và theo đến cùng.',
  ),
  BfiQuestion(
    id: 39,
    trait: BigFiveTrait.neuroticism,
    reverseScored: false,
    promptEn: 'I get nervous easily.',
    promptVi: 'Tôi dễ lo lắng, hồi hộp.',
  ),
  BfiQuestion(
    id: 40,
    trait: BigFiveTrait.openness,
    reverseScored: false,
    promptEn: 'I like to reflect and play with ideas.',
    promptVi: 'Tôi thích suy ngẫm và khám phá ý tưởng.',
  ),
  BfiQuestion(
    id: 41,
    trait: BigFiveTrait.openness,
    reverseScored: true,
    promptEn: 'I have few artistic interests.',
    promptVi: 'Tôi ít quan tâm đến nghệ thuật.',
  ),
  BfiQuestion(
    id: 42,
    trait: BigFiveTrait.agreeableness,
    reverseScored: false,
    promptEn: 'I like to cooperate with others.',
    promptVi: 'Tôi thích hợp tác với người khác.',
  ),
  BfiQuestion(
    id: 43,
    trait: BigFiveTrait.conscientiousness,
    reverseScored: true,
    promptEn: 'I am easily distracted.',
    promptVi: 'Tôi dễ bị xao nhãng.',
  ),
  BfiQuestion(
    id: 44,
    trait: BigFiveTrait.openness,
    reverseScored: false,
    promptEn: 'I am sophisticated in art, music, or literature.',
    promptVi: 'Tôi có gu thẩm mỹ về nghệ thuật, âm nhạc hoặc văn học.',
  ),
];

Map<BigFiveTrait, double> calculateBfi44Scores(Map<int, int> answers) {
  final sumByTrait = <BigFiveTrait, double>{
    for (final trait in BigFiveTrait.values) trait: 0.0,
  };
  final countByTrait = <BigFiveTrait, int>{
    for (final trait in BigFiveTrait.values) trait: 0,
  };

  for (final question in bfi44Questions) {
    final rawValue = answers[question.id];
    if (rawValue == null) {
      continue;
    }

    final normalized = rawValue.clamp(1, 5).toDouble();
    final scoredValue = question.reverseScored ? 6 - normalized : normalized;

    sumByTrait[question.trait] = (sumByTrait[question.trait] ?? 0.0) + scoredValue;
    countByTrait[question.trait] = (countByTrait[question.trait] ?? 0) + 1;
  }

  final results = <BigFiveTrait, double>{};
  for (final trait in BigFiveTrait.values) {
    final count = countByTrait[trait] ?? 0;
    if (count == 0) {
      results[trait] = 0.0;
      continue;
    }

    final mean = (sumByTrait[trait] ?? 0.0) / count;
    final score100 = ((mean - 1) / 4) * 100;
    results[trait] = double.parse(score100.toStringAsFixed(1));
  }

  return results;
}

BigFiveLevel bigFiveLevelOf(double score) {
  if (score < 2.5) {
    return BigFiveLevel.low;
  }
  if (score < 3.5) {
    return BigFiveLevel.medium;
  }
  return BigFiveLevel.high;
}

double bigFiveAverageFrom100(double score100) {
  return (score100 / 25) + 1;
}

enum EnneagramType {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
}

extension EnneagramTypeLabel on EnneagramType {
  String get label {
    switch (this) {
      case EnneagramType.one:
        return 'TYPE 1 - THE REFORMER';
      case EnneagramType.two:
        return 'TYPE 2 - THE HELPER';
      case EnneagramType.three:
        return 'TYPE 3 - THE ACHIEVER';
      case EnneagramType.four:
        return 'TYPE 4 - THE INDIVIDUALIST';
      case EnneagramType.five:
        return 'TYPE 5 - THE INVESTIGATOR';
      case EnneagramType.six:
        return 'TYPE 6 - THE LOYALIST';
      case EnneagramType.seven:
        return 'TYPE 7 - THE ENTHUSIAST';
      case EnneagramType.eight:
        return 'TYPE 8 - THE CHALLENGER';
      case EnneagramType.nine:
        return 'TYPE 9 - THE PEACEMAKER';
    }
  }
}

class EnneagramQuestion {
  const EnneagramQuestion({
    required this.type,
    required this.prompt,
  });

  final EnneagramType type;
  final String prompt;
}

const List<String> soulScaleOptions = [
  'FULLY ABSENT',
  'FAINT',
  'BALANCED',
  'PRESENT',
  'FULLY RADIANT',
];

const List<int> soulScalePercent = [0, 20, 60, 80, 100];

const List<EnneagramQuestion> enneagramQuestions = [
  EnneagramQuestion(
    type: EnneagramType.one,
    prompt: 'I seek sacred perfection in all my actions.',
  ),
  EnneagramQuestion(
    type: EnneagramType.two,
    prompt: 'I feel fulfilled when I help others feel seen and supported.',
  ),
  EnneagramQuestion(
    type: EnneagramType.three,
    prompt: 'I define myself through achievement and visible progress.',
  ),
  EnneagramQuestion(
    type: EnneagramType.four,
    prompt: 'I am deeply attuned to beauty, emotion, and personal meaning.',
  ),
  EnneagramQuestion(
    type: EnneagramType.five,
    prompt: 'I conserve energy and gather knowledge before acting.',
  ),
  EnneagramQuestion(
    type: EnneagramType.six,
    prompt: 'I prepare for uncertainty by planning for every possibility.',
  ),
  EnneagramQuestion(
    type: EnneagramType.seven,
    prompt: 'I move toward possibility, novelty, and uplifting experiences.',
  ),
  EnneagramQuestion(
    type: EnneagramType.eight,
    prompt: 'I prefer direct strength and protect what I care about.',
  ),
  EnneagramQuestion(
    type: EnneagramType.nine,
    prompt: 'I naturally seek peace and avoid unnecessary conflict.',
  ),
];
