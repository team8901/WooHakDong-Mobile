import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../service/general/general_functions.dart';
import '../../themes/spacing.dart';
import '../club_member_detail_page.dart';

class ClubMemberListTile extends StatelessWidget {
  final ClubMember clubMember;

  const ClubMemberListTile({
    super.key,
    required this.clubMember,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pushMemberDetailPage(context, clubMember),
      highlightColor: context.colorScheme.surfaceContainer,
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(clubMember.memberName!, style: context.textTheme.bodyLarge),
                        const Gap(defaultGapS / 2),
                        if (clubMember.clubMemberRole != 'MEMBER')
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
                              GeneralFunctions.getRoleDisplayName(clubMember.clubMemberRole!),
                              style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.primary),
                            ),
                          ),
                      ],
                    ),
                    const Gap(defaultGapS / 2),
                    Row(
                      children: [
                        Text(
                          clubMember.memberMajor!,
                          style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                          softWrap: true,
                        ),
                        const Gap(defaultGapS),
                        SizedBox(
                          height: 8,
                          child: VerticalDivider(
                            color: context.colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        const Gap(defaultGapS),
                        Text(
                          clubMember.memberStudentNumber!,
                          style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(defaultGapS),
              Skeleton.shade(
                child: Icon(
                  Symbols.chevron_right_rounded,
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pushMemberDetailPage(BuildContext context, ClubMember clubMember) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => ClubMemberDetailPage(clubMember: clubMember)),
    );
  }
}
