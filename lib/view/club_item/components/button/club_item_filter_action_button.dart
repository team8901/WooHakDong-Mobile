import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../model/item/item_filter.dart';
import '../../../themes/spacing.dart';

class ClubItemFilterActionButton extends StatelessWidget {
  final ItemFilter filter;
  final VoidCallback onUsingFilterTap;
  final VoidCallback onAvailableFilterTap;

  const ClubItemFilterActionButton({
    super.key,
    required this.filter,
    required this.onUsingFilterTap,
    required this.onAvailableFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: defaultPaddingM,
        top: defaultPaddingXS,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onUsingFilterTap,
            highlightColor: context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(defaultBorderRadiusL / 2),
            child: Ink(
              height: 32.h,
              padding: const EdgeInsets.symmetric(horizontal: defaultPaddingXS),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadiusL / 2),
                color: filter.using == null ? context.colorScheme.surfaceContainer : context.colorScheme.secondary,
              ),
              child: Center(
                child: Text(
                  _getUsingFilterText(filter),
                  style: filter.using == null
                      ? context.textTheme.labelLarge?.copyWith(color: context.colorScheme.onSurface)
                      : context.textTheme.labelLarge?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                ),
              ),
            ),
          ),
          const Gap(defaultGapS),
          InkWell(
            onTap: onAvailableFilterTap,
            highlightColor: context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(defaultBorderRadiusL / 2),
            child: Ink(
              height: 32.h,
              padding: const EdgeInsets.symmetric(horizontal: defaultPaddingXS),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadiusL / 2),
                color: filter.available == null ? context.colorScheme.surfaceContainer : context.colorScheme.secondary,
              ),
              child: Center(
                child: Text(
                  _getAvailableFilterText(filter),
                  style: filter.available == null
                      ? context.textTheme.labelLarge?.copyWith(color: context.colorScheme.onSurface)
                      : context.textTheme.labelLarge?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                ),
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

  String _getAvailableFilterText(ItemFilter filter) {
    if (filter.available == null) {
      return '대여 가능 여부';
    } else {
      return filter.available! ? '대여 가능' : '대여 불가';
    }
  }
}
