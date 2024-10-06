import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/member/member_model.dart';
import '../../repository/member/register.dart';

final memberProvider = StateNotifierProvider<MemberNotifier, Member>((ref) {
  return MemberNotifier();
});

class MemberNotifier extends StateNotifier<Member> {
  MemberNotifier()
      : super(Member(
          memberName: '',
          memberPhoneNumber: '',
          memberEmail: '',
          memberMajor: '',
          memberStudentNumber: '',
          memberGender: '',
        ));

  void updateMember(Member member) {
    state = member;
  }

  Future<void> woohakdongRegister(Member member) async {
    await Register().woohakdongRegister(member);
  }
}
