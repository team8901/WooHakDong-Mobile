import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class ClubDuesInOutTypeBottomSheet extends StatelessWidget {
  final Function(String?) onTypeSelect;
  final String duesInOutType;

  const ClubDuesInOutTypeBottomSheet({
    super.key,
    required this.onTypeSelect,
    required this.duesInOutType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingM,
              vertical: defaultPaddingS / 2,
            ),
            child: Text(
              '회비 내역 유형 선택',
              style: context.textTheme.titleLarge,
            ),
          ),
          const Gap(defaultGapS),
          InkWell(
            onTap: () {
              onTypeSelect('ALL');
              Navigator.pop(context);
            },
            highlightColor: context.colorScheme.surfaceContainer,
            child: Ink(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPaddingM,
                vertical: defaultPaddingS / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '전체',
                    style: context.textTheme.bodyLarge,
                  ),
                  if (duesInOutType == 'ALL')
                    Icon(
                      size: 20,
                      Symbols.check_circle_rounded,
                      fill: 1,
                      color: context.colorScheme.primary,
                    ),
                ],
              ),
            ),
          ),
          const Gap(defaultGapS),
          InkWell(
            onTap: () {
              onTypeSelect('DEPOSIT');
              Navigator.pop(context);
            },
            highlightColor: context.colorScheme.surfaceContainer,
            child: Ink(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPaddingM,
                vertical: defaultPaddingS / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '입금',
                    style: context.textTheme.bodyLarge,
                  ),
                  if (duesInOutType == 'DEPOSIT')
                    Icon(
                      size: 20,
                      Symbols.check_circle_rounded,
                      fill: 1,
                      color: context.colorScheme.primary,
                    ),
                ],
              ),
            ),
          ),
          const Gap(defaultGapS),
          InkWell(
            onTap: () {
              onTypeSelect('WITHDRAW');
              Navigator.pop(context);
            },
            highlightColor: context.colorScheme.surfaceContainer,
            child: Ink(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPaddingM,
                vertical: defaultPaddingS / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '출금',
                    style: context.textTheme.bodyLarge,
                  ),
                  if (duesInOutType == 'WITHDRAW')
                    Icon(
                      size: 20,
                      Symbols.check_circle_rounded,
                      fill: 1,
                      color: context.colorScheme.primary,
                    ),
                ],
              ),
            ),
          ),
          const Gap(defaultGapXL),
        ],
      ),
    );
  }
}
