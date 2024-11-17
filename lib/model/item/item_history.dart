class ItemHistory {
  int? itemHistoryId;
  int? clubMemberId;
  String? itemName;
  String? memberName;
  DateTime? itemRentalDate;
  DateTime? itemDueDate;
  DateTime? itemReturnDate;
  String? itemReturnImage;
  bool? itemOverdue;

  ItemHistory({
    this.itemHistoryId,
    this.clubMemberId,
    this.itemName,
    this.memberName,
    this.itemRentalDate,
    this.itemDueDate,
    this.itemReturnDate,
    this.itemReturnImage,
    this.itemOverdue,
  });

  factory ItemHistory.fromJson(Map<String, dynamic> json) {
    return ItemHistory(
      itemHistoryId: json['itemHistoryId'],
      clubMemberId: json['clubMemberId'],
      itemName: json['itemName'],
      memberName: json['memberName'],
      itemRentalDate: json['itemRentalDate'] != null ? DateTime.parse(json['itemRentalDate']) : null,
      itemDueDate: json['itemDueDate'] != null ? DateTime.parse(json['itemDueDate']) : null,
      itemReturnDate: json['itemReturnDate'] != null ? DateTime.parse(json['itemReturnDate']) : null,
      itemReturnImage: json['itemReturnImage'],
      itemOverdue: json['itemOverdue'],
    );
  }
}
