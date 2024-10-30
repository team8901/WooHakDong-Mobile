import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:woohakdong/model/club_member/club_member.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../themes/custom_widget/custom_info_box.dart';
import '../themes/custom_widget/custom_info_content.dart';
import 'components/club_member_role_box.dart';
import 'components/club_member_role_dialog.dart';

class ClubMemberDetailPage extends StatefulWidget {
  final ClubMember clubMember;

  const ClubMemberDetailPage({
    super.key,
    required this.clubMember,
  });

  @override
  State<ClubMemberDetailPage> createState() => _ClubMemberDetailPageState();
}

class _ClubMemberDetailPageState extends State<ClubMemberDetailPage> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.clubMember.clubMemberRole;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.clubMember.clubMemberRole != 'PRESIDENT')
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ClubMemberRoleDialog(
                  selectedRole: _selectedRole,
                  onRoleSelected: (value) => setState(() {
                    _selectedRole = value;
                  }),
                ),
              ),
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
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      widget.clubMember.memberName!,
                      style: context.textTheme.headlineLarge,
                    ),
                    const Gap(defaultGapS),
                    ClubMemberRoleBox(clubMember: widget.clubMember),
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
                      infoContent: GeneralFunctions.formatMemberGender(widget.clubMember.memberGender!),
                      icon: Icon(
                        Symbols.wc_rounded,
                        size: 16,
                        color: context.colorScheme.outline,
                      ),
                    ),
                    const Gap(defaultGapM),
                    CustomInfoContent(
                      infoContent: GeneralFunctions.formatMemberPhoneNumber(widget.clubMember.memberPhoneNumber!),
                      icon: Icon(
                        Symbols.call_rounded,
                        size: 16,
                        color: context.colorScheme.outline,
                      ),
                    ),
                    const Gap(defaultGapM),
                    CustomInfoContent(
                      infoContent: widget.clubMember.memberEmail!,
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
                      infoContent: widget.clubMember.memberSchool!,
                      icon: Icon(
                        Symbols.school_rounded,
                        size: 16,
                        color: context.colorScheme.outline,
                      ),
                    ),
                    const Gap(defaultGapM),
                    CustomInfoContent(
                      infoContent: widget.clubMember.memberMajor!,
                      icon: Icon(
                        Symbols.book_rounded,
                        size: 16,
                        color: context.colorScheme.outline,
                      ),
                    ),
                    const Gap(defaultGapM),
                    CustomInfoContent(
                      infoContent: widget.clubMember.memberStudentNumber!,
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
                  '가입일: ${widget.clubMember.clubJoinedDate!.year}년 ${widget.clubMember.clubJoinedDate!.month}월 ${widget.clubMember.clubJoinedDate!.day}일',
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
