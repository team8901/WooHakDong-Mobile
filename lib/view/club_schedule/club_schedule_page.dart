import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_schedule/club_schedule_add_page.dart';
import 'package:woohakdong/view/club_schedule/components/club_schedule_calendar_view.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('일정'),
        actions: [
          /// 캘린더 뷰 말고 한 달 전체 일정 볼 수 있게 추가
          IconButton(
            onPressed: () => _pushScheduleAddPage(context, selectedDay),
            icon: Icon(
              Symbols.add_rounded,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
      body: const SafeArea(child: ClubScheduleCalendarView()),
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
