import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_calendar/club_calendar_page.dart';
import 'package:woohakdong/view/club_dues/club_dues_page.dart';
import 'package:woohakdong/view/club_information/club_information_page.dart';
import 'package:woohakdong/view/club_item/club_item_list_page.dart';
import 'package:woohakdong/view/club_member/club_member_list_page.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../view_model/club/current_club_provider.dart';

class RoutePage extends ConsumerStatefulWidget {
  const RoutePage({super.key});

  @override
  ConsumerState<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends ConsumerState<RoutePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const ClubMemberListPage(),
    const ClubItemListPage(),
    const ClubDuesPage(),
    const ClubCalendarPage(),
    const ClubInformationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final String? clubImage = ref.watch(currentClubProvider)?.clubImage;

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.colorScheme.surfaceContainer,
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Symbols.group_rounded),
              label: '회원',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Symbols.list_alt_rounded),
              label: '물품',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Symbols.wallet_rounded),
              label: '회비',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Symbols.calendar_month_rounded),
              label: '일정',
            ),
            BottomNavigationBarItem(
              icon: clubImage != null
                  ? Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedIndex == 4 ? context.colorScheme.inverseSurface : context.colorScheme.outline,
                          width: 1,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(clubImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const Icon(Symbols.more_horiz_rounded),
              label: '내 동아리',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }
}
