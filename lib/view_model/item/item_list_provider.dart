import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item.dart';

import '../../repository/item/item_repository.dart';
import '../club/club_id_provider.dart';

final itemListProvider = StateNotifierProvider.family<ItemListNotifier, AsyncValue<List<Item>>, String?>((ref, filterCategory) {
  return ItemListNotifier(ref, filterCategory);
});

class ItemListNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  final Ref ref;
  final String? filterCategory;
  final ItemRepository itemRepository = ItemRepository();

  ItemListNotifier(this.ref, this.filterCategory) : super(const AsyncValue.loading()) {
    getItemList(filterCategory);
  }

  Future<void> getItemList(String? category) async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      state = const AsyncValue.loading();

      final itemList = await itemRepository.getItemList(
        currentClubId!,
        null,
        category,
      );

      state = AsyncValue.data(itemList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
