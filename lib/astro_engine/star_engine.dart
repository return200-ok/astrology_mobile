class BirthData {
  final int lunarDay;
  final int lunarMonth;
  final int yearStem;
  final int yearBranch;
  final int hourBranch;
  final int cucNumber;

  BirthData({
    required this.lunarDay,
    required this.lunarMonth,
    required this.yearStem,
    required this.yearBranch,
    required this.hourBranch,
    required this.cucNumber,
  });
}

class Chart {
  final Map<int, List<String>> houses;

  Chart._(this.houses);

  factory Chart.empty() {
    final Map<int, List<String>> m = Map.fromIterable(
      List.generate(12, (i) => i),
      key: (i) => i as int,
      value: (i) => <String>[],
    );
    return Chart._(m);
  }

  void addStar(int index, String star) {
    final i = mod12(index);
    houses[i]!.add(star);
  }
}

int mod12(int v) => ((v % 12) + 12) % 12;
