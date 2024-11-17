import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_dues/club_dues_page.dart';
import 'package:woohakdong/view/club_item/club_item_list_page.dart';
import 'package:woohakdong/view/club_member/club_member_list_page.dart';
import 'package:woohakdong/view/club_schedule/club_schedule_page.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_pop_scope.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/current_club_info_provider.dart';

import 'club_info/club_info_page.dart';

class NavigatorPage extends ConsumerStatefulWidget {
  const NavigatorPage({super.key});

  @override
  ConsumerState<NavigatorPage> createState() => _RoutePageState();
}

class _RoutePageState extends ConsumerState<NavigatorPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const ClubMemberListPage(),
    const ClubItemListPage(),
    const ClubDuesPage(),
    const ClubSchedulePage(),
    const ClubInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final String? clubImage = ref.watch(currentClubInfoProvider).clubImage;

    return Scaffold(
      body: CustomPopScope(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.colorScheme.surfaceContainer,
              width: 0.6,
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Symbols.group_rounded,
                fill: 1,
              ),
              label: '회원',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Symbols.list_alt_rounded,
                fill: 1,
              ),
              label: '물품',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Symbols.savings_rounded,
                fill: 1,
              ),
              label: '회비',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Symbols.calendar_month_rounded,
                fill: 1,
              ),
              label: '일정',
            ),
            BottomNavigationBarItem(
              icon: clubImage != null
                  ? Container(
                      width: 24.r,
                      height: 24.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedIndex == 4 ? context.colorScheme.inverseSurface : context.colorScheme.outline,
                          width: _selectedIndex == 4 ? 2 : 1,
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(clubImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: 24.r,
                      height: 24.r,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 4 ? context.colorScheme.inverseSurface : context.colorScheme.outline,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedIndex == 4 ? context.colorScheme.inverseSurface : context.colorScheme.outline,
                          width: 1,
                        ),
                      ),
                    ),
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
