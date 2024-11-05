import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../service/general/general_functions.dart';
import '../../../view_model/item/item_provider.dart';
import '../../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../../themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'list_tile/club_item_list_tile.dart';

class ClubItemPageView extends ConsumerWidget {
  final String? filterCategory;

  const ClubItemPageView({
    super.key,
    this.filterCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: FutureBuilder(
        future: ref.watch(itemProvider.notifier).getItemList(null, filterCategory),
        builder: (context, itemListSnapshot) {
          final isLoading = itemListSnapshot.connectionState == ConnectionState.waiting;

          final itemList = isLoading ? _generateFakeItem(10) : itemListSnapshot.data;

          if (!isLoading && (itemList == null || itemList.isEmpty)) {
            return Center(
              child: Text(
                (filterCategory == null)
                    ? '아직 등록된 물품이 없어요'
                    : '${GeneralFunctions.formatItemCategory(filterCategory!)} 카테고리에 등록된 물품이 없어요',
                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
              ),
            );
          }

          return CustomMaterialIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 500));
              ref.invalidate(itemProvider);
            },
            child: CustomLoadingSkeleton(
              isLoading: isLoading,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                itemCount: itemList!.length,
                itemBuilder: (context, index) => ClubItemListTile(item: itemList[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Item> _generateFakeItem(int count) {
    return List.generate(count, (index) {
      return Item(
        itemName: '자바의 정석',
        itemCategory: 'DIGITAL',
        itemLocation: '동아리 방',
        itemUsing: false,
        itemRentalTime: 0,
      );
    });
  }
}
