import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class ClubRegisterCautionIntroduce extends StatelessWidget {
  const ClubRegisterCautionIntroduce({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '우선, ',
            style: context.textTheme.headlineLarge,
          ),
          TextSpan(
            text: '알아야 할 주의사항',
            style: context.textTheme.headlineLarge?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          TextSpan(
            text: '이에요',
            style: context.textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
