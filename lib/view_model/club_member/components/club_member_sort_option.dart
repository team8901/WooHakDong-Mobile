enum ClubMemberSortOption {
  oldest,
  newest,
  nameAsc,
  nameDesc,
}

extension ClubMemberSortOptionExtension on ClubMemberSortOption {
  String get displayText {
    switch (this) {
      case ClubMemberSortOption.oldest:
        return '등록순';
      case ClubMemberSortOption.newest:
        return '최신순';
      case ClubMemberSortOption.nameAsc:
        return '이름 오름차순';
      case ClubMemberSortOption.nameDesc:
        return '이름 내림차순';
    }
  }
}
