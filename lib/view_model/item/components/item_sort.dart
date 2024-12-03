enum ItemSortOption {
  oldest,
  newest,
  nameAsc,
  nameDesc,
}

extension ItemSortOptionExtension on ItemSortOption {
  String get displayText {
    switch (this) {
      case ItemSortOption.oldest:
        return '등록된 순';
      case ItemSortOption.newest:
        return '최신 순';
      case ItemSortOption.nameAsc:
        return '이름 오름차순';
      case ItemSortOption.nameDesc:
        return '이름 내림차순';
    }
  }
}
