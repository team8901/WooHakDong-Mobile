import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/member/member_model.dart';

final memberProvider = StateNotifierProvider<MemberNotifier, Member>((ref) {
  return MemberNotifier();
});

class MemberNotifier extends StateNotifier<Member> {
  MemberNotifier()
      : super(Member(
          email: '',
          name: '',
          gender: '',
          department: '',
          studentId: '',
          phoneNumber: '',
        ));

  void updateMember(Member member) {
    state = member;
  }
}
