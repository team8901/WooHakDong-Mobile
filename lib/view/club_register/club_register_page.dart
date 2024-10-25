import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woohakdong/view/club_register/club_register_caution_page_.dart';

import '../../service/general/general_functions.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/spacing.dart';
import 'components/club_register_introduce.dart';

class ClubRegisterPage extends StatelessWidget {
  const ClubRegisterPage({super.key});

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
            ),
            child: ClubRegisterIntroduce(),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () => _pushCautionPage(context),
            buttonText: '등록할게요',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }

  void _pushCautionPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterCautionPage(),
      ),
    );
  }
}
