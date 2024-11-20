import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:woohakdong/view/themes/custom_widget/button/custom_bottom_button.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/member/member_provider.dart';
import '../themes/custom_widget/interface/custom_dropdown_form_field.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'member_register_info_check_page.dart';

class MemberRegisterInfoFormPage extends ConsumerStatefulWidget {
  const MemberRegisterInfoFormPage({super.key});

  @override
  ConsumerState<MemberRegisterInfoFormPage> createState() => _MemberRegisterInfoFormPageState();
}

class _MemberRegisterInfoFormPageState extends ConsumerState<MemberRegisterInfoFormPage> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    mask: '###-####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  bool _isPhoneInitialized = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memberNotifier = ref.read(memberProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: context.textTheme.bodySmall,
        title: const Text('1 / 2'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: memberNotifier.getMemberInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomProgressIndicator();
            } else {
              final memberInfo = ref.watch(memberProvider);

              if (!_isPhoneInitialized && memberInfo?.memberPhoneNumber != null) {
                phoneController.text = maskFormatter.maskText(memberInfo!.memberPhoneNumber!);
                _isPhoneInitialized = true;
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(defaultPaddingM),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '회장님의 정보를 알려주세요',
                        style: context.textTheme.headlineSmall,
                      ),
                      const Gap(defaultGapXL * 2),
                      Text(
                        '기본 정보',
                        style: context.textTheme.labelLarge,
                      ),
                      const Gap(defaultGapM),
                      CustomTextFormField(
                        labelText: '이름',
                        initialValue: memberInfo?.memberName,
                        enabled: false,
                        readOnly: true,
                      ),
                      const Gap(defaultGapM),
                      CustomDropdownFormField(
                        labelText: '성별',
                        items: const [
                          {'value': 'MAN', 'displayText': '남성'},
                          {'value': 'WOMAN', 'displayText': '여성'},
                        ],
                        onChanged: (value) => memberInfo?.memberGender = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '성별을 선택해 주세요';
                          }
                          return null;
                        },
                      ),
                      const Gap(defaultGapM),
                      CustomTextFormField(
                        labelText: '휴대폰 번호',
                        hintText: '휴대폰 번호를 - 없이 입력해 주세요',
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        inputFormatters: [maskFormatter],
                        onSaved: (value) => memberInfo?.memberPhoneNumber = maskFormatter.getUnmaskedText(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '휴대폰 번호를 입력해 주세요';
                          }
                          return null;
                        },
                      ),
                      const Gap(defaultGapM),
                      CustomTextFormField(
                        labelText: '이메일 주소',
                        initialValue: memberInfo?.memberEmail,
                        enabled: false,
                        readOnly: true,
                      ),
                      const Gap(defaultGapXL),
                      Text(
                        '학교 정보',
                        style: context.textTheme.labelLarge,
                      ),
                      const Gap(defaultGapM),
                      CustomTextFormField(
                        labelText: '학교',
                        initialValue: memberInfo?.memberSchool,
                        enabled: false,
                        readOnly: true,
                      ),
                      const Gap(defaultGapM),
                      CustomTextFormField(
                        labelText: '학과',
                        onSaved: (value) => memberInfo?.memberMajor = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '학과를 입력해 주세요';
                          }
                          return null;
                        },
                      ),
                      const Gap(defaultGapM),
                      CustomTextFormField(
                        labelText: '학번',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textInputAction: TextInputAction.done,
                        onSaved: (value) => memberInfo?.memberStudentNumber = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '학번을 입력해 주세요';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () async {
            if (formKey.currentState?.validate() == true) {
              formKey.currentState?.save();

              await memberNotifier.saveMemberInfo(ref.read(memberProvider)!);

              if (context.mounted) {
                _pushCheckPage(context);
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

  void _pushCheckPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const MemberRegisterInfoCheckPage(),
      ),
    );
  }
}
