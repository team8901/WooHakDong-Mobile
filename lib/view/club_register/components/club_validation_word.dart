import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../themes/spacing.dart';

class ClubValidationWord extends StatelessWidget {
  final String validationWord;
  final Color color;

  const ClubValidationWord({
    super.key,
    required this.validationWord,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(defaultGapXL),
        Text(
          validationWord,
          style: context.textTheme.bodyMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}