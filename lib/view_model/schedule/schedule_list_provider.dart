import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/schedule/schedule.dart';
import '../../repository/schedule/schedule_repository.dart';
import '../club/club_id_provider.dart';

final scheduleListProvider = StateNotifierProvider<ScheduleListNotifier, List<Schedule>>((ref) {
  return ScheduleListNotifier(ref);
});

class ScheduleListNotifier extends StateNotifier<List<Schedule>> {
  final Ref ref;
  final ScheduleRepository scheduleRepository = ScheduleRepository();

  ScheduleListNotifier(this.ref) : super([]);

  Future<void> getScheduleList(String? date) async {
    final currentClubId = ref.watch(clubIdProvider);

    final scheduleList = await scheduleRepository.getSchedule(currentClubId!, date);
    state = scheduleList;
  }
}
