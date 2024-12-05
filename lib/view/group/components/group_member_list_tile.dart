import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_tap_debouncer.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../service/general/general_format.dart';
import '../../../model/group/group_member.dart';
import '../../themes/custom_widget/etc/custom_vertical_divider.dart';
import '../../themes/spacing.dart';

class GroupMemberListTile extends StatelessWidget {
  final GroupMember groupMember;
  final Future<void> Function()? onTap;

  const GroupMemberListTile({
    super.key,
    required this.groupMember,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTapDebouncer(
      onTap: onTap,
      builder: (context, onTap) {
        return InkWell(
          onTap: onTap,
          highlightColor: context.colorScheme.surfaceContainer,
          child: Ink(
            padding: const EdgeInsets.all(defaultPaddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(groupMember.memberName!, style: context.textTheme.bodyLarge),
                    const Gap(defaultGapS / 2),
                    if (groupMember.clubMemberRole != 'MEMBER')
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPaddingXS / 2,
                          vertical: defaultPaddingXS / 6,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                        ),
                        child: Text(
                          GeneralFormat.formatClubRole(groupMember.clubMemberRole!),
                          style: context.textTheme.labelLarge?.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                  ],
                ),
                const Gap(defaultGapS / 2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        groupMember.memberMajor!,
                        style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                        softWrap: true,
                      ),
                    ),
                    const Gap(defaultGapS),
                    const CustomVerticalDivider(),
                    const Gap(defaultGapS),
                    Flexible(
                      child: Text(
                        groupMember.memberStudentNumber!,
                        style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
