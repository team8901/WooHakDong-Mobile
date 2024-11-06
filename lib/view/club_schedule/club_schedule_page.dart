import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_schedule/club_schedule_add_page.dart';
import 'package:woohakdong/view/club_schedule/components/club_schedule_calendar_view.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class ClubSchedulePage extends ConsumerStatefulWidget {
  const ClubSchedulePage({super.key});

  @override
  ConsumerState<ClubSchedulePage> createState() => _ClubSchedulePageState();
}

class _ClubSchedulePageState extends ConsumerState<ClubSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일정'),
        actions: [
          IconButton(
            onPressed: () => _pushScheduleAddPage(context),
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

  void _pushScheduleAddPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ClubScheduleAddPage(),
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
