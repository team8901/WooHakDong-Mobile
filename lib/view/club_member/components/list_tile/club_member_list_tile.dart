import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_tap_debouncer.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../../service/general/general_functions.dart';
import '../../../themes/custom_widget/etc/custom_vertical_divider.dart';
import '../../../themes/spacing.dart';

class ClubMemberListTile extends ConsumerWidget {
  final ClubMember clubMember;
  final Future<void> Function()? onTap;

  const ClubMemberListTile({
    super.key,
    required this.clubMember,
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
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPaddingXS / 2,
                                  vertical: defaultPaddingXS / 6,
                                ),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(defaultBorderRadiusL / 4),
                                ),
                                child: Text(
                                  GeneralFunctions.formatClubRole(clubMember.clubMemberRole!),
                                  style: context.textTheme.labelLarge?.copyWith(
                                    color: context.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
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
                              clubMember.memberMajor!,
                              style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                              softWrap: true,
                            ),
                          ),
                          const Gap(defaultGapS),
                          const CustomVerticalDivider(),
                          const Gap(defaultGapS),
                          Flexible(
                            child: Text(
                              clubMember.memberStudentNumber!,
                              style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(defaultGapM),
                Icon(
                  Symbols.chevron_right_rounded,
                  color: context.colorScheme.outline,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
