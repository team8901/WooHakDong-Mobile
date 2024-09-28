import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../themes/spacing.dart';

class IntroduceWord extends StatelessWidget {
  const IntroduceWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '귀찮았던 동아리 관리\n',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              TextSpan(
                text: '우학동',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              TextSpan(
                text: '으로 간단하게',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
        const Gap(defaultGapS / 2),
        Text(
          '동아리 회원, 물품, 회비 그리고 일정까지\n우학동이 간단하게 만들어 드릴게요!',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
