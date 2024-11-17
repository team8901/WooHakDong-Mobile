import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../spacing.dart';

class CustomPermissionDeniedDialog extends StatelessWidget {
  final String message;

  const CustomPermissionDeniedDialog({
    super.key,
    required this.message,
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
            Text('권한 설정', style: context.textTheme.titleMedium),
            const Gap(defaultPaddingXS * 2),
            Text(
              message,
              style: context.textTheme.bodyMedium,
            ),
            const Gap(defaultPaddingS * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    '취소',
                    style: context.textTheme.titleSmall,
                  ),
                ),
                const Gap(defaultPaddingS * 2),
                InkWell(
                  onTap: () {
                    openAppSettings();
                    Navigator.pop(context);
                  },
                  child: Text(
                    '설정으로 이동',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.primary,
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
