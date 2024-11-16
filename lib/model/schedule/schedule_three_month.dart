import 'package:woohakdong/model/schedule/schedule.dart';

class ScheduleThreeMonth {
  final List<Schedule> previousMonth;
  final List<Schedule> currentMonth;
  final List<Schedule> nextMonth;

  ScheduleThreeMonth({
    required this.previousMonth,
    required this.currentMonth,
    required this.nextMonth,
  });
}