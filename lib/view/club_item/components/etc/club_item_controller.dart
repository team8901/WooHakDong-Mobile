import 'package:flutter/cupertino.dart';

import '../../../../model/item/item.dart';

class ClubItemController {
  final TextEditingController name;
  final TextEditingController description;
  final TextEditingController location;
  final TextEditingController category;
  final TextEditingController rentalMaxDay;

  ClubItemController()
      : name = TextEditingController(),
        description = TextEditingController(),
        location = TextEditingController(),
        category = TextEditingController(),
        rentalMaxDay = TextEditingController();

  void updateFromClubItemInfo(Item itemInfo) {
    name.text = itemInfo.itemName!;
    description.text = itemInfo.itemDescription!;
    location.text = itemInfo.itemLocation!;
    category.text = itemInfo.itemCategory!;
    rentalMaxDay.text = itemInfo.itemRentalMaxDay!.toString();
  }

  void dispose() {
    name.dispose();
    description.dispose();
    location.dispose();
    category.dispose();
    rentalMaxDay.dispose();
  }
}