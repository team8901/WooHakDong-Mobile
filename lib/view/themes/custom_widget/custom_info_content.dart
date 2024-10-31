import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomInfoContent extends StatelessWidget {
  final String infoContent;
  final Icon? icon;

  const CustomInfoContent({
    super.key,
    required this.infoContent,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) icon!,
        if (icon != null) const Gap(defaultGapM),
        Text(infoContent, style: context.textTheme.titleSmall),
      ],
    );
  }
}
