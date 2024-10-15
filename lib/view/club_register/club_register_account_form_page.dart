import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club/club_account_provider.dart';
import '../../view_model/club/club_account_validation_provider.dart';
import '../../view_model/club/club_provider.dart';
import '../../view_model/club/components/club_account_validation_state.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/custom_widget/custom_dropdown_form_field.dart';
import '../themes/custom_widget/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'club_register_complete_page.dart';

class ClubRegisterAccountFormPage extends ConsumerStatefulWidget {
  const ClubRegisterAccountFormPage({super.key});

  @override
  ConsumerState<ClubRegisterAccountFormPage> createState() => _ClubRegisterAccountFormPageState();
}

class _ClubRegisterAccountFormPageState extends ConsumerState<ClubRegisterAccountFormPage> {
  final formKey = GlobalKey<FormState>();
  String clubAccountBankName = '';
  late TextEditingController clubAccountNumberController;

  @override
  void initState() {
    super.initState();
    clubAccountNumberController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    clubAccountNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clubInfo = ref.watch(clubProvider);
    final clubAccountValidationState = ref.watch(clubAccountValidationProvider);
    final clubAccountInfo = ref.watch(clubAccountProvider);
    final clubAccountNotifier = ref.read(clubAccountProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPaddingM,
            vertical: defaultPaddingM,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '마지막으로 계좌를 확인해야 해요',
                  style: context.textTheme.headlineSmall,
                ),
                const Gap(defaultGapXL * 2),
                IgnorePointer(
                  ignoring: isClubAccountValid(clubAccountValidationState),
                  child: CustomDropdownFormField(
                    labelText: '동아리 계좌 은행',
                    items: const [
                      {'value': '국민은행', 'displayText': 'KB 국민은행'},
                      {'value': '신한은행', 'displayText': '신한은행'},
                    ],
                    onChanged: (value) => clubAccountBankName = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '동아리 계좌 은행을 선택해 주세요';
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(defaultGapXL),
                CustomTextFormField(
                  controller: clubAccountNumberController,
                  labelText: '동아리 계좌',
                  onSaved: (value) => clubAccountInfo.clubAccountNumber = value!,
                  readOnly: isClubAccountValid(clubAccountValidationState),
                  hintText: '동아리 계좌를 - 없이 입력해 주세요',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '동아리 계좌를 입력해 주세요';
                    }
                    return null;
                  },
                ),
                const Gap(defaultGapXL),
                if (isClubAccountValid(clubAccountValidationState))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '동아리 계좌가 인증되었어요',
                        style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.tertiary),
                      ),
                      const Gap(defaultGapXL),
                      Text(
                        '동아리 계좌 핀테크 번호',
                        style: context.textTheme.labelLarge?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      const Gap(defaultGapS),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: context.colorScheme.surfaceContainer),
                          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPaddingS,
                          vertical: defaultPaddingXS,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '*' * (clubAccountInfo.clubAccountPinTechNumber?.length ?? 0),
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ],
                  )
                else if (clubAccountValidationState == ClubAccountValidationState.invalid)
                  Text(
                    '유효하지 않은 계좌예요',
                    style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.error),
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

              if (isClubAccountValid(clubAccountValidationState)) {
                await clubAccountNotifier.registerClubAccount(clubInfo.clubId);

                if (context.mounted) {
                  _pushCompletePage(context);
                }
              } else {
                await clubAccountNotifier.saveClubAccountInfo(
                  clubAccountBankName,
                  clubAccountNumberController.text,
                );
              }
            }
          },
          buttonText: (isClubAccountValid(clubAccountValidationState)) ? '완료' : '계좌 인증',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  bool isClubAccountValid(ClubAccountValidationState clubAccountValidationState) =>
      clubAccountValidationState == ClubAccountValidationState.valid;

  void _pushCompletePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterCompletePage(),
      ),
      (route) => false,
    );
  }
}
