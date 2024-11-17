import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/spacing.dart';

class ClubInfoItemManageBox extends StatelessWidget {
  final Future<void> Function() onClubItemExportTap;

  const ClubInfoItemManageBox({
    super.key,
    required this.onClubItemExportTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultPaddingM),
          child: Text(
            '물품 관리',
            style: context.textTheme.labelLarge,
          ),
        ),
        const Gap(defaultGapM),
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
                  '물품 목록 내보내기',
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
