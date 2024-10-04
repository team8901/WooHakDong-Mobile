import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woohakdong/view/member_register/member_register_input_page.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../themes/spacing.dart';

class MemberRegisterButton extends StatelessWidget {
  const MemberRegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const MemberRegisterInputPage(),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            '우학동 가입하기',
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.inversePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
