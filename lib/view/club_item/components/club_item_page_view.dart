import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_refresh_indicator.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../service/general/general_format.dart';
import '../../../service/general/general_functions.dart';
import '../../../view_model/item/item_filter_provider.dart';
import '../../../view_model/item/item_list_provider.dart';
import '../../../view_model/item/item_provider.dart';
import '../../themes/custom_widget/dialog/custom_interaction_dialog.dart';
import '../../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../../themes/custom_widget/interaction/custom_loading_skeleton.dart';
import '../club_item_detail_page.dart';
import '../club_item_edit_page.dart';
import 'list_tile/club_item_list_tile.dart';

class ClubItemPageView extends ConsumerStatefulWidget {
  const ClubItemPageView({super.key});

  @override
  ConsumerState<ClubItemPageView> createState() => _ClubItemPageViewState();
}

class _ClubItemPageViewState extends ConsumerState<ClubItemPageView> {
  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(itemFilterProvider);
    final itemListData = ref.watch(itemListProvider(filter));

    return SizedBox(
      width: double.infinity,
      child: itemListData.when(
        data: (itemList) {
          if (itemList.isEmpty) {
            return Center(
              child: Text(
                (filter.category == null && filter.using == null && filter.available == null && filter.overdue == null)
                    ? '아직 등록된 물품이 없어요'
                    : (filter.using != null || filter.available != null || filter.overdue != null)
                        ? '선택한 상태에 맞는 물품이 없어요'
                        : '${GeneralFormat.formatItemCategory(filter.category!)} 카테고리에 등록된 물품이 없어요',
                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
              ),
            );
          }

          return CustomRefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 500));
              ref.invalidate(itemListProvider(filter));
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const CustomHorizontalDivider(),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final item = itemList[index];
                return ClubItemListTile(
                  item: itemList[index],
                  onTap: () async => await _pushItemDetailPage(ref, context, item),
                  onToggleLongPress: () async => await _toggleItemRentAvailable(context, ref, item),
                  onEditLongPress: () => _pushItemEditPage(context, item),
                  onDeleteLongPress: () async => await _deleteItem(context, ref, item),
                );
              },
            ),
          );
        },
        loading: () => CustomLoadingSkeleton(
          isLoading: true,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const CustomHorizontalDivider(),
            itemCount: 10,
            itemBuilder: (context, index) => ClubItemListTile(
              item: Item(
                itemName: '자바의 정석',
                itemCategory: 'DIGITAL',
                itemLocation: '동아리 방',
                itemUsing: false,
                itemRentalTime: 0,
              ),
            ),
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            '물품 목록을 불러오는 중 오류가 발생했어요\n다시 시도해 주세요',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<void> _pushItemDetailPage(WidgetRef ref, BuildContext context, Item itemInfo) async {
    await ref.read(itemProvider.notifier).getItemInfo(itemInfo.itemId!);

    if (context.mounted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ClubItemDetailPage(itemOverdue: itemInfo.itemOverdue!),
        ),
      );
    }
  }

  Future<void> _toggleItemRentAvailable(BuildContext context, WidgetRef ref, Item itemInfo) async {
    try {
      final bool? isAvailable = await showDialog<bool>(
        context: context,
        builder: (context) => CustomInteractionDialog(
          dialogTitle: '대여 가능 여부 변경',
          dialogContent: itemInfo.itemAvailable! ? '다음 대여부터 대여 불가로 변경할게요.' : '대여 가능으로 변경할게요.',
          dialogButtonText: '변경',
          dialogButtonColor: context.colorScheme.primary,
        ),
      );

      if (isAvailable != true) return;

      await ref.read(itemProvider.notifier).toggleItemRentAvailable(itemInfo.itemId!, !itemInfo.itemAvailable!);
      GeneralFunctions.toastMessage('대여 가능 여부가 변경되었어요');
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }

  void _pushItemEditPage(BuildContext context, Item itemInfo) {
    if (itemInfo.itemUsing!) {
      GeneralFunctions.toastMessage('현재 대여 중인 물품은 수정할 수 없어요');
      return;
    }

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ClubItemEditPage(itemInfo: itemInfo),
      ),
    );
  }

  Future<void> _deleteItem(BuildContext context, WidgetRef ref, Item itemInfo) async {
    try {
      if (itemInfo.itemUsing!) {
        GeneralFunctions.toastMessage('현재 대여 중인 물품은 삭제할 수 없어요');
        return;
      }

      final bool? isDelete = await showDialog<bool>(
        context: context,
        builder: (context) => const CustomInteractionDialog(
          dialogTitle: '물품 삭제',
          dialogContent: '물품을 삭제하면 되돌릴 수 없어요.',
        ),
      );

      if (isDelete != true) return;

      await ref.read(itemProvider.notifier).deleteItem(itemInfo.itemId!);
      GeneralFunctions.toastMessage('물품이 삭제되었어요');
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }
}
