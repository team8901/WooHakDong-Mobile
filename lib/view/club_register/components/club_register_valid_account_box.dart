import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/club/club_account.dart';
import '../../themes/spacing.dart';

class ClubRegisterValidAccountBox extends StatelessWidget {
  const ClubRegisterValidAccountBox({
    super.key,
    required this.clubAccountInfo,
  });

  final ClubAccount clubAccountInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(defaultGapXL),
        Text(
          '동아리 계좌 핀테크 번호',
          style: context.textTheme.labelLarge,
        ),
        const Gap(defaultGapM),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.surfaceContainer),
            borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPaddingM,
            vertical: defaultPaddingXS,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '*' * (clubAccountInfo.clubAccountPinTechNumber?.length ?? 0),
              style: context.textTheme.titleSmall,
            ),
          ),
        ),
      ],
    );
  }
}
