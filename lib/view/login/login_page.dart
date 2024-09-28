import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/login/components/google_login_button.dart';
import 'package:woohakdong/view/login/components/introduce_word.dart';

import '../themes/spacing.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 140,
          left: defaultPaddingM,
          right: defaultPaddingM,
          bottom: 70,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IntroduceWord(),
            const Spacer(),
            Center(
              child: Text(
                '학교 계정으로 로그인해 주세요',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const Gap(defaultGapS),
            const GoogleLoginButton(),
          ],
        ),
      ),
    );
  }
}
