import '../../view_model/item/components/item_sort.dart';

class ItemFilter {
  final String? category;
  final bool? using;
  final bool? available;
  final bool? overdue;
  final ItemSortOption? itemSortOption;

  const ItemFilter({
    this.category,
    this.using,
    this.available,
    this.overdue,
    this.itemSortOption,
  });

  ItemFilter copyWith({
    String? category,
    bool? using,
    bool? available,
    bool? overdue,
    ItemSortOption? itemSortOption,
  }) {
    return ItemFilter(
      category: category ?? this.category,
      using: using ?? this.using,
      available: available ?? this.available,
      overdue: overdue ?? this.overdue,
      itemSortOption: itemSortOption ?? this.itemSortOption,
    );
  }
}
