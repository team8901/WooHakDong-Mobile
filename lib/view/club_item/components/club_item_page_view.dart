import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../service/general/general_functions.dart';
import '../../../view_model/item/item_provider.dart';
import '../../themes/custom_widget/etc/custom_divider.dart';
import '../../themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'club_item_list_tile.dart';

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
        future: ref.watch(itemProvider.notifier).getItemList(),
        builder: (context, itemListSnapshot) {
          final isLoading = itemListSnapshot.connectionState == ConnectionState.waiting;

          final itemList = itemListSnapshot.data;

          final filteredList = isLoading
              ? generateFakeItem(10)
              : filterCategory != null
                  ? itemList!.where((item) => item.itemCategory == filterCategory).toList()
                  : itemList;

          if (!isLoading && (itemList == null || itemList.isEmpty)) {
            return Center(
              child: Text(
                '아직 등록된 물품이 없어요',
                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
              ),
            );
          } else if (!isLoading && (filteredList == null || filteredList.isEmpty)) {
            return Center(
              child: Text(
                '${GeneralFunctions.formatItemCategory(filterCategory!)} 카테고리에 등록된 물품이 없어요',
                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
              ),
            );
          }

          return CustomMaterialIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 750));
              ref.refresh(itemProvider);
            },
            child: CustomLoadingSkeleton(
              isLoading: isLoading,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const CustomDivider(),
                itemCount: filteredList!.length,
                itemBuilder: (context, index) => ClubItemListTile(item: filteredList[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Item> generateFakeItem(int count) {
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
