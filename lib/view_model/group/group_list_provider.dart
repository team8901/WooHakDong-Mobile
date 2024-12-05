import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/repository/group/group_repository.dart';

import '../../model/group/group.dart';
import '../club/club_id_provider.dart';

final groupListProvider = StateNotifierProvider<GroupListNotifier, AsyncValue<List<Group>>>((ref) {
  return GroupListNotifier(ref);
});

class GroupListNotifier extends StateNotifier<AsyncValue<List<Group>>> {
  final Ref ref;
  final GroupRepository groupRepository = GroupRepository();

  GroupListNotifier(this.ref) : super(const AsyncValue.loading()) {
    getGroupList();
  }

  Future<void> getGroupList() async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      state = const AsyncValue.loading();

      final groupList = await groupRepository.getGroupList(currentClubId!);

      state = AsyncValue.data(groupList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
