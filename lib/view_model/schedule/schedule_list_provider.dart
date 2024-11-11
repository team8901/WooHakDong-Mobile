import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/schedule/schedule.dart';
import '../../repository/schedule/schedule_repository.dart';
import '../club/club_id_provider.dart';

final scheduleListProvider = StateNotifierProvider<ScheduleListNotifier, AsyncValue<List<Schedule>>>((ref) {
  return ScheduleListNotifier(ref);
});

class ScheduleListNotifier extends StateNotifier<AsyncValue<List<Schedule>>> {
  final Ref ref;
  final ScheduleRepository scheduleRepository = ScheduleRepository();

  ScheduleListNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> getScheduleList(String? date) async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      state = const AsyncValue.loading();

      final scheduleList = await scheduleRepository.getSchedule(
        currentClubId!,
        date,
      );

      state = AsyncValue.data(scheduleList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
