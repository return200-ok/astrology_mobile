import 'star_engine.dart';
import 'main_star_rules.dart';
import 'secondary_star_rules.dart';

Chart generateChart(BirthData data) {
  final chart = Chart.empty();

  // Step 1: Add main 14 stars
  MainStarPositions.addMainStars(chart, data);

  // Step 2: Add Lộc Tồn (Luck star)
  final locTonIndex = 5;
  chart.addStar(locTonIndex, MainStarPositions.locTonFromYearStem(data.yearStem));

  // Step 3: Add hour-based secondary stars
  final hourStars = hourBasedStars(data.hourBranch);
  for (final star in hourStars) {
    chart.addStar(data.hourBranch, star);
  }

  // Step 4: Add year-based secondary stars
  final yearStars = yearBasedStars(data.yearBranch);
  for (final star in yearStars) {
    chart.addStar(data.yearBranch, star);
  }

  // Step 5: Add Thiên Khôi/Việt
  final khoi = thienKhoiVietFromStem(data.yearStem);
  chart.addStar(1, khoi);

  // Step 6: Add Vòng Tràng Sinh (12 fate cycle)
  final trangSinh = trangSinhPositions(data.cucNumber);
  for (int i = 0; i < 12; i++) {
    chart.addStar(i, trangSinh[i]);
  }

  return chart;
}
