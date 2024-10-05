import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/member/member_provider.dart';
import '../themes/spacing.dart';
import 'components/member_register_button.dart';
import 'member_register_complete_page.dart';

class MemberRegisterInfoCheckPage extends ConsumerWidget {
  const MemberRegisterInfoCheckPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(memberProvider);
    final memberNotifier = ref.read(memberProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: defaultPaddingM,
            left: defaultPaddingM,
            right: defaultPaddingM,
            bottom: defaultPaddingM,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('회장님의 정보가 맞으신가요?', style: context.textTheme.titleLarge),
              const Gap(defaultGapXL * 2),
              Text(
                '이메일',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(defaultGapS / 2),
              Text(member.email, style: context.textTheme.titleSmall),
              const Gap(defaultGapXL),
              Text(
                '이름',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(defaultGapS / 2),
              Text(member.name, style: context.textTheme.titleSmall),
              const Gap(defaultGapXL),
              Text(
                '성별',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(defaultGapS / 2),
              Text(member.gender, style: context.textTheme.titleSmall),
              const Gap(defaultGapXL),
              Text(
                '학과',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(defaultGapS / 2),
              Text(member.department, style: context.textTheme.titleSmall),
              const Gap(defaultGapXL),
              Text(
                '학번',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(defaultGapS / 2),
              Text(member.studentId, style: context.textTheme.titleSmall),
              const Gap(defaultGapXL),
              Text(
                '휴대폰 번호',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(defaultGapS / 2),
              Text(member.phoneNumber, style: context.textTheme.titleSmall),
              const Spacer(),
              MemberRegisterButton(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const MemberRegisterCompletePage(),
                    ),
                  );
                },
                buttonText: '완료',
                buttonColor: Theme.of(context).colorScheme.primary,
                buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
