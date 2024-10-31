import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_loading_skeleton.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/item/item_provider.dart';
import '../themes/custom_widget/etc/custom_divider.dart';
import 'components/club_item_history_list_tile.dart';

class ClubItemHistoryPage extends ConsumerWidget {
  final int itemId;

  const ClubItemHistoryPage({
    super.key,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('대여 내역'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: FutureBuilder(
            future: ref.watch(itemProvider.notifier).getItemHistoryList(itemId),
            builder: (context, itemListSnapshot) {
              final isLoading = itemListSnapshot.connectionState == ConnectionState.waiting;

              final itemHistoryList = isLoading ? generateFakeItemHistory(10) : itemListSnapshot.data;

              if (itemHistoryList!.isEmpty) {
                return Center(
                  child: Text(
                    '아직 대여한 내역이 없어요',
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
                    itemCount: itemHistoryList.length,
                    itemBuilder: (context, index) {
                      final reversedItemHistoryList = itemHistoryList[itemHistoryList.length - 1 - index];

                      return ClubItemHistoryListTile(itemHistory: reversedItemHistoryList);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<ItemHistory> generateFakeItemHistory(int count) {
    return List.generate(count, (index) {
      return ItemHistory(
        memberName: '우학동',
        itemRentalDate: DateTime.now(),
        itemReturnDate: DateTime.now(),
      );
    });
  }
}
