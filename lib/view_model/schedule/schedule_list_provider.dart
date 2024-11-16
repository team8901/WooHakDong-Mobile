import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/schedule/schedule_three_month.dart';
import '../../repository/schedule/schedule_repository.dart';
import '../club/club_id_provider.dart';

final scheduleListProvider =
    StateNotifierProvider.family<ScheduleListNotifier, AsyncValue<ScheduleThreeMonth>, DateTime>(
  (ref, baseMonth) => ScheduleListNotifier(ref, baseMonth),
);

class ScheduleListNotifier extends StateNotifier<AsyncValue<ScheduleThreeMonth>> {
  final Ref ref;
  late final DateTime baseMonth;
  final ScheduleRepository scheduleRepository = ScheduleRepository();

  ScheduleListNotifier(this.ref, this.baseMonth) : super(const AsyncValue.loading()) {
    getThreeMonthSchedule();
  }

  Future<void> getThreeMonthSchedule() async {
    try {
      state = const AsyncValue.loading();

      final previousMonth = DateTime(baseMonth.year, baseMonth.month - 1);
      final nextMonth = DateTime(baseMonth.year, baseMonth.month + 1);

      final currentClubId = ref.read(clubIdProvider);
      if (currentClubId == null) throw Exception('클럽 ID가 없습니다');

      final month = await Future.wait([
        scheduleRepository.getSchedule(
          currentClubId,
          DateFormat('yyyy-MM-dd').format(previousMonth),
        ),
        scheduleRepository.getSchedule(
          currentClubId,
          DateFormat('yyyy-MM-dd').format(baseMonth),
        ),
        scheduleRepository.getSchedule(
          currentClubId,
          DateFormat('yyyy-MM-dd').format(nextMonth),
        ),
      ]);

      state = AsyncValue.data(
        ScheduleThreeMonth(
          previousMonth: month[0],
          currentMonth: month[1],
          nextMonth: month[2],
        ),
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
