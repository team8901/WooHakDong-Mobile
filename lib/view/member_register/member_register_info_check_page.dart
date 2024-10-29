import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/custom_widget/custom_info_box.dart';
import 'package:woohakdong/view/themes/custom_widget/custom_info_content.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/member/member_provider.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/spacing.dart';
import 'member_register_complete_page.dart';

class MemberRegisterInfoCheckPage extends ConsumerWidget {
  const MemberRegisterInfoCheckPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberInfo = ref.watch(memberProvider)!;
    final memberNotifier = ref.read(memberProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
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
                      CustomInfoContent(infoContent: memberInfo.memberName),
                      const Gap(defaultGapM),
                      CustomInfoContent(
                        infoContent: GeneralFunctions.getGenderDisplay(memberInfo.memberGender!),
                        icon: Icon(
                          Symbols.wc_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                      const Gap(defaultGapM),
                      CustomInfoContent(
                        infoContent: GeneralFunctions.formatPhoneNumber(memberInfo.memberPhoneNumber!),
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
            await memberNotifier.registerMember();

            if (context.mounted) {
              _pushCompletePage(context);
            }
          },
          buttonText: '맞아요',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
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
