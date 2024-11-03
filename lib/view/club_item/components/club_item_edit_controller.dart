import 'package:flutter/cupertino.dart';

import '../../../model/item/item.dart';

class ClubItemEditController {
  final TextEditingController name;
  final TextEditingController photo;
  final TextEditingController description;
  final TextEditingController location;
  final TextEditingController category;
  final TextEditingController rentalMaxDay;

  ClubItemEditController()
      : name = TextEditingController(),
        photo = TextEditingController(),
        description = TextEditingController(),
        location = TextEditingController(),
        category = TextEditingController(),
        rentalMaxDay = TextEditingController();

  void updateFromClubItemInfo(Item itemInfo) {
    name.text = itemInfo.itemName!;
    photo.text = itemInfo.itemPhoto!;
    description.text = itemInfo.itemDescription!;
    location.text = itemInfo.itemLocation!;
    category.text = itemInfo.itemCategory!;
    rentalMaxDay.text = itemInfo.itemRentalMaxDay!.toString();
  }

  void dispose() {
    name.dispose();
    photo.dispose();
    description.dispose();
    location.dispose();
    category.dispose();
    rentalMaxDay.dispose();
  }
}