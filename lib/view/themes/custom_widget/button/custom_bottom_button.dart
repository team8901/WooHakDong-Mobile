import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../spacing.dart';
import '../interaction/custom_circular_progress_indicator.dart';

class CustomBottomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final bool isLoading;

  const CustomBottomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    this.isLoading = false,
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
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
        highlightColor: context.colorScheme.surfaceContainer,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadiusM),
            color: buttonColor,
          ),
          child: isLoading
              ? const CustomCircularProgressIndicator()
              : Center(
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
