import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/member/member_model.dart';
import '../../repository/member/member_info.dart';

final memberProvider = StateNotifierProvider<MemberNotifier, AsyncValue<Member?>>((ref) {
  return MemberNotifier();
});

class MemberNotifier extends StateNotifier<AsyncValue<Member?>> {
  MemberNotifier() : super(const AsyncLoading()) {
    _getMemberInfo();
  }

  final MemberInfo _memberInfo = MemberInfo();

  Future<void> _getMemberInfo() async {
    try {
      final member = await _memberInfo.getMemberInfo();
      state = AsyncData(member);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  Future<void> registerMemberInfo(Member member) async {
    try {
      await _memberInfo.registerMemberInfo(member);
    } catch (e) {
      throw Exception('회원 정보 등록 실패');
    }
  }

  Future<void> updateMemberInfo(Member member) async {
    try {
      await _memberInfo.updateMemberInfo(member);

      _getMemberInfo();
    } catch (e) {
      throw Exception('회원 정보 수정 실패');
    }
  }

  void saveMemberInfo(Member member) {
    state = AsyncData(member);
  }
}
