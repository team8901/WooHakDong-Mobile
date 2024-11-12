import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../spacing.dart';

class CustomInfoBox extends StatelessWidget {
  final String infoTitle;
  final Widget? infoTitleIcon;
  final Widget child;

  const CustomInfoBox({
    super.key,
    required this.infoTitle,
    this.infoTitleIcon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              infoTitle,
              style: context.textTheme.labelLarge,
            ),
            const Gap(defaultGapS),
            if (infoTitleIcon != null) infoTitleIcon!,
          ],
        ),
        const Gap(defaultGapM),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.surfaceContainer),
            borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPaddingS,
            vertical: defaultPaddingXS,
          ),
          child: child,
        ),
      ],
    );
  }
}
