import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item_history.dart';
import 'package:woohakdong/repository/item/item_history_repository.dart';
import 'package:woohakdong/repository/item/item_repository.dart';

import '../../model/item/item.dart';
import '../club/current_club_provider.dart';

final itemProvider = StateNotifierProvider<ItemNotifier, Item>((ref) {
  return ItemNotifier(ref);
});

class ItemNotifier extends StateNotifier<Item> {
  final Ref ref;
  final ItemRepository itemRepository = ItemRepository();
  final ItemHistoryRepository itemHistoryRepository = ItemHistoryRepository();

  ItemNotifier(this.ref) : super(Item());

  Future<List<Item>> getItemList() async {
    final currentClubInfo = ref.watch(currentClubProvider);

    if (currentClubInfo?.clubId == null) {
      throw Exception();
    }

    final List<Item> itemList = await itemRepository.getItemList(
      currentClubInfo!.clubId!,
    );

    return itemList;
  }

  Future<List<ItemHistory>> getItemHistoryList(int itemId) async {
    final currentClubInfo = ref.watch(currentClubProvider);

    if (currentClubInfo?.clubId == null) {
      throw Exception();
    }

    final List<ItemHistory> itemHistoryList = await itemHistoryRepository.getItemHistoryList(
      currentClubInfo!.clubId!,
      itemId,
    );

    return itemHistoryList;
  }

  Future<Map<String, dynamic>> addItem(
    String itemName,
    String itemPhoto,
    String itemDescription,
    String itemLocation,
    String itemCategory,
    int itemRentalMaxDay,
  ) async {
    final currentClubInfo = ref.watch(currentClubProvider);

    if (currentClubInfo?.clubId == null) {
      throw Exception();
    }

    final response = await itemRepository.addItem(
      currentClubInfo!.clubId!,
      state.copyWith(
        itemName: itemName,
        itemPhoto: itemPhoto,
        itemDescription: itemDescription,
        itemLocation: itemLocation,
        itemCategory: itemCategory,
        itemRentalMaxDay: itemRentalMaxDay,
      ),
    );

    final registeredItemId = response['itemId'];

    return registeredItemId;
  }
}
