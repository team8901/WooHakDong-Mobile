import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/custom_widget/interface/custom_info_box.dart';
import 'package:woohakdong/view/themes/custom_widget/interface/custom_info_content.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../service/general/general_format.dart';
import '../../view_model/member/components/member_state.dart';
import '../../view_model/member/components/member_state_provider.dart';
import '../../view_model/member/member_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/spacing.dart';
import 'member_register_complete_page.dart';

class MemberRegisterInfoCheckPage extends ConsumerWidget {
  const MemberRegisterInfoCheckPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberInfo = ref.watch(memberProvider)!;
    final memberNotifier = ref.read(memberProvider.notifier);
    final memberState = ref.watch(memberStateProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: context.textTheme.bodySmall,
        title: const Text('2 / 2'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPaddingM),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('회장님의 정보가 맞으신가요?', style: context.textTheme.headlineSmall),
                const Gap(defaultGapXL * 2),
                CustomInfoBox(
                  infoTitle: '기본 정보',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInfoContent(
                        infoContent: memberInfo.memberName,
                        icon: Icon(
                          Symbols.account_box_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                      const Gap(defaultGapM),
                      CustomInfoContent(
                        infoContent: GeneralFormat.formatMemberGender(memberInfo.memberGender!),
                        icon: Icon(
                          Symbols.wc_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                      const Gap(defaultGapM),
                      CustomInfoContent(
                        infoContent: GeneralFormat.formatMemberPhoneNumber(memberInfo.memberPhoneNumber!),
                        icon: Icon(
                          Symbols.call_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                      const Gap(defaultGapM),
                      CustomInfoContent(
                        infoContent: memberInfo.memberEmail,
                        icon: Icon(
                          Symbols.alternate_email_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(defaultGapXL),
                CustomInfoBox(
                  infoTitle: '학교 정보',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInfoContent(
                        infoContent: memberInfo.memberSchool,
                        icon: Icon(
                          Symbols.school_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                      const Gap(defaultGapM),
                      CustomInfoContent(
                        infoContent: memberInfo.memberMajor!,
                        icon: Icon(
                          Symbols.book_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                      const Gap(defaultGapM),
                      CustomInfoContent(
                        infoContent: memberInfo.memberStudentNumber!,
                        icon: Icon(
                          Symbols.id_card_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () async {
            try {
              await memberNotifier.registerMember();

              if (context.mounted) {
                _pushCompletePage(context);
              }
            } catch (e) {
              await GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
            }
          },
          buttonText: '맞아요',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          isLoading: memberState == MemberState.memberRegistering,
        ),
      ),
    );
  }

  void _pushCompletePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => const MemberRegisterCompletePage()),
      (route) => false,
    );
  }
}
