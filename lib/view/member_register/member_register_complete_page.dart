import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view/club_register/club_register_page.dart';
import 'package:woohakdong/view/member_register/components/member_register_complete_introduce.dart';

import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interaction/custom_pop_scope.dart';
import '../themes/spacing.dart';

class MemberRegisterCompletePage extends ConsumerWidget {
  const MemberRegisterCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomPopScope(
      child: Scaffold(
        appBar: AppBar(),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: defaultPaddingM * 3,
              left: defaultPaddingM,
              right: defaultPaddingM,
            ),
            child: MemberRegisterCompleteIntroduce(),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () => _pushClubRegisterPage(context),
            buttonText: '우학동 시작하기',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }

  void _pushClubRegisterPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => const ClubRegisterPage()),
      (route) => false,
    );
  }
}
