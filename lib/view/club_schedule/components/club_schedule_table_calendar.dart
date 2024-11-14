import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/schedule/schedule.dart';
import '../../themes/spacing.dart';
import '../../themes/theme_context.dart';

class ClubScheduleTableCalendar extends ConsumerWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;
  final List<Schedule> Function(DateTime) eventLoader;
  final VoidCallback onTodayButtonPressed;

  const ClubScheduleTableCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.eventLoader,
    required this.onTodayButtonPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TableCalendar(
      locale: 'ko_KR',
      firstDay: DateTime(2000),
      lastDay: DateTime(2099),
      availableGestures: AvailableGestures.horizontalSwipe,
      pageAnimationCurve: Curves.easeOutQuad,
      pageAnimationDuration: const Duration(milliseconds: 400),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
      eventLoader: eventLoader,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        formatButtonShowsNext: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextStyle: context.textTheme.titleLarge!,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: context.textTheme.labelLarge!,
        weekendStyle: context.textTheme.labelLarge!.copyWith(
          color: context.colorScheme.outline,
        ),
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: context.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
        weekendTextStyle: context.textTheme.titleSmall!.copyWith(
          color: context.colorScheme.outline,
        ),
        defaultTextStyle: context.textTheme.titleSmall!,
        selectedTextStyle: context.textTheme.titleSmall!.copyWith(
          color: context.colorScheme.onPrimary,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          return Padding(
            padding: const EdgeInsets.only(
              left: defaultPaddingS,
              right: defaultPaddingS,
              bottom: defaultPaddingM,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat('yyyy년 MM월').format(day),
                    style: context.textTheme.titleLarge,
                  ),
                ),
                GestureDetector(
                  onTap: onTodayButtonPressed,
                  child: Text(
                    '오늘',
                    style: context.textTheme.bodyMedium!,
                  ),
                ),
              ],
            ),
          );
        },
        todayBuilder: (context, date, _) {
          return Center(
            child: Container(
              width: 32.r,
              height: 32.r,
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.colorScheme.primary,
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  DateFormat('d').format(date),
                  style: context.textTheme.titleSmall!.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          );
        },
        selectedBuilder: (context, date, _) {
          return Center(
            child: Container(
              width: 32.r,
              height: 32.r,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  DateFormat('d').format(date),
                  style: context.textTheme.titleSmall!.copyWith(
                    color: context.colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
          );
        },
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            final sortedEvents = (events as List<Schedule>).where((event) => event.scheduleDateTime != null).toList()
              ..sort((a, b) => a.scheduleDateTime!.compareTo(b.scheduleDateTime!));

            if (sortedEvents.length >= 4) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                ),
                width: 22,
                height: 6,
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: sortedEvents.map((schedule) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Color(int.parse('0x${schedule.scheduleColor!}')),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
