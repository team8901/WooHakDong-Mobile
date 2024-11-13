import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/setting/components/setting_theme_mode.dart';
import 'package:woohakdong/view_model/setting/setting_theme_provider.dart';

import '../../themes/spacing.dart';

class SettingAppBox extends ConsumerWidget {
  const SettingAppBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingThemeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultPaddingM),
          child: Text(
            '앱 설정',
            style: context.textTheme.labelLarge,
          ),
        ),
        const Gap(defaultGapM),
        InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              SettingThemeMode selectedThemeMode = ref.read(settingThemeProvider);

              return StatefulBuilder(
                builder: (context, setState) {
                  return Dialog(
                    child: Container(
                      padding: const EdgeInsets.all(defaultPaddingS * 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultBorderRadiusL),
                        color: context.colorScheme.surfaceDim,
                      ),
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
                                onTap: () {
                                  ref.read(settingThemeProvider.notifier).setThemeMode(selectedThemeMode);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  '확인',
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
                },
              );
            },
          ),
          highlightColor: context.colorScheme.surfaceContainer,
          child: Ink(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingM,
              vertical: defaultPaddingXS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '테마',
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  _getThemeText(themeMode),
                  style: context.textTheme.titleSmall?.copyWith(color: context.colorScheme.outline),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => openAppSettings(),
          highlightColor: context.colorScheme.surfaceContainer,
          child: Ink(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingM,
              vertical: defaultPaddingXS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '권한 설정',
                  style: context.textTheme.titleSmall,
                ),
                Icon(
                  Symbols.chevron_right_rounded,
                  color: context.colorScheme.outline,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getThemeText(SettingThemeMode theme) {
    switch (theme) {
      case SettingThemeMode.system:
        return '시스템 기본값';
      case SettingThemeMode.light:
        return '라이트 모드';
      case SettingThemeMode.dark:
        return '다크 모드';
      default:
        return '시스템 기본값';
    }
  }
}
