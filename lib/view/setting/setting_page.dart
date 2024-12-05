import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woohakdong/view/setting/components/setting_info_box.dart';
import 'package:woohakdong/view/setting/components/setting_member_info_box.dart';
import 'package:woohakdong/view/setting/components/setting_service_box.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/member/member_provider.dart';

import '../../model/member/member.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/auth/auth_provider.dart';
import '../../view_model/setting/components/setting_theme_mode.dart';
import '../../view_model/setting/setting_theme_provider.dart';
import '../member/member_edit_page.dart';
import '../themes/custom_widget/dialog/custom_interaction_dialog.dart';
import '../themes/spacing.dart';
import 'components/setting_app_box.dart';
import 'components/setting_theme_dialog.dart';
import 'oss_license_list_page.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberInfo = ref.watch(memberProvider);
    final settingThemeMode = ref.watch(settingThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingMemberInfoBox(
                memberInfo: memberInfo!,
                onTap: () => _pushMemberEditPage(context, memberInfo),
              ),
              const Gap(defaultGapXL * 2),
              SettingAppBox(
                settingThemeMode: settingThemeMode,
                onTap: () async => await _showSettingThemeDialog(context, ref),
              ),
              const Gap(defaultGapXL),
              SettingInfoBox(
                onTermsOfUseTap: () => _launchUri('https://jjunhub.notion.site/956afbccfda44b87bf0c23dd7662b115?pvs=4'),
                onPrivacyPolicyTap: () =>
                    _launchUri('https://jjunhub.notion.site/cc5e593f28234357ad49544a9a56d8bc?pvs=4'),
                onOssLicenseTap: () => _pushOssLicenseListPage(context),
              ),
              const Gap(defaultGapXL),
              SettingServiceBox(
                onUserSupportTap: () =>
                    _launchUri('https://jjunhub.notion.site/22fc31aa9871443cb9fb61fd4d9eeb02?pvs=4'),
                onLogOut: () async => await _serviceLogOut(context, ref),
                onSecede: () async => await _serviceSecede(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pushMemberEditPage(BuildContext context, Member memberInfo) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => MemberEditPage(memberInfo: memberInfo),
      ),
    );
  }

  Future<void> _showSettingThemeDialog(BuildContext context, WidgetRef ref) async {
    final selectedThemeMode = await showDialog<SettingThemeMode>(
      context: context,
      builder: (context) {
        return SettingThemeDialog(
          initialThemeMode: ref.read(settingThemeProvider),
        );
      },
    );

    if (selectedThemeMode != null) {
      ref.read(settingThemeProvider.notifier).setThemeMode(selectedThemeMode);
    }
  }

  Future<void> _launchUri(String httpUri) async {
    final Uri termsOfUseUri = Uri.parse(httpUri);

    if (await canLaunchUrl(termsOfUseUri)) {
      await launchUrl(termsOfUseUri);
    }
  }

  void _pushOssLicenseListPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const OssLicenseListPage(),
      ),
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
        GeneralFunctions.toastMessage('기능 구현 중...');
      }
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }
}
