import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_item/club_item_add_page.dart';
import 'package:woohakdong/view/club_item/components/club_item_page_view.dart';

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
  final ScrollController scrollController = ScrollController();
  bool isFabExtended = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('물품'),
        actions: [
          IconButton(
            onPressed: () {},
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
                physics: const ClampingScrollPhysics(),
                children: [
                  ClubItemPageView(scrollController: scrollController),
                  ClubItemPageView(filterCategory: 'DIGITAL', scrollController: scrollController),
                  ClubItemPageView(filterCategory: 'SPORT', scrollController: scrollController),
                  ClubItemPageView(filterCategory: 'BOOK', scrollController: scrollController),
                  ClubItemPageView(filterCategory: 'CLOTHES', scrollController: scrollController),
                  ClubItemPageView(filterCategory: 'STATIONERY', scrollController: scrollController),
                  ClubItemPageView(filterCategory: 'ETC', scrollController: scrollController),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _pushItemAddPage(context),
        label: const Text('물품 추가'),
        icon: const Icon(Symbols.add_rounded),
        isExtended: isFabExtended,
      ),
    );
  }

  void _pushItemAddPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          var curve = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuad,
            reverseCurve: Curves.easeOutQuad,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curve),
            child: const ClubItemAddPage(),
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (isFabExtended) setState(() => isFabExtended = false);
    } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!isFabExtended) setState(() => isFabExtended = true);
    }
  }
}
