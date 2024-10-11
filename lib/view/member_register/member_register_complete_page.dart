import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view/member_register/components/register_complete_word.dart';

import '../../view_model/auth/auth_provider.dart';
import '../themes/spacing.dart';
import 'components/member_register_bottom_button.dart';

class MemberRegisterCompletePage extends ConsumerWidget {
  const MemberRegisterCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 100,
            left: defaultPaddingM,
            right: defaultPaddingM,
            bottom: defaultPaddingM,
          ),
          child: RegisterCompleteWord(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: MemberRegisterBottomButton(
          onTap: () {
            authNotifier.signOut();
          },
          buttonText: '동아리 등록하기',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
