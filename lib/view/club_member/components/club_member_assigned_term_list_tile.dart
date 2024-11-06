import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../service/general/general_functions.dart';
import '../../../view_model/club_member/club_member_provider.dart';
import '../../../view_model/club_member/components/club_selected_term_provider.dart';
import '../../themes/spacing.dart';

class ClubMemberAssignedTermListTile extends ConsumerWidget {
  final DateTime clubMemberAssignedTerm;
  final String termDate;
  final bool isCurrent;

  const ClubMemberAssignedTermListTile({
    super.key,
    required this.clubMemberAssignedTerm,
    required this.termDate,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(clubSelectedTermProvider.notifier).state = termDate;
        ref.invalidate(clubMemberProvider);

        if (context.mounted) {
          Navigator.pop(context);
        }
      },
      highlightColor: context.colorScheme.surfaceContainer,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPaddingM,
          vertical: defaultPaddingS / 2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.surfaceContainer,
              ),
              child: Center(
                child: Icon(
                  Symbols.calendar_month_rounded,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
            const Gap(defaultGapXL),
            Expanded(
              child: Text(
                GeneralFunctions.formatClubAssignedTerm(clubMemberAssignedTerm.toString()),
                style: context.textTheme.bodyLarge,
                softWrap: true,
              ),
            ),
            const Gap(defaultGapXL),
            if (isCurrent)
              Icon(
                size: 20,
                Symbols.check_circle_rounded,
                fill: 1,
                color: context.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
