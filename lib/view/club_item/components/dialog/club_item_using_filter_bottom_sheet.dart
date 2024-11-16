import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../model/item/item_filter.dart';
import '../../../../view_model/item/item_filter_provider.dart';
import '../../../themes/spacing.dart';
import '../button/club_item_filter_sheet_button.dart';

class ClubItemUsingFilterBottomSheet extends ConsumerWidget {
  const ClubItemUsingFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.32,
      child: Consumer(
        builder: (context, ref, child) {
          final filter = ref.watch(itemFilterProvider);

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingM,
              vertical: defaultPaddingS / 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '물품 상태 선택',
                  style: context.textTheme.titleLarge,
                ),
                const Gap(defaultGapXL),
                Text(
                  '대여 상태',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                Row(
                  children: [
                    ClubItemFilterSheetButton(
                      label: '보관 중',
                      selected: filter.using == false,
                      onTap: () {
                        final isCurrentlySelected = filter.using == false;
                        (isCurrentlySelected)
                            ? ref.read(itemFilterProvider.notifier).state = ItemFilter(
                                category: ref.read(itemFilterProvider).category,
                                using: null,
                                available: ref.read(itemFilterProvider).available,
                              )
                            : ref.read(itemFilterProvider.notifier).state = filter.copyWith(using: false);
                      },
                    ),
                    const Gap(defaultGapS),
                    ClubItemFilterSheetButton(
                      label: '대여 중',
                      selected: filter.using == true,
                      onTap: () {
                        final isCurrentlySelected = filter.using == true;
                        (isCurrentlySelected)
                            ? ref.read(itemFilterProvider.notifier).state = ItemFilter(
                                category: ref.read(itemFilterProvider).category,
                                using: null,
                                available: ref.read(itemFilterProvider).available,
                              )
                            : ref.read(itemFilterProvider.notifier).state = filter.copyWith(using: true);
                      },
                    ),
                  ],
                ),
                const Gap(defaultGapXL),
                Text(
                  '대여 가능 여부',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                Row(
                  children: [
                    ClubItemFilterSheetButton(
                      label: '대여 가능',
                      selected: filter.available == true,
                      onTap: () {
                        final isCurrentlySelected = filter.available == true;
                        (isCurrentlySelected)
                            ? ref.read(itemFilterProvider.notifier).state = ItemFilter(
                                category: ref.read(itemFilterProvider).category,
                                using: ref.read(itemFilterProvider).using,
                                available: null,
                              )
                            : ref.read(itemFilterProvider.notifier).state = filter.copyWith(available: true);
                      },
                    ),
                    const Gap(defaultGapS),
                    ClubItemFilterSheetButton(
                      label: '대여 불가',
                      selected: filter.available == false,
                      onTap: () {
                        final isCurrentlySelected = filter.available == false;
                        (isCurrentlySelected)
                            ? ref.read(itemFilterProvider.notifier).state = ItemFilter(
                                category: ref.read(itemFilterProvider).category,
                                using: ref.read(itemFilterProvider).using,
                                available: null,
                              )
                            : ref.read(itemFilterProvider.notifier).state = filter.copyWith(available: false);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
