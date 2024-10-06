import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/member_register/components/member_info_check.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/member/member_provider.dart';
import '../themes/spacing.dart';
import 'components/register_bottom_button.dart';
import 'member_register_complete_page.dart';

class MemberRegisterInfoCheckPage extends ConsumerWidget {
  const MemberRegisterInfoCheckPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(memberProvider);
    final memberNotifier = ref.read(memberProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: defaultPaddingM,
            left: defaultPaddingM,
            right: defaultPaddingM,
            bottom: defaultPaddingM,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('회장님의 정보가 맞으신가요?', style: context.textTheme.titleLarge),
              const Gap(defaultGapXL * 2),
              MemberInfoCheck(infoTitle: '이메일 주소', infoContent: member.memberEmail),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '이름', infoContent: member.memberName),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '성별', infoContent: member.memberGender),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '학과', infoContent: member.memberMajor),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '학번', infoContent: member.memberStudentNumber),
              const Gap(defaultGapXL),
              MemberInfoCheck(infoTitle: '휴대폰 번호', infoContent: member.memberPhoneNumber),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: RegisterBottomButton(
          onTap: () {
            //memberNotifier.woohakdongRegister(member);
            _pushCompletePage(context);
          },
          buttonText: '완료',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  void _pushCompletePage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const MemberRegisterCompletePage()),
    );
  }
}
