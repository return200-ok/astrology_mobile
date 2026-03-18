class BirthChart {
  final String name;
  final DateTime birthDate;
  final Map<int, List<String>> palaceStars; // house index -> [star names]

  BirthChart({
    required this.name,
    required this.birthDate,
    required this.palaceStars,
  });
}
