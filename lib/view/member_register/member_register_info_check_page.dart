import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/member_register/components/member_info_check.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/member/member_model.dart';
import '../../view_model/member/member_provider.dart';
import '../themes/spacing.dart';
import 'components/member_register_bottom_button.dart';
import 'member_register_complete_page.dart';

class MemberRegisterInfoCheckPage extends ConsumerWidget {
  final Member memberInfo;

  const MemberRegisterInfoCheckPage({
    super.key,
    required this.memberInfo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberNotifier = ref.read(memberProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('회장님의 정보가 맞으신가요?', style: context.textTheme.titleLarge),
              const Gap(defaultGapXL * 2),
              MemberInfoCheck(infoTitle: '학교', infoContent: memberInfo.memberSchool),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '이메일 주소', infoContent: memberInfo.memberEmail),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '이름', infoContent: memberInfo.memberName),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '성별', infoContent: _getGenderDisplay(memberInfo.memberGender!)),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '학과', infoContent: memberInfo.memberMajor!),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '학번', infoContent: memberInfo.memberStudentNumber!),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '휴대폰 번호', infoContent: memberInfo.memberPhoneNumber!),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: MemberRegisterBottomButton(
          onTap: () async {
            await memberNotifier.registerMemberInfo(memberInfo);

            if (context.mounted) {
              _pushCompletePage(context);
            }
          },
          buttonText: '완료',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  String _getGenderDisplay(String? gender) {
    if (gender == 'MAN') {
      return '남성';
    } else {
      return '여성';
    }
  }

  void _pushCompletePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => const MemberRegisterCompletePage()),
      (route) => false,
    );
  }
}
