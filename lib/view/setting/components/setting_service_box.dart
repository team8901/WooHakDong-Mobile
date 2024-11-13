import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/auth/auth_provider.dart';

import '../../../service/general/general_functions.dart';
import '../../themes/custom_widget/dialog/custom_interaction_dialog.dart';
import '../../themes/spacing.dart';

class SettingServiceBox extends ConsumerWidget {
  const SettingServiceBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultPaddingM),
          child: Text(
            '서비스',
            style: context.textTheme.labelLarge,
          ),
        ),
        const Gap(defaultGapM),
        InkWell(
          onTap: () => _serviceLogOut(context, ref),
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
                  '로그아웃',
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
        InkWell(
          onTap: () => _serviceSecede(context, ref),
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
                  '회원 탈퇴',
                  style: context.textTheme.titleSmall?.copyWith(color: context.colorScheme.error),
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

  Future<void> _serviceLogOut(BuildContext context, WidgetRef ref) async {
    try {
      final bool? isLogout = await showDialog<bool>(
        context: context,
        builder: (context) => CustomInteractionDialog(
          dialogTitle: '로그아웃',
          dialogContent: '로그아웃해도 다시 로그인할 수 있어요.',
          dialogButtonText: '확인',
          dialogButtonColor: context.colorScheme.primary,
        ),
      );

      if (isLogout == true) {
        await ref.read(authProvider.notifier).signOut();

        if (context.mounted) {
          await Phoenix.rebirth(context);
        }
      }
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }

  Future<void> _serviceSecede(BuildContext context, WidgetRef ref) async {
    try {
      final bool? isSecede = await showDialog<bool>(
        context: context,
        builder: (context) => const CustomInteractionDialog(
          dialogTitle: '회원 탈퇴',
          dialogContent: '회원 탈퇴를 하면 되돌릴 수 없어요.',
          dialogButtonText: '탈퇴',
        ),
      );

      if (isSecede == true) {
        /// TODO 회원 탈퇴 기능 추가
      }
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }
}
