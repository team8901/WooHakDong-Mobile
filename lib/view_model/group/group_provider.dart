import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/group/group.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';

import '../../repository/group/group_repository.dart';

final groupProvider = StateNotifierProvider<GroupNotifier, Group>((ref) {
  return GroupNotifier(ref);
});

class GroupNotifier extends StateNotifier<Group> {
  final Ref ref;
  final GroupRepository groupRepository = GroupRepository();

  GroupNotifier(this.ref) : super(Group());

  Future<void> getClubRegisterPageInfo() async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      final groupInfo = await groupRepository.getClubRegisterPageInfo(currentClubId!);

      state = groupInfo;
    } catch (e) {
      rethrow;
    }
  }
}
