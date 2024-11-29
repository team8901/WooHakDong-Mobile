import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/club_member/club_member.dart';
import '../../../service/general/general_format.dart';
import '../../themes/custom_widget/etc/custom_vertical_divider.dart';
import '../../themes/spacing.dart';

class DelegateClubMemberSearchListTile extends StatelessWidget {
  final ClubMember searchedClubMember;
  final int? selectedClubMemberId;
  final ValueChanged<int?> onChanged;

  const DelegateClubMemberSearchListTile({
    super.key,
    required this.searchedClubMember,
    required this.selectedClubMemberId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPaddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: selectedClubMemberId == searchedClubMember.clubMemberId!,
            onChanged: (value) {
              if (value == true) {
                onChanged(searchedClubMember.clubMemberId!);
              } else {
                onChanged(null);
              }
            },
            activeColor: context.colorScheme.primary,
            checkColor: context.colorScheme.inversePrimary,
            side: BorderSide(
              color: context.colorScheme.outline,
              width: 1,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2)),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
          ),
          const Gap(defaultGapM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(searchedClubMember.memberName!, style: context.textTheme.bodyLarge),
                    const Gap(defaultGapS / 2),
                    if (searchedClubMember.clubMemberRole != 'MEMBER')
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPaddingXS / 2,
                          vertical: defaultPaddingXS / 6,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                        ),
                        child: Text(
                          GeneralFormat.formatClubRole(searchedClubMember.clubMemberRole!),
                          style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.primary),
                        ),
                      ),
                  ],
                ),
                const Gap(defaultGapS / 2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        searchedClubMember.memberMajor!,
                        style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                        softWrap: true,
                      ),
                    ),
                    const Gap(defaultGapS),
                    const CustomVerticalDivider(),
                    const Gap(defaultGapS),
                    Flexible(
                      child: Text(
                        searchedClubMember.memberStudentNumber!,
                        style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
