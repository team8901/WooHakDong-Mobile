import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import 'club_dues_in_out_type_bottom_sheet_button.dart';

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
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: defaultPaddingM),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            ClubDuesInOutTypeBottomSheetButton(
              title: '전체',
              type: 'ALL',
              selectedType: duesInOutType,
              onTap: (type) => onTypeSelect(type),
            ),
            const Gap(defaultGapS),
            ClubDuesInOutTypeBottomSheetButton(
              title: '입금',
              type: 'DEPOSIT',
              selectedType: duesInOutType,
              onTap: (type) => onTypeSelect(type),
            ),
            const Gap(defaultGapS),
            ClubDuesInOutTypeBottomSheetButton(
              title: '출금',
              type: 'WITHDRAW',
              selectedType: duesInOutType,
              onTap: (type) => onTypeSelect(type),
            ),
            const Gap(defaultGapXL),
          ],
        ),
      ),
    );
  }
}
