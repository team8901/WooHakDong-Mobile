import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/login/components/google_login_button.dart';
import 'package:woohakdong/view/login/components/login_introduce.dart';

import '../themes/spacing.dart';
import 'components/login_recommend.dart';

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
            bottom: defaultGapS,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginIntroduce(),
              Spacer(),
              LoginRecommned(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: GoogleLoginButton(),
      ),
    );
  }
}
