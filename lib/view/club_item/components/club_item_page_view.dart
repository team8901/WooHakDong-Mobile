import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_refresh_indicator.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../service/general/general_functions.dart';
import '../../../view_model/item/item_list_provider.dart';
import '../../../view_model/item/item_provider.dart';
import '../../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../../themes/custom_widget/interaction/custom_loading_skeleton.dart';
import '../club_item_detail_page.dart';
import 'list_tile/club_item_list_tile.dart';

class ClubItemPageView extends ConsumerWidget {
  final String? filterCategory;

  const ClubItemPageView({
    super.key,
    this.filterCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListData = ref.watch(itemListProvider(filterCategory));

    return SizedBox(
      width: double.infinity,
      child: itemListData.when(
        data: (itemList) {
          if (itemList.isEmpty) {
            return Center(
              child: Text(
                (filterCategory == null)
                    ? '아직 등록된 물품이 없어요'
                    : '${GeneralFunctions.formatItemCategory(filterCategory!)} 카테고리에 등록된 물품이 없어요',
                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
              ),
            );
          }

          return CustomRefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 500));
              ref.invalidate(itemListProvider(filterCategory));
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const CustomHorizontalDivider(),
              itemCount: itemList.length,
              itemBuilder: (context, index) => ClubItemListTile(
                item: itemList[index],
                onTap: () async => await _pushItemDetailPage(ref, context, itemList[index].itemId!),
              ),
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

  Future<void> _pushItemDetailPage(WidgetRef ref, BuildContext context, int itemId) async {
    await ref.read(itemProvider.notifier).getItemInfo(itemId);

    if (context.mounted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const ClubItemDetailPage(),
        ),
      );
    }
  }
}
