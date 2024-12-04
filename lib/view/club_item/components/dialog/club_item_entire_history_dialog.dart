import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/spacing.dart';

class ClubItemEntireHistoryDialog extends StatelessWidget {
  final ItemHistory itemHistory;
  final BuildContext context;
  final Future<void> Function()? onItemDetailTap;
  final Future<void> Function()? onMemberDetailTap;

  const ClubItemEntireHistoryDialog({
    super.key,
    required this.itemHistory,
    required this.context,
    this.onItemDetailTap,
    this.onMemberDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(
          top: defaultPaddingS * 2,
          left: defaultPaddingS * 2,
          right: defaultPaddingS * 2,
          bottom: defaultPaddingXS * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('상세 정보', style: context.textTheme.titleMedium),
            const Gap(defaultPaddingXS * 2),
            InkWell(
              highlightColor: context.colorScheme.surfaceContainer,
              onTap: onItemDetailTap,
              child: Ink(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPaddingS / 2),
                  child: Row(
                    children: [
                      const Icon(Symbols.inventory_2_rounded),
                      const Gap(defaultGapXL),
                      Text(
                        '물품 상세 정보 보기',
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(defaultGapS / 2),
            InkWell(
              highlightColor: context.colorScheme.surfaceContainer,
              onTap: onMemberDetailTap,
              child: Ink(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPaddingS / 2),
                  child: Row(
                    children: [
                      const Icon(Symbols.person_rounded),
                      const Gap(defaultGapXL),
                      Text(
                        '회원 상세 정보 보기',
                        style: context.textTheme.bodyLarge,
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
}
