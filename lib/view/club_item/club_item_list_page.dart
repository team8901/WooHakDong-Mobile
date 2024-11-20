import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../model/item/item_filter.dart';
import '../../view_model/item/item_filter_provider.dart';
import 'club_item_add_page.dart';
import 'club_item_search_page.dart';
import 'components/button/club_item_filter_action_button.dart';
import 'components/club_item_page_view.dart';
import 'components/dialog/club_item_using_filter_bottom_sheet.dart';

class ClubItemListPage extends ConsumerStatefulWidget {
  const ClubItemListPage({super.key});

  @override
  ConsumerState<ClubItemListPage> createState() => _ClubItemListPageState();
}

class _ClubItemListPageState extends ConsumerState<ClubItemListPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final categories = const [
    null,
    'DIGITAL',
    'SPORT',
    'BOOK',
    'CLOTHES',
    'STATIONERY',
    'ETC',
  ];

  @override
  void initState() {
    super.initState();

    final filter = ref.read(itemFilterProvider);
    final selectedCategory = filter.category;
    final initialIndex = categories.indexOf(selectedCategory);

    tabController = TabController(
      length: categories.length,
      vsync: this,
      initialIndex: initialIndex,
    );

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        final selectedCategory = categories[tabController.index];

        ref.read(itemFilterProvider.notifier).state = ItemFilter(
          category: selectedCategory,
          using: ref.read(itemFilterProvider).using,
          available: ref.read(itemFilterProvider).available,
          overdue: ref.read(itemFilterProvider).overdue,
        );
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(itemFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('물품'),
        actions: [
          IconButton(
            onPressed: () => _pushItemSearchPage(context),
            icon: const Icon(Symbols.search_rounded),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
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
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            toolbarHeight: 52,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: ClubItemFilterActionButton(
              filter: filter,
              onFilterTap: () => showModalBottomSheet(
                useSafeArea: true,
                context: context,
                builder: (BuildContext context) {
                  return const ClubItemUsingFilterBottomSheet();
                },
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: tabController,
          children: List.generate(
            categories.length,
            (index) => const ClubItemPageView(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushItemAddPage(context, categories[tabController.index]),
        child: const Icon(Symbols.add_2_rounded, weight: 600, size: 28),
      ),
    );
  }

  void _pushItemSearchPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const ClubItemSearchPage()),
    );
  }

  void _pushItemAddPage(BuildContext context, String? category) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ClubItemAddPage(
          initialCategory: category,
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
