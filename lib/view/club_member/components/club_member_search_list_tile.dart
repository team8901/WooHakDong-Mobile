import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_tap_debouncer.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../service/general/general_functions.dart';
import '../../themes/custom_widget/etc/custom_vertical_divider.dart';
import '../../themes/spacing.dart';

class ClubMemberSearchListTile extends ConsumerWidget {
  final ClubMember searchedClubMember;
  final Future<void> Function()? onTap;

  const ClubMemberSearchListTile({
    super.key,
    required this.searchedClubMember,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTapDebouncer(
      onTap: onTap,
      builder: (context, onTap) {
        return InkWell(
          onTap: onTap,
          highlightColor: context.colorScheme.surfaceContainer,
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.all(defaultPaddingM),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.surfaceContainer,
                    ),
                    child: Center(
                      child: Icon(
                        Symbols.search_rounded,
                        color: context.colorScheme.onSurface,
                        size: 16,
                      ),
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
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPaddingXS / 2,
                                    vertical: defaultPaddingXS / 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                                  ),
                                  child: Text(
                                    GeneralFunctions.formatClubRole(searchedClubMember.clubMemberRole!),
                                    style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.primary),
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
            ),
          ),
        );
      },
    );
  }
}
