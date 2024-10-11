import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../themes/spacing.dart';
import 'components/member_register_bottom_button.dart';
import 'components/register_introduce_word.dart';
import 'member_register_info_form_page.dart';

class MemberRegisterPage extends ConsumerWidget {
  const MemberRegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 100,
            left: defaultPaddingM,
            right: defaultPaddingM,
          ),
          child: RegisterIntroduceWord(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: MemberRegisterBottomButton(
          onTap: () => _pushInputPage(context),
          buttonText: '우학동 가입하기',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  void _pushInputPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const MemberRegisterInfoFormPage(),
      ),
    );
  }
}
