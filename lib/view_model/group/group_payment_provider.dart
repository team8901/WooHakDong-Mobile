import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/group/group.dart';
import '../../repository/group/group_payment_repository.dart';
import '../club/club_id_provider.dart';
import 'group_id_provider.dart';
import 'group_order_provider.dart';

final groupPaymentProvider = StateNotifierProvider<GroupPaymentNotifier, Group>((ref) {
  return GroupPaymentNotifier(ref);
});

class GroupPaymentNotifier extends StateNotifier<Group> {
  final Ref ref;
  final GroupPaymentRepository groupPaymentRepository = GroupPaymentRepository();

  GroupPaymentNotifier(this.ref) : super(Group());

  Future<void> getClubServiceFeeInfo() async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      final serviceFeeGroupInfo = await groupPaymentRepository.getClubServiceFeeInfo(currentClubId!);

      ref.read(groupIdProvider.notifier).state = serviceFeeGroupInfo.groupId!;
      state = serviceFeeGroupInfo;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getGroupPaymentOrderId(String merchantUid) async {
    try {
      final groupId = ref.watch(groupIdProvider);

      final orderId = await groupPaymentRepository.getGroupPaymentOrderId(groupId, merchantUid);

      ref.read(groupOrderIdProvider.notifier).state = orderId;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> confirmGroupPaymentOrder(String merchantUid, String impUid) async {
    try {
      final groupId = ref.watch(groupIdProvider);
      final orderId = ref.watch(groupOrderIdProvider);

      await groupPaymentRepository.confirmGroupPaymentOrder(groupId, merchantUid, impUid, orderId);
    } catch (e) {
      rethrow;
    }
  }
}
