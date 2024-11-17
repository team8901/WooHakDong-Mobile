import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/group/group.dart';
import '../../../service/general/general_functions.dart';
import '../../themes/spacing.dart';

class ClubRegisterUrlCard extends StatelessWidget {
  final Group? groupInfo;

  const ClubRegisterUrlCard({
    super.key,
    required this.groupInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.surfaceContainer),
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPaddingS,
        vertical: defaultPaddingXS,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                groupInfo!.groupJoinLink!,
                style: context.textTheme.titleSmall,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
            const Gap(defaultGapM),
            InkWell(
              onTap: () => GeneralFunctions.clipboardCopy(groupInfo!.groupJoinLink!, '전용 페이지 링크를 복사했어요'),
              child: Ink(
                child: Icon(
                  Symbols.content_copy_rounded,
                  color: context.colorScheme.outline,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
