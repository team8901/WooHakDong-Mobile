import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/spacing.dart';

class ClubInfoManageBox extends StatelessWidget {
  final Future<void> Function() onClubDeleteTap;
  final Future<void> Function() onDelegatePresidentTap;

  const ClubInfoManageBox({
    super.key,
    required this.onClubDeleteTap,
    required this.onDelegatePresidentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultPaddingM),
          child: Text(
            '동아리 관리',
            style: context.textTheme.labelLarge,
          ),
        ),
        const Gap(defaultGapM),
        InkWell(
          onTap: onDelegatePresidentTap,
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
                  '회장 위임',
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
          onTap: onClubDeleteTap,
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
                  '동아리 삭제',
                  style: context.textTheme.titleSmall?.copyWith(color: context.colorScheme.error),
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
