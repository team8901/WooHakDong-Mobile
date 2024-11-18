import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/setting/components/setting_theme_mode.dart';

import '../../themes/spacing.dart';

class SettingThemeDialog extends StatefulWidget {
  final SettingThemeMode initialThemeMode;

  const SettingThemeDialog({
    super.key,
    required this.initialThemeMode,
  });

  @override
  State<SettingThemeDialog> createState() => _SettingThemeDialogState();
}

class _SettingThemeDialogState extends State<SettingThemeDialog> {
  late SettingThemeMode selectedThemeMode;

  @override
  void initState() {
    super.initState();
    selectedThemeMode = widget.initialThemeMode;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(defaultPaddingS * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('테마 변경', style: context.textTheme.titleMedium),
            const Gap(defaultGapS / 2),
            Text(
              '테마를 선택해 주세요',
              style: context.textTheme.bodyLarge,
            ),
            const Gap(defaultPaddingS * 2),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.surfaceContainer),
                borderRadius: BorderRadius.circular(defaultBorderRadiusM),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio<SettingThemeMode>(
                        activeColor: context.colorScheme.primary,
                        value: SettingThemeMode.system,
                        groupValue: selectedThemeMode,
                        onChanged: (value) {
                          setState(() {
                            selectedThemeMode = value!;
                          });
                        },
                      ),
                      Text(
                        '시스템 기본값',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<SettingThemeMode>(
                        activeColor: context.colorScheme.primary,
                        value: SettingThemeMode.light,
                        groupValue: selectedThemeMode,
                        onChanged: (value) {
                          setState(() {
                            selectedThemeMode = value!;
                          });
                        },
                      ),
                      Text(
                        '라이트 모드',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<SettingThemeMode>(
                        activeColor: context.colorScheme.primary,
                        value: SettingThemeMode.dark,
                        groupValue: selectedThemeMode,
                        onChanged: (value) {
                          setState(() {
                            selectedThemeMode = value!;
                          });
                        },
                      ),
                      Text(
                        '다크 모드',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
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
                  onTap: () => Navigator.pop(context, selectedThemeMode),
                  child: Text(
                    '변경',
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
