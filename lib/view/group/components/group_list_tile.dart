import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_format.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_tap_debouncer.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/group/group.dart';
import '../../themes/spacing.dart';

class GroupListTile extends StatelessWidget {
  final Group group;
  final Future<void> Function()? onTap;

  const GroupListTile({
    super.key,
    required this.group,
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
                    Flexible(
                      child: Text(
                        group.groupName!,
                        style: context.textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(defaultGapS / 2),
                    if (group.groupIsActivated == false)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPaddingXS / 2,
                          vertical: defaultPaddingXS / 6,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                        ),
                        child: Text(
                          '마감된 모임',
                          style: context.textTheme.labelLarge?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ),
                  ],
                ),
                const Gap(defaultGapS / 4),
                Text(
                  GeneralFormat.formatClubDues(group.groupAmount!),
                  style: context.textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Symbols.person_rounded,
                      color: context.colorScheme.onSurface,
                      size: 12,
                    ),
                    const Gap(defaultGapS / 2),
                    Text(
                      '${group.groupMemberCount} / ${group.groupMemberLimit}',
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorScheme.onSurface,
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
