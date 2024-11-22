import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../model/item/item_filter.dart';
import '../../../themes/spacing.dart';

class ClubItemFilterActionButton extends StatelessWidget {
  final ItemFilter filter;
  final VoidCallback onFilterTap;
  final VoidCallback onResetFilterTap;

  const ClubItemFilterActionButton({
    super.key,
    required this.filter,
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM, vertical: defaultPaddingM / 2),
        child: Row(
          children: [
            InkWell(
              onTap: onFilterTap,
              highlightColor: context.colorScheme.outline,
              borderRadius: BorderRadius.circular(defaultBorderRadiusL),
              child: Ink(
                height: 32.h,
                padding: const EdgeInsets.symmetric(horizontal: defaultPaddingXS),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: filter.using == null ? context.colorScheme.surfaceContainer : Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(defaultBorderRadiusL),
                  color: filter.using == null ? Colors.transparent : context.colorScheme.secondary,
                ),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        _getUsingFilterText(filter),
                        style: filter.using == null
                            ? context.textTheme.labelLarge
                            : context.textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                      ),
                      if (filter.available == null) const Gap(defaultGapS / 2),
                      if (filter.using == null)
                        const Icon(
                          Symbols.keyboard_arrow_down_rounded,
                          size: 12,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(defaultGapS),
            InkWell(
              onTap: onFilterTap,
              highlightColor: context.colorScheme.outline,
              borderRadius: BorderRadius.circular(defaultBorderRadiusL),
              child: Ink(
                height: 32.h,
                padding: const EdgeInsets.symmetric(horizontal: defaultPaddingXS),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: filter.overdue == null ? context.colorScheme.surfaceContainer : Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(defaultBorderRadiusL),
                  color: filter.overdue == null ? Colors.transparent : context.colorScheme.secondary,
                ),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        _getOverdueFilterText(filter),
                        style: filter.overdue == null
                            ? context.textTheme.labelLarge
                            : context.textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                      ),
                      if (filter.available == null) const Gap(defaultGapS / 2),
                      if (filter.overdue == null)
                        const Icon(
                          Symbols.keyboard_arrow_down_rounded,
                          size: 12,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(defaultGapS),
            InkWell(
              onTap: onFilterTap,
              highlightColor: context.colorScheme.outline,
              borderRadius: BorderRadius.circular(defaultBorderRadiusL),
              child: Ink(
                height: 32.h,
                padding: const EdgeInsets.symmetric(horizontal: defaultPaddingXS),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: filter.available == null ? context.colorScheme.surfaceContainer : Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(defaultBorderRadiusL),
                  color: filter.available == null ? Colors.transparent : context.colorScheme.secondary,
                ),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        _getAvailableFilterText(filter),
                        style: filter.available == null
                            ? context.textTheme.labelLarge
                            : context.textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                      ),
                      if (filter.available == null) const Gap(defaultGapS / 2),
                      if (filter.available == null)
                        const Icon(
                          Symbols.keyboard_arrow_down_rounded,
                          size: 12,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(defaultGapS),
            InkWell(
              onTap: onResetFilterTap,
              highlightColor: context.colorScheme.outline,
              borderRadius: BorderRadius.circular(defaultBorderRadiusL),
              child: Ink(
                height: 32.h,
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
                        '필터 초기화',
                        style: context.textTheme.labelLarge,
                      ),
                      const Gap(defaultGapS / 2),
                      const Icon(
                        Symbols.restart_alt_rounded,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
