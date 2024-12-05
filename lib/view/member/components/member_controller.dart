import 'package:flutter/material.dart';

import '../../../model/member/member.dart';

class MemberController {
  final TextEditingController phoneNumber;
  final TextEditingController major;
  final TextEditingController gender;
  final TextEditingController studentNumber;

  MemberController()
      : phoneNumber = TextEditingController(),
        major = TextEditingController(),
        gender = TextEditingController(),
        studentNumber = TextEditingController();

  void updateFromMemberInfo(Member memberInfo) {
    phoneNumber.text = memberInfo.memberPhoneNumber!;
    major.text = memberInfo.memberMajor!;
    gender.text = memberInfo.memberGender!;
    studentNumber.text = memberInfo.memberStudentNumber!;
  }

  void dispose() {
    phoneNumber.dispose();
    major.dispose();
    gender.dispose();
    studentNumber.dispose();
  }
}
