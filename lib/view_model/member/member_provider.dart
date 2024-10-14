import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/member/member.dart';
import '../../repository/member/member_repository.dart';

final memberProvider = StateNotifierProvider<MemberNotifier, Member?>((ref) {
  final notifier = MemberNotifier();
  notifier.getMemberInfo();
  return notifier;
});

class MemberNotifier extends StateNotifier<Member?> {
  MemberNotifier() : super(null);

  Future<void> getMemberInfo() async {
    final memberRepository = await MemberRepository().getMemberInfo();

    state = memberRepository;
  }

  Future<void> saveMemberInfo(Member memberInfo) async {
    state = memberInfo;
  }

  Future<void> registerMember() async {
    await MemberRepository().registerMemberInfo(state!);
  }
}
