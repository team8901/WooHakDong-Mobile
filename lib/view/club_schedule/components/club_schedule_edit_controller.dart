import 'package:flutter/cupertino.dart';

import '../../../model/schedule/schedule.dart';

class ClubScheduleEditController {
  final TextEditingController title;
  final TextEditingController content;
  final TextEditingController color;

  ClubScheduleEditController()
      : title = TextEditingController(),
        content = TextEditingController(),
        color = TextEditingController();

  void updateFromClubScheduleInfo(Schedule scheduleInfo) {
    title.text = scheduleInfo.scheduleTitle!;
    content.text = scheduleInfo.scheduleContent!;
    color.text = scheduleInfo.scheduleColor!;
  }

  void dispose() {
    title.dispose();
    content.dispose();
    color.dispose();
  }
}
