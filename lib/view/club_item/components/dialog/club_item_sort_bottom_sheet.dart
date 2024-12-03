import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/item/components/item_sort.dart';

import '../../../../model/item/item_filter.dart';
import '../../../../view_model/item/components/item_filter_provider.dart';
import '../button/club_item_sort_bottom_sheet_button.dart';

class ClubItemSortBottomSheet extends ConsumerWidget {
  final ItemFilter filter;

  const ClubItemSortBottomSheet({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: defaultPaddingM),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPaddingM,
                vertical: defaultPaddingS / 2,
              ),
              child: Text(
                '물품 정렬',
                style: context.textTheme.titleLarge,
              ),
            ),
            const Gap(defaultGapS),
            ClubItemSortBottomSheetButton(
              filter: filter,
              sortOption: ItemSortOption.oldest,
              displayText: '등록된 순',
              onTap: () => ref.read(itemFilterProvider.notifier).state = filter.copyWith(
                itemSortOption: ItemSortOption.oldest,
              ),
            ),
            const Gap(defaultGapS),
            ClubItemSortBottomSheetButton(
              filter: filter,
              sortOption: ItemSortOption.newest,
              displayText: '최신 순',
              onTap: () => ref.read(itemFilterProvider.notifier).state = filter.copyWith(
                itemSortOption: ItemSortOption.newest,
              ),
            ),
            const Gap(defaultGapS),
            ClubItemSortBottomSheetButton(
              filter: filter,
              sortOption: ItemSortOption.nameAsc,
              displayText: '이름 오름차순',
              onTap: () => ref.read(itemFilterProvider.notifier).state = filter.copyWith(
                itemSortOption: ItemSortOption.nameAsc,
              ),
            ),
            const Gap(defaultGapS),
            ClubItemSortBottomSheetButton(
              filter: filter,
              sortOption: ItemSortOption.nameDesc,
              displayText: '이름 내림차순',
              onTap: () => ref.read(itemFilterProvider.notifier).state = filter.copyWith(
                itemSortOption: ItemSortOption.nameDesc,
              ),
            ),
            const Gap(defaultGapXL),
          ],
        ),
      ),
    );
  }
}
