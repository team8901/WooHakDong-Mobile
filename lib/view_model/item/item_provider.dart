import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/repository/item/item_history_repository.dart';
import 'package:woohakdong/repository/item/item_repository.dart';
import 'package:woohakdong/view_model/item/item_list_provider.dart';

import '../../model/item/item.dart';
import '../club/club_id_provider.dart';
import '../util/s3_image_provider.dart';
import 'components/item_state.dart';
import 'components/item_state_provider.dart';

final itemProvider = StateNotifierProvider<ItemNotifier, Item>((ref) {
  return ItemNotifier(ref);
});

class ItemNotifier extends StateNotifier<Item> {
  final Ref ref;
  final ItemRepository itemRepository = ItemRepository();
  final ItemHistoryRepository itemHistoryRepository = ItemHistoryRepository();

  ItemNotifier(this.ref) : super(Item());

  Future<void> getItemInfo(int itemId) async {
    try {
      final currentClubId = ref.read(clubIdProvider);

      final itemInfo = await itemRepository.getItemInfo(currentClubId!, itemId);

      state = itemInfo;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addItem(
    String itemName,
    String itemPhoto,
    String itemDescription,
    String itemLocation,
    String itemCategory,
    int itemRentalMaxDay,
  ) async {
    try {
      ref.read(itemStateProvider.notifier).state = ItemState.adding;

      final currentClubId = ref.read(clubIdProvider);

      await ref.read(s3ImageProvider.notifier).uploadImagesToS3();

      await itemRepository.addItem(
        currentClubId!,
        Item(
          itemName: itemName,
          itemPhoto: itemPhoto,
          itemDescription: itemDescription,
          itemLocation: itemLocation,
          itemCategory: itemCategory,
          itemRentalMaxDay: itemRentalMaxDay,
        ),
      );

      ref.refresh(itemListProvider(null));
      ref.read(itemStateProvider.notifier).state = ItemState.added;
    } catch (e) {
      ref.read(itemStateProvider.notifier).state = ItemState.initial;
      rethrow;
    }
  }

  Future<void> updateItem(
    int itemId,
    String itemName,
    String itemPhoto,
    String itemDescription,
    String itemLocation,
    String itemCategory,
    int itemRentalMaxDay,
  ) async {
    try {
      ref.read(itemStateProvider.notifier).state = ItemState.adding;

      final currentClubId = ref.read(clubIdProvider);

      final updatedItemId = await itemRepository.updateItem(
        currentClubId!,
        itemId,
        state.copyWith(
          itemName: itemName,
          itemPhoto: itemPhoto,
          itemDescription: itemDescription,
          itemLocation: itemLocation,
          itemCategory: itemCategory,
          itemRentalMaxDay: itemRentalMaxDay,
        ),
      );

      ref.refresh(itemListProvider(null));
      await getItemInfo(updatedItemId);
      ref.read(itemStateProvider.notifier).state = ItemState.added;
    } catch (e) {
      ref.read(itemStateProvider.notifier).state = ItemState.initial;
      rethrow;
    }
  }

  Future<void> deleteItem(int itemId) async {
    try {
      final currentClubId = ref.watch(clubIdProvider);

      await itemRepository.deleteItem(
        currentClubId!,
        itemId,
      );

      ref.refresh(itemListProvider(null));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleItemRentAvailable(int itemId, bool itemAvailable) async {
    try {
      final currentClubId = ref.watch(clubIdProvider);

      await itemRepository.toggleItemRentAvailable(
        currentClubId!,
        itemId,
        itemAvailable,
      );

      ref.refresh(itemListProvider(null));
      await getItemInfo(itemId);
    } catch (e) {
      rethrow;
    }
  }
}
