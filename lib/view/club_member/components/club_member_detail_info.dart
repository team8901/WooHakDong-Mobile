import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/club_member/club_member.dart';
import '../../../service/general/general_functions.dart';
import '../../themes/custom_widget/interface/custom_info_box.dart';
import '../../themes/custom_widget/interface/custom_info_content.dart';
import '../../themes/spacing.dart';
import 'club_member_role_box.dart';

class ClubMemberDetailInfo extends StatelessWidget {
  const ClubMemberDetailInfo({
    super.key,
    required this.clubMember,
  });

  final ClubMember clubMember;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              Text(
                clubMember.memberName!,
                style: context.textTheme.headlineLarge,
              ),
              const Gap(defaultGapS),
              ClubMemberRoleBox(clubMember: clubMember),
            ],
          ),
        ),
        const Gap(defaultPaddingM * 2),
        CustomInfoBox(
          infoTitle: '기본 정보',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInfoContent(
                infoContent: GeneralFunctions.formatMemberGender(clubMember.memberGender!),
                icon: Icon(
                  Symbols.wc_rounded,
                  size: 16,
                  color: context.colorScheme.outline,
                ),
              ),
              const Gap(defaultGapM),
              CustomInfoContent(
                infoContent: GeneralFunctions.formatMemberPhoneNumber(clubMember.memberPhoneNumber!),
                icon: Icon(
                  Symbols.call_rounded,
                  size: 16,
                  color: context.colorScheme.outline,
                ),
              ),
              const Gap(defaultGapM),
              CustomInfoContent(
                infoContent: clubMember.memberEmail!,
                icon: Icon(
                  Symbols.alternate_email_rounded,
                  size: 16,
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
        const Gap(defaultPaddingM),
        CustomInfoBox(
          infoTitle: '학교 정보',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInfoContent(
                infoContent: clubMember.memberMajor!,
                icon: Icon(
                  Symbols.book_rounded,
                  size: 16,
                  color: context.colorScheme.outline,
                ),
              ),
              const Gap(defaultGapM),
              CustomInfoContent(
                infoContent: clubMember.memberStudentNumber!,
                icon: Icon(
                  Symbols.id_card_rounded,
                  size: 16,
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
        const Gap(defaultPaddingM),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '가입일: ${clubMember.clubJoinedDate!.year}년 ${clubMember.clubJoinedDate!.month}월 ${clubMember.clubJoinedDate!.day}일',
            style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
          ),
        ),
      ],
    );
  }
}
