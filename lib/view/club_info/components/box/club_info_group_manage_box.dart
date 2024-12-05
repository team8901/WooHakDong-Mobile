import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/custom_widget/button/custom_info_tooltip.dart';
import '../../../themes/spacing.dart';

class ClubInfoGroupManageBox extends StatelessWidget {
  final VoidCallback onTap;

  const ClubInfoGroupManageBox({
    super.key,
    required this.onTap,
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
                '모임 관리',
                style: context.textTheme.labelLarge,
              ),
              const Gap(defaultGapS),
              const CustomInfoTooltip(tooltipMessage: '동아리의 여러 모임을 만들고 공유할 수 있어요'),
            ],
          ),
        ),
        const Gap(defaultGapM),
        InkWell(
          onTap: onTap,
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
                  '모임 목록',
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
