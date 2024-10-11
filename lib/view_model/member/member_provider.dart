import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/member/member_model.dart';
import '../../repository/member/member_info.dart';

final memberProvider = StateNotifierProvider<MemberNotifier, Member?>((ref) {
  final notifier = MemberNotifier();
  notifier.getMemberInfo();
  return notifier;
});


class MemberNotifier extends StateNotifier<Member?> {
  MemberNotifier() : super(null);

  Future<void> getMemberInfo() async {
    final memberInfo = await MemberInfo().getMemberInfo();

    state = memberInfo;
    }

  Future<void> registerMemberInfo(Member member) async {
    await MemberInfo().registerMemberInfo(member);
  }
}
