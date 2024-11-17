import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomInfoContent extends StatelessWidget {
  final String infoContent;
  final Icon? icon;
  final bool? isUnderline;

  const CustomInfoContent({
    super.key,
    required this.infoContent,
    this.icon,
    this.isUnderline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) icon!,
        if (icon != null) const Gap(defaultGapM),
        Expanded(
          child: Text(
            infoContent,
            style: context.textTheme.titleSmall?.copyWith(
              decoration: isUnderline! ? TextDecoration.underline : null,
              decorationColor: context.colorScheme.outline,
              decorationThickness: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
