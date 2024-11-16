class ItemHistory {
  int? itemHistoryId;
  int? clubMemberId;
  String? memberName;
  DateTime? itemRentalDate;
  DateTime? itemDueDate;
  DateTime? itemReturnDate;
  String? itemReturnImage;

  ItemHistory({
    this.itemHistoryId,
    this.clubMemberId,
    this.memberName,
    this.itemRentalDate,
    this.itemDueDate,
    this.itemReturnDate,
    this.itemReturnImage,
  });

  factory ItemHistory.fromJson(Map<String, dynamic> json) {
    return ItemHistory(
      itemHistoryId: json['itemHistoryId'],
      clubMemberId: json['clubMemberId'],
      memberName: json['memberName'],
      itemRentalDate: json['itemRentalDate'] != null ? DateTime.parse(json['itemRentalDate']) : null,
      itemDueDate: json['itemDueDate'] != null ? DateTime.parse(json['itemDueDate']) : null,
      itemReturnDate: json['itemReturnDate'] != null ? DateTime.parse(json['itemReturnDate']) : null,
      itemReturnImage: json['itemReturnImage'],
    );
  }
}
