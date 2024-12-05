import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/item/item_entire_history_list_provider.dart';

import '../../view_model/club_member/club_member_provider.dart';
import '../../view_model/item/item_provider.dart';
import '../club_member/club_member_detail_page.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../themes/custom_widget/interaction/custom_loading_skeleton.dart';
import '../themes/spacing.dart';
import 'club_item_detail_page.dart';
import 'components/dialog/club_item_entire_history_dialog.dart';
import 'components/list_tile/club_item_entire_history_list_tile.dart';

class ClubItemHistoryPage extends ConsumerWidget {
  const ClubItemHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemEntireHistoryListData = ref.watch(itemEntireHistoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('전체 물품 대여 내역'),
      ),
      body: SafeArea(
        child: itemEntireHistoryListData.when(
          data: (itemEntireHistoryList) {
            if (itemEntireHistoryList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(defaultPaddingM),
                child: Center(
                  child: Text(
                    '아직 대여 내역이 없어요',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            }

            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const CustomHorizontalDivider(),
              itemCount: itemEntireHistoryList.length,
              itemBuilder: (context, index) => ClubItemEntireHistoryListTile(
                itemHistory: itemEntireHistoryList[index],
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => ClubItemEntireHistoryDialog(
                    itemHistory: itemEntireHistoryList[index],
                    context: context,
                    onItemDetailTap: () async => await _pushItemDetailPage(
                      ref,
                      context,
                      itemEntireHistoryList[index].itemId!,
                      itemEntireHistoryList[index].itemOverdue!,
                    ),
                    onMemberDetailTap: () async => await _pushMemberDetailPage(
                      ref,
                      context,
                      itemEntireHistoryList[index].clubMemberId!,
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => CustomLoadingSkeleton(
            isLoading: true,
            child: ListView.separated(
              separatorBuilder: (context, index) => const CustomHorizontalDivider(),
              itemCount: 50,
              itemBuilder: (context, index) {
                return ClubItemEntireHistoryListTile(
                  itemHistory: ItemHistory(
                    itemName: '아이템 이름',
                    memberName: '우학동',
                    itemReturnDate: DateTime.now(),
                    itemDueDate: DateTime.now(),
                    itemRentalDate: DateTime.now(),
                  ),
                );
              },
            ),
          ),
          error: (error, stack) => Center(
            child: Text(
              '전체 물품 대여 내역을 불러오는 중 오류가 발생했어요\n다시 시도해 주세요',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pushItemDetailPage(WidgetRef ref, BuildContext context, int itemId, bool itemOverdue) async {
    await ref.read(itemProvider.notifier).getItemInfo(itemId);

    if (context.mounted) {
      Navigator.pop(context);

      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ClubItemDetailPage(itemOverdue: itemOverdue),
        ),
      );
    }
  }

  Future<void> _pushMemberDetailPage(WidgetRef ref, BuildContext context, int clubMemberId) async {
    await ref.read(clubMemberProvider.notifier).getClubMemberInfo(clubMemberId);

    if (context.mounted) {
      Navigator.pop(context);

      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => const ClubMemberDetailPage(),
        ),
      );
    }
  }
}
