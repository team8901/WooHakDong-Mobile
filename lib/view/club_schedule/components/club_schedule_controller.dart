import 'package:flutter/cupertino.dart';

import '../../../model/schedule/schedule.dart';

class ClubScheduleController {
  final TextEditingController title;
  final TextEditingController content;

  ClubScheduleController()
      : title = TextEditingController(),
        content = TextEditingController();

  void updateFromClubScheduleInfo(Schedule scheduleInfo) {
    title.text = scheduleInfo.scheduleTitle!;
    content.text = scheduleInfo.scheduleContent!;
  }

  void dispose() {
    title.dispose();
    content.dispose();
  }
}
