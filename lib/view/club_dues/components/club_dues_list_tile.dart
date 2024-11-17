import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/dues/dues.dart';
import '../../../service/general/general_functions.dart';
import '../../themes/spacing.dart';

class ClubDuesListTile extends StatelessWidget {
  final Dues dues;

  const ClubDuesListTile({
    super.key,
    required this.dues,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPaddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            GeneralFunctions.formatDateTime(dues.clubAccountHistoryTranDate),
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          const Gap(defaultGapS / 4),
          Text(
            dues.clubAccountHistoryContent!,
            style: context.textTheme.bodyLarge,
            softWrap: true,
          ),
          const Gap(defaultGapS / 2),
          (dues.clubAccountHistoryInOutType == 'WITHDRAW')
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '-${GeneralFunctions.formatClubDues(dues.clubAccountHistoryTranAmount!)}',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.error,
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '+${GeneralFunctions.formatClubDues(dues.clubAccountHistoryTranAmount!)}',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
          const Gap(defaultGapS / 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              GeneralFunctions.formatClubDues(dues.clubAccountHistoryBalanceAmount!),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
