import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../model/schedule/schedule.dart';
import '../../../themes/spacing.dart';

class ClubScheduleTableCalendarMonth extends ConsumerWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;
  final List<Schedule> Function(DateTime) eventLoader;
  final VoidCallback onTodayButtonPressed;

  const ClubScheduleTableCalendarMonth({
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
    return Expanded(
      child: TableCalendar(
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
        shouldFillViewport: true,
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
          outsideDaysVisible: false,
          rowDecoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: context.colorScheme.surfaceContainer,
                width: 0.8,
              ),
            ),
          ),
        ),
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) {
            return Padding(
              padding: const EdgeInsets.only(
                left: defaultPaddingS,
                right: defaultPaddingS,
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
          defaultBuilder: (context, date, _) {
            return Padding(
              padding: const EdgeInsets.only(top: defaultGapS / 2),
              child: Column(
                children: [
                  Container(
                    width: 24.r,
                    height: 24.r,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        DateFormat('d').format(date),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday)
                              ? context.colorScheme.outline
                              : context.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            );
          },
          todayBuilder: (context, date, _) {
            return Padding(
              padding: const EdgeInsets.only(top: defaultGapS / 2),
              child: Column(
                children: [
                  Container(
                    width: 24.r,
                    height: 24.r,
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
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            );
          },
          selectedBuilder: (context, date, _) {
            return Padding(
              padding: const EdgeInsets.only(top: defaultGapS / 2),
              child: Column(
                children: [
                  Container(
                    width: 24.r,
                    height: 24.r,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        DateFormat('d').format(date),
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            );
          },
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              final sortedEvents = (events as List<Schedule>).where((event) => event.scheduleDateTime != null).toList()
                ..sort((a, b) => a.scheduleDateTime!.compareTo(b.scheduleDateTime!));

              final limitedEvents = sortedEvents.take(4).toList();

              return Padding(
                padding: const EdgeInsets.only(top: defaultGapL * 2 - 2),
                child: Column(
                  children: limitedEvents.map((schedule) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 2,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Color(int.parse('0x${schedule.scheduleColor!}')).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        schedule.scheduleTitle!,
                        style: context.textTheme.labelLarge?.copyWith(fontSize: 10),
                        softWrap: false,
                        overflow: TextOverflow.clip,
                      ),
                    );
                  }).toList(),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
