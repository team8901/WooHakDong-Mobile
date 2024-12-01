import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/member/member.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/member/member_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interface/custom_dropdown_form_field.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'components/member_controller.dart';

class MemberEditPage extends ConsumerStatefulWidget {
  final Member memberInfo;

  const MemberEditPage({
    super.key,
    required this.memberInfo,
  });

  @override
  ConsumerState createState() => _MemberEditPageState();
}

class _MemberEditPageState extends ConsumerState<MemberEditPage> {
  final _formKey = GlobalKey<FormState>();
  late final MemberController _memberController;

  @override
  void initState() {
    super.initState();
    _memberController = MemberController();
  }

  @override
  void dispose() {
    _memberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _memberController.updateFromMemberInfo(widget.memberInfo);
    final memberNotifier = ref.read(memberProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('내 정보 수정'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '기본 정보',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                GestureDetector(
                  onTap: () => GeneralFunctions.toastMessage('이름은 수정할 수 없어요'),
                  child: CustomTextFormField(
                    labelText: '이름',
                    initialValue: widget.memberInfo.memberName,
                    enabled: false,
                    readOnly: true,
                  ),
                ),
                const Gap(defaultGapM),
                CustomDropdownFormField(
                  initialValue: widget.memberInfo.memberGender,
                  labelText: '성별',
                  items: const [
                    {'value': 'MAN', 'displayText': '남성'},
                    {'value': 'WOMAN', 'displayText': '여성'},
                  ],
                  onChanged: (value) => _memberController.gender.text = value!,
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
                  controller: _memberController.phoneNumber,
                  inputFormatters: [LengthLimitingTextInputFormatter(11)],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '휴대폰 번호를 입력해 주세요';
                    }
                    return null;
                  },
                ),
                const Gap(defaultGapM),
                GestureDetector(
                  onTap: () => GeneralFunctions.toastMessage('이메일 주소는 수정할 수 없어요'),
                  child: CustomTextFormField(
                    labelText: '이메일 주소',
                    initialValue: widget.memberInfo.memberEmail,
                    enabled: false,
                    readOnly: true,
                  ),
                ),
                const Gap(defaultGapXL),
                Text(
                  '학교 정보',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                GestureDetector(
                  onTap: () => GeneralFunctions.toastMessage('학교는 수정할 수 없어요'),
                  child: CustomTextFormField(
                    labelText: '학교',
                    initialValue: widget.memberInfo.memberSchool,
                    enabled: false,
                    readOnly: true,
                  ),
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  labelText: '학과',
                  controller: _memberController.major,
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  textInputAction: TextInputAction.done,
                  controller: _memberController.studentNumber,
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
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () async {
            if (!_formKey.currentState!.validate()) return;

            try {
              await memberNotifier.updateMember(
                Member(
                  memberSchool: widget.memberInfo.memberSchool,
                  memberEmail: widget.memberInfo.memberEmail,
                  memberName: widget.memberInfo.memberName,
                  memberPhoneNumber: _memberController.phoneNumber.text,
                  memberMajor: _memberController.major.text,
                  memberGender: _memberController.gender.text,
                  memberStudentNumber: _memberController.studentNumber.text,
                ),
              );

              if (context.mounted) {
                GeneralFunctions.toastMessage('내 정보가 수정되었어요');
                Navigator.pop(context);
              }
            } catch (e) {
              await GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
            }
          },
          buttonText: '저장',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
