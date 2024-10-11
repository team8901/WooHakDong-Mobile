import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view/member_register/components/member_register_bottom_button.dart';

import '../../model/member/member_model.dart';
import '../../view_model/member/member_provider.dart';
import '../themes/spacing.dart';
import 'components/member_info_input_form.dart';
import 'member_register_info_check_page.dart';

class MemberRegisterInfoFormPage extends ConsumerWidget {
  const MemberRegisterInfoFormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final memberNotifier = ref.read(memberProvider.notifier);
    final member = ref.watch(memberProvider);

    return member.when(
      data: (memberInfo) {
        if (memberInfo == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('회원 정보를 불러올 수 없습니다.'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPaddingM,
                vertical: defaultPaddingM,
              ),
              child: MemberInfoInputForm(
                formKey: formKey,
                memberInfo: memberInfo,
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: MemberRegisterBottomButton(
              onTap: () {
                if (formKey.currentState?.validate() == true) {
                  formKey.currentState?.save();
                  memberNotifier.saveMemberInfo(memberInfo);
                  _pushCheckPage(context, memberInfo);
                }
              },
              buttonText: '다음',
              buttonColor: Theme.of(context).colorScheme.primary,
              buttonTextColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('에러 발생: $error'),
        ),
      ),
    );
  }

  void _pushCheckPage(BuildContext context, Member member) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const MemberRegisterInfoCheckPage(),
      ),
    );
  }
}
