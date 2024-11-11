import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/item/item_history_list_provider.dart';

import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import 'components/list_tile/club_item_history_list_tile.dart';

class ClubItemHistoryPage extends ConsumerWidget {
  final int itemId;

  const ClubItemHistoryPage({
    super.key,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemHistoryListData = ref.watch(itemHistoryListProvider(itemId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('대여 내역'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: itemHistoryListData.when(
            data: (itemHistoryList) {
              if (itemHistoryList.isEmpty) {
                return Center(
                  child: Text(
                    '아직 대여한 내역이 없어요',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                );
              }

              return CustomMaterialIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 500));
                  ref.refresh(itemHistoryListProvider(itemId));
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                  itemCount: itemHistoryList.length,
                  itemBuilder: (context, index) => ClubItemHistoryListTile(itemHistory: itemHistoryList[index]),
                ),
              );
            },
            loading: () => CustomLoadingSkeleton(
              isLoading: true,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                itemCount: 10,
                itemBuilder: (context, index) => ClubItemHistoryListTile(
                  itemHistory: ItemHistory(
                    memberName: '우학동',
                    itemRentalDate: DateTime.now(),
                    itemReturnDate: DateTime.now(),
                  ),
                ),
              ),
            ),
            error: (error, stack) => Center(
              child: Text(
                '대여 목록을 불러오는 중 오류가 발생했어요\n다시 시도해 주세요',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
