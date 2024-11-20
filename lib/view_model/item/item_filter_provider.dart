import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/item/item_filter.dart';

final itemFilterProvider = StateProvider<ItemFilter>((ref) {
  return const ItemFilter(
    category: null,
    using: null,
    available: null,
    overdue: null,
  );
});
