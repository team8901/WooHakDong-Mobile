import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club/club_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'club_register_info_check_page.dart';

class ClubRegisterOtherInfoFormPage extends ConsumerWidget {
  const ClubRegisterOtherInfoFormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final clubNotifier = ref.read(clubProvider.notifier);
    final clubInfo = ref.watch(clubProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '동아리의 다른 정보도 필요해요',
                  style: context.textTheme.headlineSmall,
                ),
                const Gap(defaultGapXL * 2),
                Text(
                  '동아리 추가 정보',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  labelText: '현재 기수',
                  hintText: '비워놔도 돼요',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) => clubInfo.clubGeneration = value,
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  labelText: '동아리 회비',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CurrencyTextInputFormatter.currency(
                      symbol: '',
                      locale: 'ko_KR',
                    )
                  ],
                  onSaved: (value) => clubInfo.clubDues = int.parse(value!.replaceAll(',', '')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '동아리 회비를 입력해 주세요';
                    }
                    return null;
                  },
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  labelText: '동아리 방',
                  hintText: '비워놔도 돼요',
                  onSaved: (value) => clubInfo.clubRoom = value,
                ),
                const Gap(defaultGapXL),
                Text(
                  '카카오톡 채팅방',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  labelText: '카카오톡 채팅방 링크',
                  keyboardType: TextInputType.text,
                  onSaved: (value) => clubInfo.clubGroupChatLink = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '카카오톡 채팅방 링크를 입력해 주세요';
                    }
                    return null;
                  },
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  labelText: '카카오톡 채팅방 비밀번호',
                  hintText: '비워놔도 돼요',
                  onSaved: (value) => clubInfo.clubGroupChatPassword = value,
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () async {
            if (formKey.currentState?.validate() == true) {
              formKey.currentState?.save();

              clubNotifier.saveClubOtherInfo(
                clubInfo.clubGeneration!,
                clubInfo.clubDues!,
                clubInfo.clubRoom!,
                clubInfo.clubGroupChatLink!,
                clubInfo.clubGroupChatPassword!,
              );

              if (context.mounted) {
                _pushInfoCheckPage(context);
              }
            }
          },
          buttonText: '다음',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  void _pushInfoCheckPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterInfoCheckPage(),
      ),
    );
  }
}
