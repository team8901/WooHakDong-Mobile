import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../themes/spacing.dart';

class CustomInteractionDialog extends StatelessWidget {
  final String dialogTitle;
  final String dialogContent;
  final String dialogButtonText;
  final Color? dialogButtonColor;

  const CustomInteractionDialog({
    super.key,
    required this.dialogTitle,
    required this.dialogContent,
    this.dialogButtonText = '삭제',
    this.dialogButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(defaultPaddingS * 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadiusL),
          color: context.colorScheme.surfaceBright,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(dialogTitle, style: context.textTheme.titleMedium),
            const Gap(defaultGapS / 2),
            Text(
              dialogContent,
              style: context.textTheme.bodyLarge,
            ),
            const Gap(defaultPaddingS * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context, false),
                  child: Text(
                    '취소',
                    style: context.textTheme.titleSmall,
                  ),
                ),
                const Gap(defaultPaddingS * 2),
                InkWell(
                  onTap: () => Navigator.pop(context, true),
                  child: Text(
                    dialogButtonText,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: dialogButtonColor ?? context.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
