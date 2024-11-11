import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../model/item/item.dart';
import '../../../../service/general/general_functions.dart';
import '../../../../view_model/item/item_provider.dart';
import '../../../themes/custom_widget/etc/custom_vertical_divider.dart';
import '../../../themes/spacing.dart';
import '../../club_item_detail_page.dart';

class ClubItemSearchListTile extends ConsumerWidget {
  final Item searchedItem;

  const ClubItemSearchListTile({
    super.key,
    required this.searchedItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        await ref.read(itemProvider.notifier).getItemInfo(searchedItem.itemId!);

        if (context.mounted) {
          _pushItemDetailPage(context);
        }
      },
      highlightColor: context.colorScheme.surfaceContainer,
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.surfaceContainer,
                ),
                child: Center(
                  child: Icon(
                    Symbols.search_rounded,
                    color: context.colorScheme.onSurface,
                    size: 16,
                  ),
                ),
              ),
              const Gap(defaultGapM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      searchedItem.itemName!,
                      style: context.textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(defaultGapS / 4),
                    Row(
                      children: [
                        Text(
                          GeneralFunctions.formatItemCategory(searchedItem.itemCategory!),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(defaultGapS),
                        const CustomVerticalDivider(),
                        const Gap(defaultGapS),
                        Flexible(
                          child: Text(
                            searchedItem.itemLocation!,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(defaultGapM),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (searchedItem.itemAvailable != null && !searchedItem.itemAvailable!)
                    Row(
                      children: [
                        Icon(
                          Symbols.block_rounded,
                          color: context.colorScheme.error,
                          size: 12,
                        ),
                        const Gap(defaultGapS / 2),
                        Text(
                          '대여 불가',
                          style: context.textTheme.labelLarge?.copyWith(
                            color: context.colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      if (searchedItem.itemUsing!)
                        Icon(
                          Symbols.lock_clock_rounded,
                          color: context.colorScheme.primary,
                          size: 12,
                        )
                      else
                        Icon(
                          Symbols.lock_open_rounded,
                          color: context.colorScheme.onSurface,
                          size: 12,
                        ),
                      const Gap(defaultGapS / 2),
                      if (searchedItem.itemUsing!)
                        Text(
                          '대여 중',
                          style: context.textTheme.labelLarge?.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        )
                      else
                        Text(
                          '보관 중',
                          style: context.textTheme.labelLarge?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Symbols.history_rounded,
                        color: context.colorScheme.onSurface,
                        size: 12,
                      ),
                      const Gap(defaultGapS / 2),
                      Text(
                        searchedItem.itemRentalTime!.toString(),
                        style: context.textTheme.labelLarge?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pushItemDetailPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubItemDetailPage(),
      ),
    );
  }
}
