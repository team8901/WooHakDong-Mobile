import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woohakdong/view/club_register/club_register_caution_page_.dart';

import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/spacing.dart';
import 'components/club_register_introduce.dart';

class ClubRegisterPage extends StatelessWidget {
  const ClubRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 100,
            left: defaultPaddingM,
            right: defaultPaddingM,
          ),
          child: ClubRegisterIntroduce(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () => _pushCautionPage(context),
          buttonText: '동아리 등록하기',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
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
