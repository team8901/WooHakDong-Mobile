import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woohakdong/view/club_schedule/components/calendar/club_schedule_table_calendar_month.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_refresh_indicator.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/schedule/components/schedule_selected_day_provider.dart';

import '../../../../model/schedule/schedule.dart';
import '../../../../view_model/schedule/schedule_list_provider.dart';
import '../../../../view_model/schedule/schedule_provider.dart';
import '../../../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../../../themes/custom_widget/interaction/custom_loading_skeleton.dart';
import '../../club_schedule_add_page.dart';
import '../../club_schedule_detail_page.dart';
import '../club_schedule_list_tile.dart';

class ClubScheduleCalendarMonthView extends ConsumerStatefulWidget {
  const ClubScheduleCalendarMonthView({super.key});

  @override
  ConsumerState createState() => _ClubScheduleCalendarMonthViewState();
}

class _ClubScheduleCalendarMonthViewState extends ConsumerState<ClubScheduleCalendarMonthView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime _baseDate = DateTime.now();
  late PageController _pageController;
  late int _initialPage;
  late DateTime _currentDate;
  DateTime? _lastSelectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _setSelectedDay(_selectedDay!);
    _initialPage = 5000;
    _pageController = PageController(initialPage: _initialPage);
    _currentDate = _selectedDay!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClubScheduleTableCalendarMonth(
          focusedDay: _focusedDay,
          selectedDay: _selectedDay,
          onDaySelected: _onDaySelected,
          onPageChanged: _onPageChanged,
          eventLoader: _eventLoader,
          onTodayButtonPressed: _onTodayButtonPressed,
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
      data: (threeMonthSchedule) {
        final allSchedules = [
          ...threeMonthSchedule.previousMonth,
          ...threeMonthSchedule.currentMonth,
          ...threeMonthSchedule.nextMonth,
        ];

        return allSchedules.where((schedule) {
          return isSameDay(schedule.scheduleDateTime, day);
        }).toList();
      },
      orElse: () => [],
    );
  }

  void _onPageChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _selectedDay = _focusedDay;
    });

    _setSelectedDay(_selectedDay!);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final scheduleListData = ref.watch(scheduleListProvider(_focusedDay));

    final hasEvents = scheduleListData.maybeWhen(
      data: (threeMonthSchedule) {
        final allSchedules = [
          ...threeMonthSchedule.previousMonth,
          ...threeMonthSchedule.currentMonth,
          ...threeMonthSchedule.nextMonth,
        ];

        return allSchedules.any((schedule) => isSameDay(schedule.scheduleDateTime, selectedDay));
      },
      orElse: () => false,
    );

    if (!hasEvents) {
      if (_selectedDay != null && isSameDay(_selectedDay, selectedDay) && _lastSelectedDate != null) {
        _pushScheduleAddPage(context, selectedDay);
        _lastSelectedDate = null;
        return;
      }

      setState(() {
        _selectedDay = selectedDay;
        _baseDate = selectedDay;
        _currentDate = selectedDay;
        _lastSelectedDate = DateTime.now();
      });
      _setSelectedDay(selectedDay);
      return;
    }

    setState(() {
      _selectedDay = selectedDay;
      _baseDate = selectedDay;
      _currentDate = selectedDay;
      _lastSelectedDate = DateTime.now();
    });

    _setSelectedDay(selectedDay);
    _showScheduleDialog();
  }

  void _onTodayButtonPressed() {
    setState(() {
      _focusedDay = DateTime.now();
      _selectedDay = _focusedDay;
    });

    _setSelectedDay(_selectedDay!);
  }

  Future<void> _pushScheduleDetailPage(WidgetRef ref, BuildContext context, int scheduleId) async {
    await ref.read(scheduleProvider.notifier).getScheduleInfo(scheduleId);

    if (context.mounted) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => const ClubScheduleDetailPage(),
        ),
      );
    }
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

  void _showScheduleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: defaultPaddingL),
          backgroundColor: context.colorScheme.surfaceBright,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) async {
                DateTime newDate = _getDateFromIndex(index);

                if (newDate.month != _currentDate.month) {
                  setState(() {
                    _currentDate = newDate;
                    _selectedDay = newDate;
                    _focusedDay = newDate;
                  });
                  _setSelectedDay(newDate);
                } else {
                  setState(() {
                    _currentDate = newDate;
                    _selectedDay = newDate;
                  });
                  _setSelectedDay(newDate);
                }
              },
              itemBuilder: (context, index) {
                DateTime today = _getDateFromIndex(index);

                return Consumer(
                  builder: (context, ref, child) {
                    final scheduleListData = ref.watch(scheduleListProvider(_focusedDay));

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: defaultPaddingXS),
                      child: Row(
                        children: [
                          const Gap(defaultGapS / 2),
                          Icon(Symbols.chevron_left_rounded, size: 12, color: context.colorScheme.onSurface),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: defaultPaddingM, left: defaultPaddingM),
                                  child: Text(
                                    DateFormat('d일 EEEE', 'ko_KR').format(today),
                                    style: context.textTheme.titleLarge?.copyWith(
                                      color: (today.day == DateTime.now().day)
                                          ? context.colorScheme.primary
                                          : context.textTheme.titleLarge?.color,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Stack(
                                    children: [
                                      scheduleListData.when(
                                        data: (threeMonthSchedule) {
                                          final allSchedules = [
                                            ...threeMonthSchedule.previousMonth,
                                            ...threeMonthSchedule.currentMonth,
                                            ...threeMonthSchedule.nextMonth,
                                          ];

                                          final filteredScheduleList = allSchedules.where((schedule) {
                                            return isSameDay(schedule.scheduleDateTime, today);
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
                                                return ClubScheduleListTile(
                                                  schedule: filteredScheduleList[index],
                                                  onTap: () => _pushScheduleDetailPage(
                                                      ref, context, filteredScheduleList[index].scheduleId!),
                                                );
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
                                                  scheduleTitle: '일정 제목입니다',
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
                                      Positioned(
                                        right: -8,
                                        bottom: defaultPaddingM / 2,
                                        child: ElevatedButton(
                                          onPressed: () => _pushScheduleAddPage(context, today),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: context.colorScheme.primary,
                                            foregroundColor: context.colorScheme.inversePrimary,
                                            shape: const CircleBorder(),
                                            elevation: 3,
                                          ),
                                          child: const Icon(Symbols.calendar_add_on_rounded),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Symbols.chevron_right_rounded, size: 12, color: context.colorScheme.onSurface),
                          const Gap(defaultGapS / 2),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  DateTime _getDateFromIndex(int index) {
    int dayDifference = index - _initialPage;
    return _baseDate.add(Duration(days: dayDifference));
  }
}
