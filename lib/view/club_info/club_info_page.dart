import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_info/components/box/club_info_box.dart';
import 'package:woohakdong/view/club_info/components/box/club_info_group_manage_box.dart';
import 'package:woohakdong/view/club_info/components/box/club_info_manage_box.dart';
import 'package:woohakdong/view/club_info/components/box/club_info_member_manage_box.dart';
import 'package:woohakdong/view/club_info/components/club_info_action_button.dart';
import 'package:woohakdong/view/delegation/delegation_page.dart';
import 'package:woohakdong/view/group/group_list_page.dart';
import 'package:woohakdong/view/setting/setting_page.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_tap_debouncer.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/club_list_provider.dart';

import '../../service/general/general_functions.dart';
import '../../view_model/club/current_club_info_provider.dart';
import '../../view_model/club_member/club_member_count_provider.dart';
import '../../view_model/club_member/club_member_me_provider.dart';
import '../../view_model/group/group_provider.dart';
import '../../view_model/item/item_count_provider.dart';
import '../themes/custom_widget/dialog/custom_interaction_dialog.dart';
import '../themes/spacing.dart';
import 'club_info_detail_page.dart';
import 'club_info_promotion_page.dart';
import 'components/club_info_bottom_sheet.dart';

class ClubInfoPage extends ConsumerWidget {
  const ClubInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubInfo = ref.watch(currentClubInfoProvider);
    final clubMemberMe = ref.watch(clubMemberMeProvider);
    final clubMemberCount = ref.watch(clubMemberCountProvider);
    final itemCount = ref.watch(itemCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: CustomTapDebouncer(
          onTap: () async {
            await ref.read(clubListProvider.notifier).getClubList();

            if (context.mounted) {
              showModalBottomSheet(
                useSafeArea: true,
                context: context,
                builder: (context) => ClubInfoBottomSheet(
                  currentClubId: currentClubInfo.clubId!,
                  clubList: ref.watch(clubListProvider),
                ),
              );
            }
          },
          builder: (context, onTap) {
            return InkWell(
              onTap: onTap,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('내 동아리'),
                  Gap(defaultGapS / 2),
                  Icon(
                    Symbols.keyboard_arrow_down_rounded,
                    size: 20,
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () => _pushSettingPage(context),
            icon: const Icon(Symbols.settings_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClubInfoBox(
                currentClubInfo: currentClubInfo,
                clubMemberCount: clubMemberCount,
                itemCount: itemCount,
              ),
              const Gap(defaultGapXL),
              ClubInfoActionButton(
                onTapDetail: () => _pushClubInfoDetailPage(context),
                onTapPromotion: () => _pushClubPromotionPage(ref, context),
              ),
              const Gap(defaultGapXL * 2),
              ClubInfoGroupManageBox(onTap: () => _pushGroupPage(context)),
              const Gap(defaultGapXL),
              ClubInfoFileManageBox(
                onClubMemberExportTap: () => GeneralFunctions.toastMessage('기능 구현 중...'),
                onClubItemExportTap: () => GeneralFunctions.toastMessage('기능 구현 중...'),
                onClubDuesExportTap: () => GeneralFunctions.toastMessage('기능 구현 중...'),
              ),
              if (clubMemberMe.clubMemberRole == 'PRESIDENT')
                Column(
                  children: [
                    const Gap(defaultGapXL),
                    ClubInfoManageBox(
                      onClubDeleteTap: () => GeneralFunctions.toastMessage('기능 구현 중...'),
                      onDelegatePresidentTap: () => _delegatePresident(context, clubMemberMe.memberName!),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _pushSettingPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const SettingPage(),
      ),
    );
  }

  void _pushClubInfoDetailPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubInfoDetailPage(),
      ),
    );
  }

  Future<void> _pushClubPromotionPage(WidgetRef ref, BuildContext context) async {
    await ref.read(groupProvider.notifier).getClubRegisterInfo();

    if (context.mounted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ClubInfoPromotionPage(),
        ),
      );
    }
  }

  void _pushGroupPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const GroupListPage(),
      ),
    );
  }

  Future<void> _delegatePresident(BuildContext context, String memberName) async {
    try {
      final bool? isDelegate = await showDialog<bool>(
        context: context,
        builder: (context) => CustomInteractionDialog(
          dialogTitle: '회장 위임',
          dialogContent: '회장 위임 전, 안내사항이에요.\n\n• $memberName님은 임원으로 변경돼요.\n• 새로운 회장님은 동아리 회비 계좌를 새로 등록해야 해요.',
          dialogButtonText: '확인',
          dialogButtonColor: context.colorScheme.primary,
        ),
      );

      if (isDelegate == true) {
        if (context.mounted) {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const DelegationPage()),
          );
        }
      }
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }
}
