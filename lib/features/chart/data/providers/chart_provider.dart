import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lunar/lunar.dart';
import '../../domain/models/birth_profile.dart';
import '../../domain/models/birth_chart.dart';
import '../../../../astro_engine/star_engine.dart';
import '../../../../astro_engine/chart_builder.dart' as engine;

// Profile state
class ProfileNotifier extends StateNotifier<BirthProfile?> {
  ProfileNotifier() : super(null);

  void setProfile(BirthProfile profile) {
    state = profile;
  }

  void clear() {
    state = null;
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, BirthProfile?>(
  (ref) => ProfileNotifier(),
);

/// Convert TimeOfDay to hour branch index (0-11).
/// Tý(0)=23-1, Sửu(1)=1-3, Dần(2)=3-5, ..., Hợi(11)=21-23
int hourBranchFromTime(TimeOfDay time) {
  final h = time.hour;
  if (h >= 23 || h < 1) return 0;  // Tý
  return ((h + 1) ~/ 2);
}

/// Convert a gregorian DateTime + TimeOfDay + cucNumber into a BirthData
/// that the astro engine can consume.
BirthData birthDataFromProfile(BirthProfile profile) {
  final dt = profile.birthDate;
  final solar = Solar.fromYmdHms(dt.year, dt.month, dt.day, 0, 0, 0);
  final lunar = solar.getLunar();

  return BirthData(
    lunarDay: lunar.getDay(),
    lunarMonth: lunar.getMonth(),
    yearStem: lunar.getYearGanIndex(),
    yearBranch: lunar.getYearZhiIndex(),
    hourBranch: hourBranchFromTime(profile.birthTime),
    cucNumber: profile.cuc,
  );
}

// Chart state
class ChartNotifier extends StateNotifier<AsyncValue<BirthChart?>> {
  ChartNotifier() : super(const AsyncValue.data(null));

  void generateChart(BirthProfile profile) {
    state = const AsyncValue.loading();
    try {
      final birthData = birthDataFromProfile(profile);
      final chart = engine.generateChart(birthData);

      state = AsyncValue.data(BirthChart(
        name: profile.name,
        birthDate: profile.birthDate,
        palaceStars: chart.houses,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}

final chartProvider = StateNotifierProvider<ChartNotifier, AsyncValue<BirthChart?>>(
  (ref) => ChartNotifier(),
);
