import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../service/general/general_format.dart';
import '../../../../service/general/general_image.dart';
import '../../../themes/spacing.dart';

class ClubItemEntireHistoryListTile extends StatelessWidget {
  final ItemHistory itemHistory;
  final Future<void> Function()? onTap;

  const ClubItemEntireHistoryListTile({
    super.key,
    required this.itemHistory,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      highlightColor: context.colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(defaultPaddingM),
        child: Ink(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Symbols.inventory_2_rounded,
                    size: 16,
                    color: context.colorScheme.onSurface,
                  ),
                  const Gap(defaultGapS / 2),
                  Text(
                    itemHistory.itemName ?? '',
                    style: context.textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Symbols.person_rounded,
                    size: 16,
                    color: context.colorScheme.onSurface,
                  ),
                  const Gap(defaultGapS / 2),
                  Text(
                    itemHistory.memberName ?? '',
                    style: context.textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Gap(defaultGapS / 2),
              Row(
                children: [
                  Icon(
                    Symbols.output_rounded,
                    size: 12,
                    color: context.colorScheme.onSurface,
                  ),
                  const Gap(defaultGapS / 2),
                  Text(
                    GeneralFormat.formatDateTime(itemHistory.itemRentalDate),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    itemHistory.itemReturnDate != null
                        ? Symbols.input_rounded
                        : (itemHistory.itemOverdue ?? false)
                        ? Symbols.timer_rounded
                        : Symbols.lock_clock_rounded,
                    size: 12,
                    color: itemHistory.itemReturnDate != null
                        ? context.colorScheme.onSurface
                        : (itemHistory.itemOverdue ?? false)
                        ? context.colorScheme.error
                        : context.colorScheme.primary,
                  ),
                  const Gap(defaultGapS / 2),
                  Text(
                    itemHistory.itemReturnDate != null
                        ? GeneralFormat.formatDateTime(itemHistory.itemReturnDate!)
                        : (itemHistory.itemOverdue ?? false)
                        ? '연체'
                        : '대여 중',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: itemHistory.itemReturnDate != null
                          ? context.colorScheme.onSurface
                          : (itemHistory.itemOverdue ?? false)
                          ? context.colorScheme.error
                          : context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
