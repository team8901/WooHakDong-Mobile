import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/custom_widget/button/custom_info_tooltip.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/spacing.dart';

class ClubInfoFileManageBox extends StatelessWidget {
  final Future<void> Function() onClubMemberExportTap;
  final Future<void> Function() onClubItemExportTap;
  final Future<void> Function() onClubDuesExportTap;

  const ClubInfoFileManageBox({
    super.key,
    required this.onClubMemberExportTap,
    required this.onClubItemExportTap,
    required this.onClubDuesExportTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultPaddingM),
          child: Row(
            children: [
              Text(
                '파일 내보내기',
                style: context.textTheme.labelLarge,
              ),
              const Gap(defaultGapS),
              const CustomInfoTooltip(tooltipMessage: '엑셀 파일(.xlsx)로 내보낼 수 있어요'),
            ],
          ),
        ),
        const Gap(defaultGapM),
        InkWell(
          onTap: onClubMemberExportTap,
          highlightColor: context.colorScheme.surfaceContainer,
          child: Ink(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingM,
              vertical: defaultPaddingXS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '회원 목록',
                  style: context.textTheme.titleSmall,
                ),
                Icon(
                  Symbols.chevron_right_rounded,
                  color: context.colorScheme.outline,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: onClubItemExportTap,
          highlightColor: context.colorScheme.surfaceContainer,
          child: Ink(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingM,
              vertical: defaultPaddingXS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '물품 목록',
                  style: context.textTheme.titleSmall,
                ),
                Icon(
                  Symbols.chevron_right_rounded,
                  color: context.colorScheme.outline,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: onClubDuesExportTap,
          highlightColor: context.colorScheme.surfaceContainer,
          child: Ink(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingM,
              vertical: defaultPaddingXS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '회비 목록',
                  style: context.textTheme.titleSmall,
                ),
                Icon(
                  Symbols.chevron_right_rounded,
                  color: context.colorScheme.outline,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
