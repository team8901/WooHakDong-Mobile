class Item {
  int? itemId;
  String? itemName;
  String? itemPhoto;
  String? itemDescription;
  String? itemLocation;
  String? itemCategory;
  int? itemRentalMaxDay;
  bool? itemAvailable;
  bool? itemUsing;
  DateTime? itemRentalDate;

  Item({
    this.itemId,
    this.itemName,
    this.itemPhoto,
    this.itemDescription,
    this.itemLocation,
    this.itemCategory,
    this.itemRentalMaxDay,
    this.itemAvailable,
    this.itemUsing,
    this.itemRentalDate,
  });

  Item copyWith({
    int? itemId,
    String? itemName,
    String? itemPhoto,
    String? itemDescription,
    String? itemLocation,
    String? itemCategory,
    int? itemRentalMaxDay,
  }) {
    return Item(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemPhoto: itemPhoto ?? this.itemPhoto,
      itemDescription: itemDescription ?? this.itemDescription,
      itemLocation: itemLocation ?? this.itemLocation,
      itemCategory: itemCategory ?? this.itemCategory,
      itemRentalMaxDay: itemRentalMaxDay ?? this.itemRentalMaxDay,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json['itemId'],
      itemName: json['itemName'],
      itemPhoto: json['itemPhoto'],
      itemDescription: json['itemDescription'],
      itemLocation: json['itemLocation'],
      itemCategory: json['itemCategory'],
      itemRentalMaxDay: json['itemRentalMaxDay'],
      itemAvailable: json['itemAvailable'],
      itemUsing: json['itemUsing'],
      itemRentalDate: json['itemRentalDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'itemPhoto': itemPhoto,
      'itemDescription': itemDescription,
      'itemLocation': itemLocation,
      'itemCategory': itemCategory,
      'itemRentalMaxDay': itemRentalMaxDay,
    };
  }
}
