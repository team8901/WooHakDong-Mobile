class ItemHistory {
  int? itemHistoryId;
  int? memberId;
  String? memberName;
  DateTime? itemRentalDate;
  DateTime? itemDueDate;
  DateTime? itemReturnDate;
  String? itemReturnImage;

  ItemHistory({
    this.itemHistoryId,
    this.memberId,
    this.memberName,
    this.itemRentalDate,
    this.itemDueDate,
    this.itemReturnDate,
    this.itemReturnImage,
  });

  factory ItemHistory.fromJson(Map<String, dynamic> json) {
    return ItemHistory(
      itemHistoryId: json['itemHistoryId'],
      memberId: json['memberId'],
      memberName: json['memberName'],
      itemRentalDate: json['itemRentalDate'],
      itemDueDate: json['itemDueDate'],
      itemReturnDate: json['itemReturnDate'],
      itemReturnImage: json['itemReturnImage'],
    );
  }
}
