import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/group/group.dart';
import 'package:woohakdong/repository/group/group_repository.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';
import 'package:woohakdong/view_model/group/components/group_state_provider.dart';

import 'components/group_state.dart';
import 'group_list_provider.dart';

final groupProvider = StateNotifierProvider<GroupNotifier, Group>((ref) {
  return GroupNotifier(ref);
});

class GroupNotifier extends StateNotifier<Group> {
  final Ref ref;
  final GroupRepository groupRepository = GroupRepository();

  GroupNotifier(this.ref) : super(Group());

  Future<void> getClubRegisterInfo() async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      final clubRegisterInfo = await groupRepository.getClubRegisterInfo(currentClubId!);

      state = clubRegisterInfo;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getGroupInfo(int groupId) async {
    try {
      final groupInfo = await groupRepository.getGroupInfo(groupId);

      state = groupInfo;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addGroup(
    String groupName,
    String groupDescription,
    int groupAmount,
    String groupChatLink,
    String groupChatPassword,
    int groupMemberLimit,
  ) async {
    try {
      ref.read(groupStateProvider.notifier).state = GroupState.adding;

      final currentClubId = ref.read(clubIdProvider);

      await groupRepository.addGroup(
        currentClubId!,
        Group(
          groupName: groupName,
          groupDescription: groupDescription,
          groupAmount: groupAmount,
          groupChatLink: groupChatLink,
          groupChatPassword: groupChatPassword,
          groupMemberLimit: groupMemberLimit,
        ),
      );

      ref.invalidate(groupListProvider);
      ref.read(groupStateProvider.notifier).state = GroupState.added;
    } catch (e) {
      ref.read(groupStateProvider.notifier).state = GroupState.initial;
      rethrow;
    }
  }

  Future<void> updateGroup(
    int groupId,
    String groupName,
    String groupDescription,
    String groupChatLink,
    String groupChatPassword,
    bool groupIsActivated,
    int groupMemberLimit,
  ) async {
    try {
      ref.read(groupStateProvider.notifier).state = GroupState.adding;

      final updatedGroupId = await groupRepository.updateGroup(
        groupId,
        state.copyWith(
          groupName: groupName,
          groupDescription: groupDescription,
          groupChatLink: groupChatLink,
          groupChatPassword: groupChatPassword,
          groupIsActivated: groupIsActivated,
          groupMemberLimit: groupMemberLimit,
        ),
      );

      ref.invalidate(groupListProvider);
      await getGroupInfo(updatedGroupId);
      ref.read(groupStateProvider.notifier).state = GroupState.added;
    } catch (e) {
      ref.read(groupStateProvider.notifier).state = GroupState.initial;
      rethrow;
    }
  }

  Future<void> deleteGroup(int groupId) async {
    try {
      await groupRepository.deleteGroup(groupId);

      ref.invalidate(groupListProvider);
    } catch (e) {
      rethrow;
    }
  }
}
