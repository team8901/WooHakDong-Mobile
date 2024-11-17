import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/setting/components/setting_theme_mode.dart';

import '../../themes/spacing.dart';

class SettingAppBox extends ConsumerWidget {
  final SettingThemeMode settingThemeMode;
  final Future<void> Function() onTap;

  const SettingAppBox({
    super.key,
    required this.settingThemeMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          onTap: onTap,
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
                  _getThemeText(settingThemeMode),
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
