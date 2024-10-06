import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/member/member_model.dart';
import '../../../model/user/user_model.dart';
import '../../themes/custom_widget/custom_dropdown_form_field.dart';
import '../../themes/custom_widget/custom_text_form_field.dart';
import '../../themes/spacing.dart';

class MemberInfoInputForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final UserModel userModel;
  final Member member;

  const MemberInfoInputForm({
    super.key,
    required this.formKey,
    required this.userModel,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    member.memberEmail = userModel.userEmail!;
    member.memberName = userModel.userName!;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '회장님의 정보를 알려주세요',
            style: context.textTheme.titleLarge,
          ),
          const Gap(defaultGapXL * 2),
          CustomTextFormField(
            labelText: '이메일 주소',
            initialValue: userModel.userEmail,
            readOnly: true,
          ),
          const Gap(defaultGapXL),
          CustomTextFormField(
            labelText: '이름',
            initialValue: userModel.userName,
            readOnly: true,
          ),
          const Gap(defaultGapXL),
          CustomDropdownFormField(
            labelText: '성별',
            items: const ['남성', '여성'],
            onChanged: (value) => member.memberGender = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '성별을 선택해 주세요';
              }
              return null;
            },
          ),
          const Gap(defaultGapXL),
          CustomTextFormField(
            labelText: '학과',
            onSaved: (value) => member.memberMajor = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '학과를 입력해 주세요';
              }
              return null;
            },
          ),
          const Gap(defaultGapXL),
          CustomTextFormField(
            labelText: '학번',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onSaved: (value) => member.memberStudentNumber = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '학번을 입력해 주세요';
              }
              return null;
            },
          ),
          const Gap(defaultGapXL),
          CustomTextFormField(
            labelText: '휴대폰 번호',
            hintText: '휴대폰 번호를 - 없이 입력해 주세요',
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.done,
            onSaved: (value) => member.memberPhoneNumber = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '휴대폰 번호를 입력해 주세요';
              }
              return null;
            },
          ),
          const Gap(defaultGapXL),
        ],
      ),
    );
  }
}
