class ItemFilter {
  final String? category;
  final bool? using;
  final bool? available;
  final bool? overdue;

  const ItemFilter({
    this.category,
    this.using,
    this.available,
    this.overdue,
  });

  ItemFilter copyWith({
    String? category,
    bool? using,
    bool? available,
    bool? overdue,
  }) {
    return ItemFilter(
      category: category ?? this.category,
      using: using ?? this.using,
      available: available ?? this.available,
      overdue: overdue ?? this.overdue,
    );
  }
}
