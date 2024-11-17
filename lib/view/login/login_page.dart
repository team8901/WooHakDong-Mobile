import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view/login/components/google_login_button.dart';
import 'package:woohakdong/view/login/components/login_introduce.dart';

import '../../view_model/auth/auth_provider.dart';
import '../../view_model/auth/components/auth_state_provider.dart';
import '../themes/custom_widget/interaction/custom_pop_scope.dart';
import '../themes/spacing.dart';
import 'components/login_recommend.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return CustomPopScope(
      child: Scaffold(
        appBar: AppBar(),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: defaultPaddingM * 3,
              left: defaultPaddingM,
              right: defaultPaddingM,
              bottom: defaultGapS,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginIntroduce(),
                Spacer(),
                LoginRecommned(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: GoogleLoginButton(
            authState: authState,
            authNotifier: authNotifier,
          ),
        ),
      ),
    );
  }
}
