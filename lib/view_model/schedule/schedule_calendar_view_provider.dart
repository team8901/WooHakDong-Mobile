import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woohakdong/view_model/schedule/components/schedule_calendar_view_state.dart';

final scheduleCalendarViewProvider =
    StateNotifierProvider<ScheduleCalendarViewNotifier, ScheduleCalendarViewState>((ref) {
  return ScheduleCalendarViewNotifier();
});

class ScheduleCalendarViewNotifier extends StateNotifier<ScheduleCalendarViewState> {
  ScheduleCalendarViewNotifier() : super(ScheduleCalendarViewState.dayView) {
    _loadCalendarViewState();
  }

  void _loadCalendarViewState() async {
    final prefs = await SharedPreferences.getInstance();
    final calendarViewState = prefs.getInt('calendar_view_state') ?? ScheduleCalendarViewState.dayView.index;
    state = ScheduleCalendarViewState.values[calendarViewState];
  }

  void toggleCalendarViewState() async {
    final prefs = await SharedPreferences.getInstance();
    final newViewState = state == ScheduleCalendarViewState.monthView
        ? ScheduleCalendarViewState.dayView
        : ScheduleCalendarViewState.monthView;
    prefs.setInt('calendar_view_state', newViewState.index);
    state = newViewState;
  }
}
