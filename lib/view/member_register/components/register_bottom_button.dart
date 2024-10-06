import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../themes/spacing.dart';

class RegisterBottomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;

  const RegisterBottomButton({
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
        margin: const EdgeInsets.only(
          left: defaultPaddingM,
          right: defaultPaddingM,
          bottom: defaultPaddingM,
        ),
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
