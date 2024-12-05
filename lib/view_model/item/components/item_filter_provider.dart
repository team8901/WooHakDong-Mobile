import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item_filter.dart';
import 'package:woohakdong/view_model/item/components/item_sort_option.dart';

final itemFilterProvider = StateProvider<ItemFilter>((ref) {
  return const ItemFilter(
    category: null,
    using: null,
    available: null,
    overdue: null,
    itemSortOption: ItemSortOption.oldest,
  );
});
