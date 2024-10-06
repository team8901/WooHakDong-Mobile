import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view/member_register/components/register_bottom_button.dart';

import '../../view_model/member/member_provider.dart';
import '../../view_model/user/user_info_provider.dart';
import '../themes/spacing.dart';
import 'components/member_info_input_form.dart';
import 'member_register_info_check_page.dart';

class MemberRegisterInfoFormPage extends ConsumerWidget {
  const MemberRegisterInfoFormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final userInfo = ref.watch(userInfoProvider);
    final memberNotifier = ref.read(memberProvider.notifier);
    final member = ref.read(memberProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPaddingM,
            vertical: defaultPaddingM,
          ),
          child: userInfo.when(
            data: (userModel) => MemberInfoInputForm(
              formKey: formKey,
              userModel: userModel,
              member: member,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: RegisterBottomButton(
          onTap: () {
            if (formKey.currentState?.validate() == true) {
              formKey.currentState?.save();
              memberNotifier.updateMember(member);
              _pushCheckPage(context);
            }
          },
          buttonText: '다음',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  void _pushCheckPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const MemberRegisterInfoCheckPage()),
    );
  }
}
