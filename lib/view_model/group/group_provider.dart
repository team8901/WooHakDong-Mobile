import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/group/group.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';

import '../../repository/group/group_repository.dart';
import '../club/club_provider.dart';

final groupProvider = StateNotifierProvider<GroupNotifier, Group?>((ref) {
  return GroupNotifier(ref);
});

class GroupNotifier extends StateNotifier<Group?> {
  final Ref ref;

  GroupNotifier(this.ref) : super(null);

  Future<Group> getClubRegisterPageInfo() async {
    final currentClubId = ref.watch(clubIdProvider);

    final groupInfo = await GroupRepository().getClubRegisterPageInfo(currentClubId!);

    return groupInfo;
  }
}
