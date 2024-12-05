import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/group/group_member.dart';
import 'package:woohakdong/repository/group/group_member.dart';

final groupMemberListProvider =
    StateNotifierProvider.family<GroupMemberListNotifier, AsyncValue<List<GroupMember>>, int?>((ref, groupId) {
  return GroupMemberListNotifier(ref, groupId);
});

class GroupMemberListNotifier extends StateNotifier<AsyncValue<List<GroupMember>>> {
  final Ref ref;
  final int? groupId;
  final GroupMemberRepository groupMemberRepository = GroupMemberRepository();

  GroupMemberListNotifier(this.ref, this.groupId) : super(const AsyncValue.loading());

  Future<void> getGroupMemberList(int groupId) async {
    try {
      state = const AsyncValue.loading();

      final groupMemberList = await groupMemberRepository.getClubMemberList(groupId);

      state = AsyncValue.data(groupMemberList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
