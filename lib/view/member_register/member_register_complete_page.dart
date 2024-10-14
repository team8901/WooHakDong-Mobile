import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view/club_register/club_register_page.dart';
import 'package:woohakdong/view/member_register/components/member_register_complete_introduce.dart';

import '../../view_model/auth/auth_provider.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/spacing.dart';

class MemberRegisterCompletePage extends ConsumerWidget {
  const MemberRegisterCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 100,
            left: defaultPaddingM,
            right: defaultPaddingM,
            bottom: defaultPaddingM,
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
