import 'package:flutter/material.dart';

import '../../themes/spacing.dart';

class MemberRegisterButton extends StatelessWidget {
  const MemberRegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            '우학동 가입하기',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
        ),
      ),
    );
  }
}
