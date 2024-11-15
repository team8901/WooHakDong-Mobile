import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_schedule/club_schedule_add_page.dart';
import 'package:woohakdong/view/club_schedule/components/calendar/club_schedule_calendar_day_view.dart';
import 'package:woohakdong/view/club_schedule/components/calendar/club_schedule_calendar_month_view.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/schedule/schedule_calendar_view_provider.dart';

import '../../view_model/schedule/components/schedule_selected_day_provider.dart';

class ClubSchedulePage extends ConsumerStatefulWidget {
  const ClubSchedulePage({super.key});

  @override
  ConsumerState<ClubSchedulePage> createState() => _ClubSchedulePageState();
}

class _ClubSchedulePageState extends ConsumerState<ClubSchedulePage> {
  @override
  Widget build(BuildContext context) {
    final selectedDay = ref.watch(scheduleSelectedDayProvider);
    final calendarViewState = ref.watch(scheduleCalendarViewProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('일정'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(scheduleCalendarViewProvider.notifier).toggleCalendarViewState();
              ref.invalidate(scheduleSelectedDayProvider);
            },
            icon: calendarViewState.index == 0
                ? const Icon(Symbols.event_note_rounded)
                : const Icon(Symbols.event_rounded),
          ),
          IconButton(
            onPressed: () => _pushScheduleAddPage(context, selectedDay),
            icon: Icon(
              Symbols.calendar_add_on_rounded,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child:
            calendarViewState.index == 0 ? const ClubScheduleCalendarDayView() : const ClubScheduleCalendarMonthView(),
      ),
    );
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
