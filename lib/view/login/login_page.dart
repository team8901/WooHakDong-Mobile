import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/login/components/google_login_button.dart';
import 'package:woohakdong/view/login/components/introduce_word.dart';

import '../themes/spacing.dart';
import 'components/recommend_word.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 100,
            left: defaultPaddingM,
            right: defaultPaddingM,
            bottom: defaultPaddingM,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntroduceWord(),
              Spacer(),
              RecommendWord(),
              Gap(defaultGapS),
              GoogleLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
