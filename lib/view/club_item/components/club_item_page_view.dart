import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../view_model/item/item_list_provider.dart';
import '../../themes/spacing.dart';

class ClubItemPageView extends ConsumerWidget {
  final String? filterCategory;
  final ScrollController? scrollController;

  const ClubItemPageView({
    super.key,
    this.filterCategory,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: defaultPaddingM,
        left: defaultPaddingM,
        right: defaultPaddingM,
      ),
      child: FutureBuilder(
        future: ref.watch(itemListProvider.future),
        builder: (context, itemListSnapshot) {
          if (itemListSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!itemListSnapshot.hasData) {
            return Center(child: Text('등록된 동아리 물품이 없어요', style: context.textTheme.bodyLarge));
          } else {
            final itemList = itemListSnapshot.data;

            final filteredList = filterCategory != null
                ? itemList!.where((item) => item.itemCategory == filterCategory).toList()
                : itemList;

            if (filteredList!.isEmpty) {
              return Center(child: Text('등록된 동아리 물품이 없어요', style: context.textTheme.bodyLarge));
            }

            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(itemListProvider);
              },
              child: ListView.separated(
                controller: scrollController,
                separatorBuilder: (context, index) => const Gap(defaultGapXL),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final CachedNetworkImageProvider imageProvider =
                      CachedNetworkImageProvider(filteredList[index].itemPhoto!);
                  final DateTime itemRentalDate = DateTime.parse(filteredList[index].itemRentalDate! as String);

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Gap(defaultGapM),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: defaultPaddingXS / 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(filteredList[index].itemName!, style: context.textTheme.bodyLarge),
                            const Gap(defaultGapS / 4),
                            Row(
                              children: [
                                Text(
                                  filteredList[index].itemCategory!,
                                  style: context.textTheme.labelLarge?.copyWith(
                                    color: context.colorScheme.outline,
                                  ),
                                ),
                                const Gap(defaultGapS / 2),
                                SizedBox(
                                  height: 8,
                                  child: VerticalDivider(
                                    color: context.colorScheme.outline,
                                    thickness: 1,
                                    width: 1,
                                  ),
                                ),
                                const Gap(defaultGapS / 2),
                                Text(
                                  filteredList[index].itemLocation!,
                                  style: context.textTheme.labelLarge?.copyWith(
                                    color: context.colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(defaultGapS / 4),
                            (filteredList[index].itemUsing!)
                                ? Text(
                                    '대여중',
                                    style: context.textTheme.labelLarge?.copyWith(
                                      color: context.colorScheme.error,
                                    ),
                                  )
                                : const SizedBox(),
                            const Gap(defaultGapS / 4),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                children: [
                                  Icon(
                                    Symbols.history_rounded,
                                    color: context.colorScheme.outline,
                                    size: 16,
                                  ),
                                  const Gap(defaultGapS / 4),
                                  Text(
                                    DateFormat('M월 d일').format(itemRentalDate),
                                    style: context.textTheme.labelLarge?.copyWith(
                                      color: context.colorScheme.outline,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
