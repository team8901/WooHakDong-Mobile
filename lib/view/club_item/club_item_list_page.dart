import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_item/club_item_add_page.dart';
import 'package:woohakdong/view/club_item/components/club_item_page_view.dart';

import 'club_item_search_page.dart';

class ClubItemListPage extends ConsumerStatefulWidget {
  const ClubItemListPage({super.key});

  @override
  ConsumerState<ClubItemListPage> createState() => _ClubItemListPageState();
}

class _ClubItemListPageState extends ConsumerState<ClubItemListPage> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 7,
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('물품'),
        actions: [
          IconButton(
            onPressed: () => _pushItemSearchPage(context),
            icon: const Icon(Symbols.search_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              isScrollable: true,
              physics: const ClampingScrollPhysics(),
              tabs: const [
                Tab(text: '전체'),
                Tab(text: '디지털'),
                Tab(text: '스포츠'),
                Tab(text: '도서'),
                Tab(text: '의류'),
                Tab(text: '문구류'),
                Tab(text: '기타'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  ClubItemPageView(),
                  ClubItemPageView(filterCategory: 'DIGITAL'),
                  ClubItemPageView(filterCategory: 'SPORT'),
                  ClubItemPageView(filterCategory: 'BOOK'),
                  ClubItemPageView(filterCategory: 'CLOTHES'),
                  ClubItemPageView(filterCategory: 'STATIONERY'),
                  ClubItemPageView(filterCategory: 'ETC'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushItemAddPage(context),
        tooltip: '동아리 물품을 추가해 보세요',
        child: const Icon(Symbols.add_rounded, weight: 600, size: 32),
      ),
    );
  }

  void _pushItemSearchPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const ClubItemSearchPage()),
    );
  }

  void _pushItemAddPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ClubItemAddPage(),
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
