import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/schedule/schedule.dart';
import '../../repository/schedule/schedule_repository.dart';
import '../club/club_id_provider.dart';

final scheduleListProvider =
    StateNotifierProvider.family<ScheduleListNotifier, AsyncValue<List<Schedule>>, DateTime>((ref, scheduleMonth) {
  return ScheduleListNotifier(ref, scheduleMonth);
});

class ScheduleListNotifier extends StateNotifier<AsyncValue<List<Schedule>>> {
  final Ref ref;
  final DateTime scheduleMonth;
  final ScheduleRepository scheduleRepository = ScheduleRepository();

  ScheduleListNotifier(this.ref, this.scheduleMonth) : super(const AsyncValue.loading()) {
    getScheduleList();
  }

  Future<void> getScheduleList() async {
    final formattedMonth = DateFormat('yyyy-MM-dd').format(scheduleMonth);

    try {
      final currentClubId = ref.read(clubIdProvider);

      state = const AsyncValue.loading();

      final scheduleList = await scheduleRepository.getSchedule(
        currentClubId!,
        formattedMonth,
      );

      state = AsyncValue.data(scheduleList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

class ThreeMonthSchedule {
  final List<Schedule> previousMonth;
  final List<Schedule> currentMonth;
  final List<Schedule> nextMonth;

  ThreeMonthSchedule({
    required this.previousMonth,
    required this.currentMonth,
    required this.nextMonth,
  });
}