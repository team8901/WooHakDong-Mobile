import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/schedule/components/schedule_selected_day_provider.dart';

import '../../../model/schedule/schedule.dart';
import '../../../view_model/schedule/schedule_list_provider.dart';
import '../../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../../themes/custom_widget/interaction/custom_refresh_indicator.dart';
import '../../themes/spacing.dart';
import '../club_schedule_add_page.dart';
import 'club_schedule_list_tile.dart';
import 'club_schedule_table_calendar.dart';

class ClubScheduleCalendarView extends ConsumerStatefulWidget {
  const ClubScheduleCalendarView({super.key});

  @override
  ConsumerState<ClubScheduleCalendarView> createState() => _ClubScheduleCalendarViewState();
}

class _ClubScheduleCalendarViewState extends ConsumerState<ClubScheduleCalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _lastSelectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _setSelectedDay(_selectedDay!);
  }

  @override
  Widget build(BuildContext context) {
    final scheduleListData = ref.watch(scheduleListProvider(_focusedDay));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClubScheduleTableCalendar(
          focusedDay: _focusedDay,
          selectedDay: _selectedDay,
          onDaySelected: _onDaySelected,
          onPageChanged: _onPageChanged,
          eventLoader: _eventLoader,
          onTodayButtonPressed: _onTodayButtonPressed,
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
            DateFormat('d일 EEEE', 'ko_KR').format(_selectedDay!),
            style: context.textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: scheduleListData.when(
            data: (scheduleList) {
              final filteredScheduleList = scheduleList.where((schedule) {
                return isSameDay(schedule.scheduleDateTime, _selectedDay);
              }).toList()
                ..sort((a, b) => a.scheduleDateTime!.compareTo(b.scheduleDateTime!));

              if (filteredScheduleList.isEmpty) {
                return Center(
                  child: Text(
                    '등록된 일정이 없어요',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                );
              }

              return CustomRefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 500));
                  ref.invalidate(scheduleListProvider(_focusedDay));
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                  itemCount: filteredScheduleList.length,
                  itemBuilder: (context, index) {
                    return ClubScheduleListTile(schedule: filteredScheduleList[index]);
                  },
                ),
              );
            },
            loading: () => CustomLoadingSkeleton(
              isLoading: true,
              child: ListView.separated(
                separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ClubScheduleListTile(
                    schedule: Schedule(
                      scheduleId: index,
                      scheduleTitle: '일정 제목',
                      scheduleDateTime: DateTime.now(),
                      scheduleColor: 'FF000000',
                    ),
                  );
                },
              ),
            ),
            error: (error, stack) => Center(
              child: Text(
                '일정을 불러오는 중 오류가 발생했어요\n다시 시도해 주세요',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _setSelectedDay(DateTime selectedDay) async {
    ref.read(scheduleSelectedDayProvider.notifier).state = _selectedDay;
  }

  List<Schedule> _eventLoader(DateTime day) {
    final scheduleListData = ref.watch(scheduleListProvider(_focusedDay));

    return scheduleListData.maybeWhen(
      data: (scheduleList) {
        return scheduleList.where((schedule) {
          return isSameDay(schedule.scheduleDateTime, day);
        }).toList();
      },
      orElse: () => [],
    );
  }

  void _onPageChanged(DateTime focusedDay) {
    final now = DateTime.now();

    if (focusedDay.year == now.year && focusedDay.month == now.month) {
      setState(() {
        _focusedDay = now;
        _selectedDay = now;
      });
    } else {
      final firstDayOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
      setState(() {
        _focusedDay = firstDayOfMonth;
        _selectedDay = firstDayOfMonth;
      });
    }

    ref.invalidate(scheduleListProvider(_focusedDay));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (_selectedDay != null &&
        isSameDay(_selectedDay, selectedDay) &&
        _lastSelectedDate != null &&
        DateTime.now().difference(_lastSelectedDate!) < const Duration(milliseconds: 300)) {
      _pushScheduleAddPage(context, selectedDay);
      _lastSelectedDate = null;
      return;
    }

    setState(() {
      _selectedDay = selectedDay;
      _lastSelectedDate = DateTime.now();
    });

    _setSelectedDay(selectedDay);
  }

  void _onTodayButtonPressed() {
    setState(() {
      _focusedDay = DateTime.now();
      _selectedDay = _focusedDay;
    });
  }

  void _pushScheduleAddPage(BuildContext context, DateTime? selectedDay) {
    final DateTime initialScheduleDateTime = DateTime(
      selectedDay?.year ?? DateTime.now().year,
      selectedDay?.month ?? DateTime.now().month,
      selectedDay?.day ?? DateTime.now().day,
      9,
      0,
    );

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ClubScheduleAddPage(
          initialScheduleDateTime: initialScheduleDateTime,
        ),
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var curve = CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.fastOutSlowIn,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curve),
            child: child,
          );
        },
      ),
    );
  }
}
