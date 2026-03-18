import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/birth_profile.dart';
import '../../domain/models/birth_chart.dart';

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

// Chart state
class ChartNotifier extends StateNotifier<AsyncValue<BirthChart?>> {
  ChartNotifier() : super(const AsyncValue.data(null));

  void generateChart(BirthProfile profile) {
    state = const AsyncValue.loading();
    try {
      // TODO: Implement actual chart generation
      // For now, just set loading then complete
      Future.delayed(const Duration(milliseconds: 500), () {
        state = const AsyncValue.data(null);
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}

final chartProvider = StateNotifierProvider<ChartNotifier, AsyncValue<BirthChart?>>(
  (ref) => ChartNotifier(),
);
