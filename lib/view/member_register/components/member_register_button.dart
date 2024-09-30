import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../view_model/auth/auth_provider.dart';
import '../../themes/spacing.dart';

class MemberRegisterButton extends ConsumerWidget {
  const MemberRegisterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);

    return InkWell(
      onTap: () => authNotifier.signOut(),
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
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.inversePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
