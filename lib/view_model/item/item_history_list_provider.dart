import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/repository/item/item_history_repository.dart';

import '../club/club_id_provider.dart';

final itemHistoryListProvider =
    StateNotifierProvider.family<ItemHistoryListNotifier, AsyncValue<List<ItemHistory>>, int?>((ref, itemId) {
  return ItemHistoryListNotifier(ref, itemId);
});

class ItemHistoryListNotifier extends StateNotifier<AsyncValue<List<ItemHistory>>> {
  final Ref ref;
  final int? itemId;
  final ItemHistoryRepository itemHistoryRepository = ItemHistoryRepository();

  ItemHistoryListNotifier(this.ref, this.itemId) : super(const AsyncValue.loading());

  Future<void> getItemHistoryList(int? itemId) async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      state = const AsyncValue.loading();

      final itemHistoryList = await itemHistoryRepository.getItemHistoryList(
        currentClubId!,
        itemId!,
      );

      state = AsyncValue.data(itemHistoryList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
