import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:woohakdong/service/general/general_format.dart';
import 'package:woohakdong/view/themes/custom_widget/etc/custom_vertical_divider.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/member/member.dart';

class SettingMemberInfoBox extends ConsumerWidget {
  final Member memberInfo;
  final VoidCallback? onTap;

  const SettingMemberInfoBox({
    super.key,
    required this.memberInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
      padding: const EdgeInsets.only(top: defaultPaddingXS),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.surfaceContainer,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: defaultPaddingS * 2,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      memberInfo.memberName,
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      GeneralFormat.formatMemberGender(memberInfo.memberGender),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const Gap(defaultGapL * 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        GeneralFormat.formatMemberPhoneNumber(memberInfo.memberPhoneNumber!),
                        style: context.textTheme.bodyLarge,
                      ),
                      Text(
                        memberInfo.memberEmail,
                        style: context.textTheme.bodyLarge,
                      ),
                      Divider(
                        color: context.colorScheme.surfaceContainer,
                        thickness: 0.6,
                        height: 8,
                      ),
                      Text(
                        memberInfo.memberStudentNumber!,
                        style: context.textTheme.bodyLarge,
                      ),
                      Row(
                        children: [
                          Text(
                            memberInfo.memberSchool,
                            style: context.textTheme.bodyLarge,
                          ),
                          const Gap(defaultGapS),
                          const CustomVerticalDivider(),
                          const Gap(defaultGapS),
                          Text(
                            memberInfo.memberMajor!,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(defaultGapM),
          InkWell(
            onTap: onTap,
            highlightColor: context.colorScheme.outline,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(defaultBorderRadiusM),
              bottomRight: Radius.circular(defaultBorderRadiusM),
            ),
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: defaultPaddingS / 2),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(defaultBorderRadiusM),
                  bottomRight: Radius.circular(defaultBorderRadiusM),
                ),
                color: context.colorScheme.surfaceContainer,
              ),
              child: Center(
                child: Icon(
                  Symbols.edit_rounded,
                  size: 14,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
