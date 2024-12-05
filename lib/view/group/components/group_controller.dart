import 'package:flutter/cupertino.dart';

import '../../../model/group/group.dart';

class GroupController {
  final TextEditingController name;
  final TextEditingController description;
  final TextEditingController amount;
  final TextEditingController chatLink;
  final TextEditingController chatPassword;
  final TextEditingController memberLimit;

  GroupController()
      : name = TextEditingController(),
        description = TextEditingController(),
        amount = TextEditingController(),
        chatLink = TextEditingController(),
        chatPassword = TextEditingController(),
        memberLimit = TextEditingController();

  void updateFromGroupInfo(Group groupInfo) {
    name.text = groupInfo.groupName!;
    description.text = groupInfo.groupDescription!;
    chatLink.text = groupInfo.groupChatLink!;
    chatPassword.text = groupInfo.groupChatPassword!;
    memberLimit.text = groupInfo.groupMemberLimit.toString();
  }

  void dispose() {
    name.dispose();
    description.dispose();
    amount.dispose();
    chatLink.dispose();
    chatPassword.dispose();
    memberLimit.dispose();
  }
}