import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/schedule/schedule.dart';
import 'package:woohakdong/repository/schedule/schedule_repository.dart';
import 'package:woohakdong/view_model/schedule/components/schedule_state_provider.dart';
import 'package:woohakdong/view_model/schedule/schedule_list_provider.dart';

import '../club/club_id_provider.dart';
import 'components/schedule_state.dart';

final scheduleProvider = StateNotifierProvider<ScheduleNotifier, Schedule>((ref) {
  return ScheduleNotifier(ref);
});

class ScheduleNotifier extends StateNotifier<Schedule> {
  final Ref ref;
  final ScheduleRepository scheduleRepository = ScheduleRepository();

  ScheduleNotifier(this.ref) : super(Schedule());

  Future<void> getScheduleInfo(int scheduleId) async {
    final currentClubId = ref.read(clubIdProvider);

    final scheduleInfo = await scheduleRepository.getScheduleInfo(currentClubId!, scheduleId);

    state = scheduleInfo;
  }

  Future<void> addSchedule(
    String scheduleTitle,
    String scheduleContent,
    DateTime scheduleDateTime,
    String scheduleColor,
  ) async {
    try {
      ref.read(scheduleStateProvider.notifier).state = ScheduleState.adding;

      final currentClubId = ref.read(clubIdProvider);

      await scheduleRepository.addSchedule(
        currentClubId!,
        Schedule(
          scheduleTitle: scheduleTitle,
          scheduleContent: scheduleContent,
          scheduleDateTime: scheduleDateTime,
          scheduleColor: scheduleColor,
        ),
      );

      await ref.read(scheduleListProvider.notifier).getScheduleList(null);
      ref.read(scheduleStateProvider.notifier).state = ScheduleState.added;
    } catch (e) {
      ref.read(scheduleStateProvider.notifier).state = ScheduleState.initial;
      rethrow;
    }
  }

  Future<void> updateSchedule(
    int scheduleId,
    String scheduleTitle,
    String scheduleContent,
    DateTime scheduleDateTime,
    String scheduleColor,
  ) async {
    try {
      ref.read(scheduleStateProvider.notifier).state = ScheduleState.adding;

      final currentClubId = ref.read(clubIdProvider);

      final updatedScheduleId = await scheduleRepository.updateSchedule(
        currentClubId!,
        scheduleId,
        state.copyWith(
          scheduleTitle: scheduleTitle,
          scheduleContent: scheduleContent,
          scheduleDateTime: scheduleDateTime,
          scheduleColor: scheduleColor,
        ),
      );

      await ref.read(scheduleListProvider.notifier).getScheduleList(null);
      await getScheduleInfo(updatedScheduleId);
      ref.read(scheduleStateProvider.notifier).state = ScheduleState.added;
    } catch (e) {
      ref.read(scheduleStateProvider.notifier).state = ScheduleState.initial;
      rethrow;
    }
  }

  Future<void> deleteSchedule(int scheduleId) async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      await scheduleRepository.deleteSchedule(
        currentClubId!,
        scheduleId,
      );

      await ref.read(scheduleListProvider.notifier).getScheduleList(null);
    } catch (e) {
      rethrow;
    }
  }
}
