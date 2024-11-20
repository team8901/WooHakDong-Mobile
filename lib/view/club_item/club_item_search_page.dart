import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/item/item_provider.dart';
import '../../view_model/item/item_search_provider.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import 'club_item_detail_page.dart';
import 'components/list_tile/club_item_search_list_tile.dart';

class ClubItemSearchPage extends ConsumerStatefulWidget {
  const ClubItemSearchPage({super.key});

  @override
  ConsumerState<ClubItemSearchPage> createState() => _ClubItemSearchPageState();
}

class _ClubItemSearchPageState extends ConsumerState<ClubItemSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemSearchedResults = ref.watch(itemSearchProvider(_searchController.text));

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40.h,
          child: SearchBar(
            hintText: '물품 이름 검색',
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            controller: _searchController,
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            autoFocus: true,
            trailing: [
              if (_searchController.text.isEmpty)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Symbols.search_rounded),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                )
              else
                IconButton(
                  onPressed: () {
                    _searchController.clear();
                  },
                  icon: const Icon(Symbols.close_rounded),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
        ),
      ),
      body: _searchController.text.isEmpty
          ? const SizedBox()
          : itemSearchedResults.when(
              data: (searchedItem) {
                if (searchedItem.isEmpty) {
                  return Center(
                    child: Text(
                      '물품 검색 결과가 없어요',
                      style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                    ),
                  );
                }

                return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                  itemCount: searchedItem.length,
                  itemBuilder: (context, index) => ClubItemSearchListTile(
                    searchedItem: searchedItem[index],
                    onTap: () async => await _pushItemDetailPage(
                      ref,
                      context,
                      searchedItem[index].itemId!,
                      searchedItem[index].itemOverdue!,
                    ),
                  ),
                );
              },
              loading: () => CustomProgressIndicator(indicatorColor: context.colorScheme.surfaceContainer),
              error: (err, stack) => Center(
                child: Text(
                  '검색 중 오류가 발생했어요\n다시 시도해 주세요',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 150), () {
      setState(() {});
    });
  }

  Future<void> _pushItemDetailPage(WidgetRef ref, BuildContext context, int itemId, bool itemOverdue) async {
    await ref.read(itemProvider.notifier).getItemInfo(itemId);

    if (context.mounted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ClubItemDetailPage(itemOverdue: itemOverdue),
        ),
      );
    }
  }
}
