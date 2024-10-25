import 'package:flutter/material.dart';
import 'package:flutter/services.dart';import 'package:woohakdong/view/login/components/google_login_button.dart';
import 'package:woohakdong/view/login/components/login_introduce.dart';

import '../../service/general/general_functions.dart';
import '../themes/spacing.dart';
import 'components/login_recommend.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? currentBackPressTime;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) {
        final now = DateTime.now();

        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
          currentBackPressTime = now;

          GeneralFunctions.generalToastMessage("한 번 더 누르면 앱이 종료돼요");

          return;
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: defaultPaddingM * 3,
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
        bottomNavigationBar: const SafeArea(
          child: GoogleLoginButton(),
        ),
      ),
    );
  }
}
