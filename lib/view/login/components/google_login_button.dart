import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/service/auth/google_sign_in_service.dart';

import '../../themes/spacing.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => GoogleSignInService.signInWithGoogle(),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logos/google.png',
              width: 20,
              height: 20,
            ),
            const Gap(defaultGapM),
            Text(
              'Goolge로 시작하기',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
