import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_item/components/dialog/club_item_sort_bottom_sheet.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/item/components/item_sort.dart';

import '../../../../model/item/item_filter.dart';
import '../../../themes/spacing.dart';
import '../button/club_item_filter_button.dart';

class ClubItemFilterListTile extends StatelessWidget {
  final ItemFilter filter;
  final int itemCount;
  final VoidCallback onFilterTap;
  final VoidCallback onResetFilterTap;

  const ClubItemFilterListTile({
    super.key,
    required this.filter,
    required this.itemCount,
    required this.onFilterTap,
    required this.onResetFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.surfaceContainer,
            width: 0.6,
          ),
        ),
      ),
      child: Row(
        children: [
          Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: '현재 필터링된 물품의 개수예요',
            textStyle: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFFCFCFC),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingS,
              vertical: defaultPaddingXS,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF6C6E75).withOpacity(0.8),
              borderRadius: BorderRadius.circular(defaultBorderRadiusM),
            ),
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                border: Border.all(
                  color: context.colorScheme.surfaceContainer,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(defaultBorderRadiusL),
                  bottomRight: Radius.circular(defaultBorderRadiusL),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: defaultPaddingM,
                  right: defaultPaddingXS,
                ),
                child: Row(
                  children: [
                    const Icon(Symbols.list_alt_rounded, size: 12),
                    const Gap(defaultGapS / 2),
                    Text(
                      itemCount.toString(),
                      style: context.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(
                top: defaultPaddingM / 2,
                bottom: defaultPaddingM / 2,
                right: defaultPaddingM,
                left: defaultGapS,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        useSafeArea: true,
                        context: context,
                        builder: (context) => ClubItemSortBottomSheet(filter: filter),
                      );
                    },
                    highlightColor: context.colorScheme.surfaceContainer,
                    splashColor: context.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(defaultBorderRadiusL),
                    child: Ink(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: defaultPaddingXS),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colorScheme.surfaceContainer,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(defaultBorderRadiusL),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              (filter.itemSortOption!).displayText,
                              style: context.textTheme.labelLarge,
                            ),
                            const Gap(defaultGapS / 2),
                            const Icon(Symbols.filter_list_rounded, size: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(defaultGapS),
                  ClubItemFilterButton(
                    onTap: onFilterTap,
                    content: _getUsingFilterText(filter),
                    isActive: filter.using != null,
                    icon: filter.using == null ? Symbols.keyboard_arrow_down_rounded : null,
                  ),
                  const Gap(defaultGapS),
                  ClubItemFilterButton(
                    onTap: onFilterTap,
                    content: _getOverdueFilterText(filter),
                    isActive: filter.overdue != null,
                    icon: filter.overdue == null ? Symbols.keyboard_arrow_down_rounded : null,
                  ),
                  const Gap(defaultGapS),
                  ClubItemFilterButton(
                    onTap: onFilterTap,
                    content: _getAvailableFilterText(filter),
                    isActive: filter.available != null,
                    icon: filter.available == null ? Symbols.keyboard_arrow_down_rounded : null,
                  ),
                  const Gap(defaultGapS),
                  ClubItemFilterButton(
                    onTap: onResetFilterTap,
                    content: '필터 초기화',
                    icon: Symbols.restart_alt_rounded,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getUsingFilterText(ItemFilter filter) {
    if (filter.using == null) {
      return '대여 상태';
    } else {
      return filter.using! ? '대여 중' : '보관 중';
    }
  }

  String _getOverdueFilterText(ItemFilter filter) {
    if (filter.overdue == null) {
      return '연체 여부';
    } else {
      return filter.overdue! ? '연체' : '미연체';
    }
  }

  String _getAvailableFilterText(ItemFilter filter) {
    if (filter.available == null) {
      return '대여 가능 여부';
    } else {
      return filter.available! ? '대여 가능' : '대여 불가';
    }
  }
}
