import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club_member/club_member_me_provider.dart';

import '../../view_model/club_member/club_member_provider.dart';
import '../themes/custom_widget/button/custom_info_tooltip.dart';
import 'components/club_member_detail_info.dart';
import 'components/club_member_item_history_panel.dart';
import 'components/dialog/club_member_role_edit_dialog.dart';

class ClubMemberDetailPage extends ConsumerWidget {
  const ClubMemberDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubMemberMe = ref.watch(clubMemberMeProvider);
    final clubMemberInfo = ref.watch(clubMemberProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (clubMemberMe.clubMemberRole == 'PRESIDENT' && clubMemberInfo.clubMemberRole != 'PRESIDENT')
            IconButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (context) => ClubMemberRoleEditDialog(
                    clubMemberId: clubMemberInfo.clubMemberId!,
                    initialRole: clubMemberInfo.clubMemberRole,
                  ),
                );
              },
              icon: const Icon(Symbols.settings_account_box_rounded),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: defaultPaddingM * 2,
            left: defaultPaddingM,
            right: defaultPaddingM,
            bottom: defaultPaddingM,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClubMemberDetailInfo(clubMember: clubMemberInfo),
              const Gap(defaultGapXL),
              Row(
                children: [
                  Text(
                    '대여 내역',
                    style: context.textTheme.labelLarge,
                  ),
                  const Gap(defaultGapS),
                  CustomInfoTooltip(tooltipMessage: '대여 내역을 누르면 ${clubMemberInfo.memberName}님이 대여한\n물품 정보를 확인할 수 있어요'),
                ],
              ),
              const Gap(defaultGapM),
              ClubMemberItemHistoryPanel(
                clubMemberName: clubMemberInfo.memberName!,
                clubMemberId: clubMemberInfo.clubMemberId!,
              ),
              const Gap(defaultGapXL),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '가입일: ${clubMemberInfo.clubJoinedDate!.year}년 ${clubMemberInfo.clubJoinedDate!.month}월 ${clubMemberInfo.clubJoinedDate!.day}일',
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
