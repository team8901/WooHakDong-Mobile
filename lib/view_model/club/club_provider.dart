import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view_model/club/components/club_name_validation_state.dart';
import 'package:woohakdong/view_model/util/s3_image_provider.dart';

import '../../model/club/club.dart';
import '../../repository/club/club_repository.dart';
import 'club_name_validation_provider.dart';

final clubProvider = StateNotifierProvider<ClubNotifier, Club>((ref) {
  return ClubNotifier(ref);
});

class ClubNotifier extends StateNotifier<Club> {
  final Ref ref;
  final ClubRepository clubRepository = ClubRepository();

  ClubNotifier(this.ref)
      : super(
          Club(
            clubName: '',
            clubEnglishName: '',
            clubGeneration: '',
            clubDues: 0,
            clubRoom: '',
            clubDescription: '',
            clubImage: '',
            clubId: 0,
          ),
        );

  void saveClubNameInfo(String clubName, String clubEnglishName) async {
    final isValid = await clubRepository.clubNameValidation(clubName, clubEnglishName);

    if (isValid) {
      state = state.copyWith(
        clubName: clubName,
        clubEnglishName: clubEnglishName,
      );

      ref.read(clubNameValidationProvider.notifier).state = ClubNameValidationState.valid;
    } else {
      ref.read(clubNameValidationProvider.notifier).state = ClubNameValidationState.invalid;
    }
  }

  void saveClubOtherInfo(String clubGeneration, int clubDues, String clubRoom) {
    state = state.copyWith(
      clubGeneration: clubGeneration,
      clubDues: clubDues,
      clubRoom: clubRoom,
    );
  }

  void saveClubDescription(String clubDescription) {
    state = state.copyWith(
      clubDescription: clubDescription,
    );
  }

  Future<void> registerClub(String clubImageForServer) async {
    final clubId = await clubRepository.registerClubInfo(state.copyWith(clubImage: clubImageForServer));
    state = state.copyWith(clubId: clubId);

    await ref.read(s3ImageProvider.notifier).uploadImagesToS3();
  }
}
