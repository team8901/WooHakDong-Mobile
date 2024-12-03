import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item.dart';
import 'package:woohakdong/model/item/item_filter.dart';

import '../../repository/item/item_repository.dart';
import '../club/club_id_provider.dart';
import 'components/item_count_provider.dart';
import 'components/item_sort.dart';

final itemListProvider =
    StateNotifierProvider.family<ItemListNotifier, AsyncValue<List<Item>>, ItemFilter>((ref, filter) {
  return ItemListNotifier(ref, filter);
});

class ItemListNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  final Ref ref;
  final ItemFilter filter;
  final ItemRepository itemRepository = ItemRepository();

  ItemListNotifier(this.ref, this.filter) : super(const AsyncValue.loading()) {
    getItemList(filter);
  }

  Future<void> getItemList(ItemFilter filter) async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      state = const AsyncValue.loading();

      final itemList = await itemRepository.getItemList(
        currentClubId!,
        null,
        filter.category,
        filter.using,
        filter.available,
        filter.overdue,
      );

      switch (filter.itemSortOption ?? ItemSortOption.oldest) {
        case ItemSortOption.oldest:
          itemList.sort((a, b) => a.itemId!.compareTo(b.itemId!));
          break;
        case ItemSortOption.newest:
          itemList.sort((a, b) => b.itemId!.compareTo(a.itemId!));
          break;
        case ItemSortOption.nameAsc:
          itemList.sort((a, b) => a.itemName!.compareTo(b.itemName!));
          break;
        case ItemSortOption.nameDesc:
          itemList.sort((a, b) => b.itemName!.compareTo(a.itemName!));
          break;
      }

      state = AsyncValue.data(itemList);

      ref.read(itemCountProvider.notifier).state = itemList.length;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
