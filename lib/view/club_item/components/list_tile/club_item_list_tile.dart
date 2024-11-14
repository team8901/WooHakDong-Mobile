import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/custom_widget/etc/custom_vertical_divider.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../model/item/item.dart';
import '../../../../service/general/general_functions.dart';
import '../../../themes/custom_widget/interaction/custom_tap_debouncer.dart';
import '../../../themes/spacing.dart';

class ClubItemListTile extends ConsumerWidget {
  final Item item;
  final Future<void> Function()? onTap;

  const ClubItemListTile({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageProvider = (item.itemPhoto != null && item.itemPhoto!.isNotEmpty)
        ? CachedNetworkImageProvider(item.itemPhoto!)
        : const AssetImage('assets/images/club/club_basic_image.jpg') as ImageProvider;

    return CustomTapDebouncer(
      onTap: onTap,
      builder: (context, onTap) {
        return InkWell(
          onTap: onTap,
          highlightColor: context.colorScheme.surfaceContainer,
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.all(defaultPaddingM),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 72.r,
                    height: 72.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: context.colorScheme.surfaceContainer,
                        width: 1,
                      ),
                    ),
                  ),
                  const Gap(defaultGapM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.itemName!,
                          style: context.textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(defaultGapS / 4),
                        Row(
                          children: [
                            Text(
                              GeneralFunctions.formatItemCategory(item.itemCategory!),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            const Gap(defaultGapS),
                            const CustomVerticalDivider(),
                            const Gap(defaultGapS),
                            Flexible(
                              child: Text(
                                item.itemLocation!,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.onSurface,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Gap(defaultGapS),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (item.itemAvailable != null && !item.itemAvailable!)
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
                            const Gap(defaultGapS),
                            if (item.itemUsing!)
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
                            if (item.itemUsing!)
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
                            const Gap(defaultGapS),
                            Icon(
                              Symbols.history_rounded,
                              color: context.colorScheme.onSurface,
                              size: 12,
                            ),
                            const Gap(defaultGapS / 2),
                            Text(
                              item.itemRentalTime!.toString(),
                              style: context.textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
