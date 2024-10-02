import 'package:flutter/material.dart';
import '../themes/spacing.dart';
import 'components/member_register_button.dart';
import 'components/member_register_word.dart';

class MemberRegisterPage extends StatelessWidget {
  const MemberRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 140,
          left: defaultPaddingM,
          right: defaultPaddingM,
          bottom: 70,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MemberRegisterWord(),
            Spacer(),
            MemberRegisterButton(),
          ],
        ),
      ),
    );
  }
}
