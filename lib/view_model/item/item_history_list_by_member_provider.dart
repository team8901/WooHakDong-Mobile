import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/repository/item/item_history_repository.dart';

import '../club/club_id_provider.dart';

final itemHistoryListByMemberProvider =
    StateNotifierProvider.family<ItemHistoryListByMemberNotifier, AsyncValue<List<ItemHistory>>, int?>(
        (ref, clubMemberId) {
  return ItemHistoryListByMemberNotifier(ref, clubMemberId);
});

class ItemHistoryListByMemberNotifier extends StateNotifier<AsyncValue<List<ItemHistory>>> {
  final Ref ref;
  final int? clubMemberId;
  final ItemHistoryRepository itemHistoryRepository = ItemHistoryRepository();

  ItemHistoryListByMemberNotifier(this.ref, this.clubMemberId) : super(const AsyncValue.loading());

  Future<void> getItemHistoryListByMember(int? clubMemberId) async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      state = const AsyncValue.loading();

      final itemHistoryList = await itemHistoryRepository.getItemHistoryListByMember(
        currentClubId!,
        clubMemberId!,
      );

      state = AsyncValue.data(itemHistoryList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
