import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../themes/spacing.dart';

class MemberRegisterButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;

  const MemberRegisterButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: context.textTheme.titleMedium?.copyWith(
              color: buttonTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
