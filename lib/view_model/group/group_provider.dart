import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/group/group.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';
import 'package:woohakdong/view_model/group/group_id_provider.dart';
import 'package:woohakdong/view_model/group/group_order_provider.dart';

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

  Future<void> getServiceFeeGroupInfo() async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      final serviceFeeGroupInfo = await groupRepository.getServiceFeeGroupInfo(currentClubId!);

      ref.read(groupIdProvider.notifier).state = serviceFeeGroupInfo.groupId!;
      state = serviceFeeGroupInfo;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getOrderIdServiceFeeGroup(String merchantUid) async {
    try {
      final groupId = ref.watch(groupIdProvider);

      final orderId = await groupRepository.getGroupOrderId(groupId, merchantUid);

      ref.read(groupOrderIdProvider.notifier).state = orderId;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> confirmPaymentServiceFeeGroup(String merchantUid, String impUid) async {
    try {
      final groupId = ref.watch(groupIdProvider);
      final orderId = ref.watch(groupOrderIdProvider);

      await groupRepository.confirmGroupOrder(groupId, merchantUid, impUid, orderId);
    } catch (e) {
      rethrow;
    }
  }
}
