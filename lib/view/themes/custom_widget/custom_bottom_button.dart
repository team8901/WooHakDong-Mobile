import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../spacing.dart';

class CustomBottomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;

  const CustomBottomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: defaultPaddingM,
        right: defaultPaddingM,
        bottom: defaultPaddingM,
      ),
      width: double.infinity,
      height: 52,
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
        onTap: onTap,
        child: Ink(
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
      ),
    );
  }
}
