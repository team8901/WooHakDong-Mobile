import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item_history.dart';

import '../../repository/item/item_history_repository.dart';
import '../club/club_id_provider.dart';

final itemEntireHistoryListProvider =
    StateNotifierProvider<ItemEntireHistoryListNotifier, AsyncValue<List<ItemHistory>>>((ref) {
  return ItemEntireHistoryListNotifier(ref);
});

class ItemEntireHistoryListNotifier extends StateNotifier<AsyncValue<List<ItemHistory>>> {
  final Ref ref;
  final ItemHistoryRepository itemHistoryRepository = ItemHistoryRepository();

  ItemEntireHistoryListNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> getEntireItemHistoryList() async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      state = const AsyncValue.loading();

      final itemHistoryList = await itemHistoryRepository.getEntireItemHistoryList(currentClubId!);

      state = AsyncValue.data(itemHistoryList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
