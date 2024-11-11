import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/item/item.dart';
import '../../repository/item/item_repository.dart';
import '../club/club_id_provider.dart';

final itemSearchProvider = FutureProvider.autoDispose.family<List<Item>, String>((ref, keyword) async {
  if (keyword.isEmpty) return [];

  final currentClubId = ref.read(clubIdProvider);
  final itemRepository = ItemRepository();

  final itemList = await itemRepository.getItemList(
    currentClubId!,
    keyword,
    null,
  );

  return itemList;
});
