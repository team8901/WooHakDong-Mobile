import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/repository/item/item_history_repository.dart';
import 'package:woohakdong/repository/item/item_repository.dart';

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

  Future<List<Item>> getItemList(String? keyword, String? category) async {
    final currentClubId = ref.watch(clubIdProvider);

    final List<Item> itemList = await itemRepository.getItemList(
      currentClubId!,
      keyword,
      category,
    );

    return itemList;
  }

  Future<Item> getItemById(int itemId) async {
    final List<Item> itemList = await getItemList(null, null);

    final item = itemList.firstWhere((item) => item.itemId == itemId);

    return item;
  }

  Future<List<ItemHistory>> getItemHistoryList(int itemId) async {
    final currentClubId = ref.watch(clubIdProvider);

    final List<ItemHistory> itemHistoryList = await itemHistoryRepository.getItemHistoryList(
      currentClubId!,
      itemId,
    );

    return itemHistoryList;
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
      ref.read(itemStateProvider.notifier).state = ItemState.registering;

      final currentClubId = ref.watch(clubIdProvider);

      await ref.read(s3ImageProvider.notifier).uploadImagesToS3();

      await itemRepository.addItem(
        currentClubId!,
        state.copyWith(
          itemName: itemName,
          itemPhoto: itemPhoto,
          itemDescription: itemDescription,
          itemLocation: itemLocation,
          itemCategory: itemCategory,
          itemRentalMaxDay: itemRentalMaxDay,
        ),
      );

      await ref.refresh(itemProvider.notifier).getItemList(null, null);
      ref.read(itemStateProvider.notifier).state = ItemState.registered;
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
      ref.read(itemStateProvider.notifier).state = ItemState.registering;

      final currentClubId = ref.watch(clubIdProvider);

      await itemRepository.updateItem(
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

      await ref.refresh(itemProvider.notifier).getItemList(null, null);
      ref.read(itemStateProvider.notifier).state = ItemState.registered;
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

      await ref.refresh(itemProvider.notifier).getItemList(null, null);
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

      await ref.refresh(itemProvider.notifier).getItemList(null, null);
    } catch (e) {
      rethrow;
    }
  }
}
