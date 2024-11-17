import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/spacing.dart';

class ClubInfoMemberManageBox extends StatelessWidget {
  final Future<void> Function() onClubMemberExportTap;
  final Future<void> Function() onClubMemberImportTap;

  const ClubInfoMemberManageBox({
    super.key,
    required this.onClubMemberExportTap,
    required this.onClubMemberImportTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultPaddingM),
          child: Text(
            '회원 관리',
            style: context.textTheme.labelLarge,
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
                  '회원 목록 내보내기',
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  '.XLSX',
                  style: context.textTheme.titleSmall?.copyWith(color: context.colorScheme.outline),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: onClubMemberImportTap,
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
                  '이전 회원 목록 가져오기',
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
