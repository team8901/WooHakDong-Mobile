import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/auth/auth_provider.dart';
import 'package:woohakdong/view_model/auth/components/auth_state_provider.dart';

import '../../../view_model/auth/components/auth_state.dart';
import '../../themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import '../../themes/spacing.dart';

class GoogleLoginButton extends ConsumerWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Container(
      margin: const EdgeInsets.only(
        left: defaultPaddingM,
        right: defaultPaddingM,
        bottom: defaultPaddingM * 3,
      ),
      width: double.infinity,
      height: 52,
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
        onTap: authState == AuthState.loading ? null : () => authNotifier.signIn(),
        highlightColor: context.colorScheme.outline,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadiusM),
            color: context.colorScheme.surfaceContainer,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logos/google.png',
                  width: 18,
                  height: 18,
                ),
                const Gap(defaultGapM),
                (authState == AuthState.loading)
                    ? const CustomCircularProgressIndicator()
                    : Text(
                        'Google계정으로 로그인',
                        style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
