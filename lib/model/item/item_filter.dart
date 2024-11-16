class ItemFilter {
  final String? category;
  final bool? using;
  final bool? available;

  const ItemFilter({
    this.category,
    this.using,
    this.available,
  });

  ItemFilter copyWith({
    String? category,
    bool? using,
    bool? available,
  }) {
    return ItemFilter(
      category: category ?? this.category,
      using: using ?? this.using,
      available: available ?? this.available,
    );
  }
}
