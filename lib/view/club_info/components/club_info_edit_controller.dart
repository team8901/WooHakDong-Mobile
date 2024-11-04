import 'package:flutter/material.dart';
import 'package:woohakdong/model/club/current_club.dart';

class ClubInfoEditController {
  final TextEditingController description;
  final TextEditingController room;
  final TextEditingController generation;
  final TextEditingController chatLink;
  final TextEditingController chatPassword;
  final TextEditingController dues;

  ClubInfoEditController()
      : description = TextEditingController(),
        room = TextEditingController(),
        generation = TextEditingController(),
        chatLink = TextEditingController(),
        chatPassword = TextEditingController(),
        dues = TextEditingController();

  void updateFromClubInfo(CurrentClub currentClubInfo) {
    description.text = currentClubInfo.clubDescription!;
    room.text = currentClubInfo.clubRoom ?? '';
    generation.text = currentClubInfo.clubGeneration ?? '';
    chatLink.text = currentClubInfo.clubGroupChatLink!;
    chatPassword.text = currentClubInfo.clubGroupChatPassword ?? '';
    dues.text = currentClubInfo.clubDues!.toString();
  }

  void dispose() {
    description.dispose();
    room.dispose();
    generation.dispose();
    chatLink.dispose();
    chatPassword.dispose();
    dues.dispose();
  }
}