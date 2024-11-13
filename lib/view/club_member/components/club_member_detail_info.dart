import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';
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
          infoTitleIcon: Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: '휴대폰 번호와 이메일을 한 번 누르면 복사,\n꾹 누르면 바로 연결돼요',
            textStyle: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFFCFCFC),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingS,
              vertical: defaultPaddingXS,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF6C6E75).withOpacity(0.8),
              borderRadius: BorderRadius.circular(defaultBorderRadiusL),
            ),
            child: const Icon(
              Symbols.info_rounded,
              size: 14,
            ),
          ),
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
              GestureDetector(
                onTap: () => GeneralFunctions.clipboardCopy(clubMember.memberPhoneNumber!, '휴대폰 번호를 복사했어요'),
                onLongPress: () => _makePhoneCall(clubMember.memberPhoneNumber!),
                child: CustomInfoContent(
                  isUnderline: true,
                  infoContent: GeneralFunctions.formatMemberPhoneNumber(clubMember.memberPhoneNumber!),
                  icon: Icon(
                    Symbols.call_rounded,
                    size: 16,
                    color: context.colorScheme.outline,
                  ),
                ),
              ),
              const Gap(defaultGapM),
              GestureDetector(
                onTap: () => GeneralFunctions.clipboardCopy(clubMember.memberEmail!, '이메일을 복사했어요'),
                onLongPress: () => _sendEmail(clubMember.memberEmail!),
                child: CustomInfoContent(
                  isUnderline: true,
                  infoContent: clubMember.memberEmail!,
                  icon: Icon(
                    Symbols.alternate_email_rounded,
                    size: 16,
                    color: context.colorScheme.outline,
                  ),
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

  void _makePhoneCall(String phoneNumber) async {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    }
  }

  void _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }
}
