import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_info/components/club_info_action_buitton.dart';
import 'package:woohakdong/view/club_info/components/club_info_box.dart';
import 'package:woohakdong/view/setting/setting_page.dart';
import 'package:woohakdong/view_model/club/club_list_provider.dart';

import '../../view_model/club/current_club_info_provider.dart';
import '../../view_model/club_member/club_member_count_provider.dart';
import '../../view_model/group/group_provider.dart';
import '../../view_model/item/item_count_provider.dart';
import '../themes/spacing.dart';
import 'club_info_detail_page.dart';
import 'club_info_promotion_page.dart';
import 'components/club_info_bottom_sheet.dart';

class ClubInfoPage extends ConsumerWidget {
  const ClubInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubInfo = ref.watch(currentClubInfoProvider);
    final clubMemberCount = ref.watch(clubMemberCountProvider);
    final itemCount = ref.watch(itemCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Text(currentClubInfo.clubName ?? '내 동아리', softWrap: false)),
              const Gap(defaultGapS / 2),
              const Icon(
                Symbols.keyboard_arrow_down_rounded,
                size: 20,
              ),
            ],
          ),
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
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(defaultPaddingM),
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
              const Gap(defaultGapXL),

              /// TODO 회장 역할 위임 버튼 만들기 (회장만 보이게)
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
    await ref.read(groupProvider.notifier).getClubRegisterPageInfo();

    if (context.mounted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ClubInfoPromotionPage(),
        ),
      );
    }
  }
}
