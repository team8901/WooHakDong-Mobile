import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/spacing.dart';

class ClubInfoDuesManageBox extends StatelessWidget {
  final Future<void> Function() onClubDuesExportTap;

  const ClubInfoDuesManageBox({
    super.key,
    required this.onClubDuesExportTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultPaddingM),
          child: Text(
            '회비 관리',
            style: context.textTheme.labelLarge,
          ),
        ),
        const Gap(defaultGapM),
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
                  '회비 목록 내보내기',
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
      ],
    );
  }
}
