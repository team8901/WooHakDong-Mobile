import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../view_model/club_member/components/club_member_sort_option.dart';
import '../../../themes/spacing.dart';

class ClubMemberFilterListTile extends StatelessWidget {
  final ClubMemberSortOption clubMemberSortOption;
  final int clubMemberCount;
  final VoidCallback onSortTap;

  const ClubMemberFilterListTile({
    super.key,
    required this.clubMemberSortOption,
    required this.clubMemberCount,
    required this.onSortTap,
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
            message: '현재 동아리 회원 수예요',
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
                      clubMemberCount.toString(),
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
                    onTap: onSortTap,
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
                              clubMemberSortOption.displayText,
                              style: context.textTheme.labelLarge,
                            ),
                            const Gap(defaultGapS / 2),
                            const Icon(Symbols.filter_list_rounded, size: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
