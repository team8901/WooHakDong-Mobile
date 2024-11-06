import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/schedule/schedule.dart';
import '../../../view_model/schedule/schedule_list_provider.dart';
import '../../themes/custom_widget/etc/custom_horizontal_divider.dart';
import 'club_schedule_list_tile.dart';

class ClubScheduleCalendarView extends ConsumerStatefulWidget {
  const ClubScheduleCalendarView({super.key});

  @override
  ConsumerState<ClubScheduleCalendarView> createState() => _ClubScheduleCalendarViewState();
}

class _ClubScheduleCalendarViewState extends ConsumerState<ClubScheduleCalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadMonthlySchedules(_focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendar(
          locale: 'ko_KR',
          firstDay: DateTime(2000),
          lastDay: DateTime(2099),
          availableGestures: AvailableGestures.horizontalSwipe,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
            _loadMonthlySchedules(focusedDay);
          },
          eventLoader: _getEventsForDay,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            formatButtonShowsNext: false,
            leftChevronVisible: false,
            rightChevronVisible: false,
            titleTextStyle: context.textTheme.titleLarge!,
            headerPadding: const EdgeInsets.only(left: defaultPaddingS, bottom: defaultPaddingM),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: context.textTheme.labelLarge!,
            weekendStyle: context.textTheme.labelLarge!.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: false,
            weekendTextStyle: context.textTheme.titleSmall!.copyWith(
              color: context.colorScheme.onSurface,
            ),
            defaultTextStyle: context.textTheme.titleSmall!,
            selectedTextStyle: context.textTheme.titleSmall!.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, date, _) {
              return Center(
                child: Text(
                  DateFormat('d').format(date),
                  style: context.textTheme.titleSmall!.copyWith(
                    color: context.colorScheme.primary,
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
                final limitedEvents = (events as List<Schedule>).take(3).toList();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: limitedEvents.map((schedule) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: BoxDecoration(
                          color: Color(int.parse('0x${schedule.scheduleColor!}')),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
              return const SizedBox();
            },
          ),
        ),
        const Gap(defaultGapM),
        Divider(
          height: 0,
          thickness: 1,
          color: context.colorScheme.surfaceContainer,
        ),
        const Gap(defaultGapXL),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
          child: Text(
            DateFormat('d일').format(_selectedDay!),
            style: context.textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final scheduleListData = ref.watch(scheduleListProvider);

              final filteredSchedules = scheduleListData.where((schedule) {
                return isSameDay(schedule.scheduleDateTime, _selectedDay);
              }).toList()
                ..sort((a, b) => a.scheduleDateTime!.compareTo(b.scheduleDateTime!));

              if (scheduleListData.isEmpty) {
                return Center(
                  child: Text(
                    '등록된 일정이 없어요',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                );
              }

              return ListView.separated(
                separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  final schedule = filteredSchedules[index];
                  return ClubScheduleListTile(schedule: schedule);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _loadMonthlySchedules(DateTime month) async {
    final formattedMonth = DateFormat('yyyy-MM-dd').format(month);
    await ref.read(scheduleListProvider.notifier).getScheduleList(formattedMonth);
  }

  List<Schedule> _getEventsForDay(DateTime day) {
    final schedules = ref.watch(scheduleListProvider);
    return schedules.where((schedule) {
      return isSameDay(schedule.scheduleDateTime, day);
    }).toList();
  }
}
