import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woohakdong/view_model/club/components/club_name_validation_state.dart';
import 'package:woohakdong/view_model/util/s3_image_provider.dart';

import '../../model/club/club.dart';
import '../../repository/club/club_repository.dart';
import '../../service/logger/logger.dart';
import 'club_name_validation_provider.dart';
import 'current_club_provider.dart';

final clubProvider = StateNotifierProvider<ClubNotifier, Club>((ref) {
  return ClubNotifier(ref);
});

class ClubNotifier extends StateNotifier<Club> {
  final Ref ref;
  final ClubRepository clubRepository = ClubRepository();

  ClubNotifier(this.ref)
      : super(
          Club(
            clubId: 0,
            clubName: '',
            clubEnglishName: '',
            clubGeneration: '',
            clubDues: 0,
            clubRoom: '',
            clubDescription: '',
            clubImage: '',
          ),
        );

  Future<void> clubNameValidation(String clubName, String clubEnglishName) async {
    final isValid = await clubRepository.clubNameValidation(clubName, clubEnglishName);

    if (isValid) {
      ref.read(clubNameValidationProvider.notifier).state = ClubNameValidationState.valid;
    } else {
      ref.read(clubNameValidationProvider.notifier).state = ClubNameValidationState.invalid;
    }
  }

  void saveClubInfo(String clubName, String clubEnglishName, String clubDescription) {
    state = state.copyWith(
      clubName: clubName,
      clubEnglishName: clubEnglishName,
      clubDescription: clubDescription,
    );
  }

  void saveClubOtherInfo(
      String clubGeneration, int clubDues, String clubRoom, String clubGroupChatLink, String clubGroupChatPassword) {
    state = state.copyWith(
      clubGeneration: clubGeneration,
      clubDues: clubDues,
      clubRoom: clubRoom,
      clubGroupChatLink: clubGroupChatLink,
      clubGroupChatPassword: clubGroupChatPassword,
    );
  }

  Future<void> registerClub(String clubImageForServer) async {
    try {
      final clubId = await clubRepository.registerClubInfo(state.copyWith(clubImage: clubImageForServer));
      await ref.read(s3ImageProvider.notifier).uploadImagesToS3();

      state = state.copyWith(clubId: clubId);
    } catch (e) {
      logger.e('동아리 ID 실패', error: e);
    }
  }
}
