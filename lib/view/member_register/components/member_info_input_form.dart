import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/member/member_model.dart';
import '../../themes/custom_widget/custom_dropdown_form_field.dart';
import '../../themes/custom_widget/custom_text_form_field.dart';
import '../../themes/spacing.dart';

class MemberInfoInputForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Member memberInfo;

  const MemberInfoInputForm({
    super.key,
    required this.formKey,
    required this.memberInfo,
  });

  @override
  State<MemberInfoInputForm> createState() => _MemberInfoInputFormState();
}

class _MemberInfoInputFormState extends State<MemberInfoInputForm> {
  late String? _memberGender;
  late String? _memberMajor;
  late String? _memberStudentNumber;
  late String? _memberPhoneNumber;

  @override
  void initState() {
    super.initState();
    _memberGender = widget.memberInfo.memberGender;
    _memberMajor = widget.memberInfo.memberMajor;
    _memberStudentNumber = widget.memberInfo.memberStudentNumber;
    _memberPhoneNumber = widget.memberInfo.memberPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '회장님의 정보를 알려주세요',
            style: context.textTheme.titleLarge,
          ),
          const Gap(defaultGapXL * 2),
          CustomTextFormField(
            labelText: '학교',
            initialValue: widget.memberInfo.memberSchool,
            readOnly: true,
          ),
          const Gap(defaultGapXL),
          CustomTextFormField(
            labelText: '이메일 주소',
            initialValue: widget.memberInfo.memberEmail,
            readOnly: true,
          ),
          const Gap(defaultGapXL),
          CustomTextFormField(
            labelText: '이름',
            initialValue: widget.memberInfo.memberName,
            readOnly: true,
          ),
          const Gap(defaultGapXL),
          CustomDropdownFormField(
            labelText: '성별',
            items: const ['남성', '여성'],
            onChanged: (value) => _memberGender = value,
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
            initialValue: _memberMajor,
            onSaved: (value) => _memberMajor = value,
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
            initialValue: _memberStudentNumber,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onSaved: (value) => _memberStudentNumber = value,
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
            initialValue: _memberPhoneNumber,
            hintText: '휴대폰 번호를 - 없이 입력해 주세요',
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.done,
            onSaved: (value) => _memberPhoneNumber = value,
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
