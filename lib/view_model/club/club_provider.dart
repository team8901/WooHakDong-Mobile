import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view_model/club/components/club_name_validation_state.dart';

import '../../model/club/club.dart';
import '../../repository/club/club_info.dart';
import 'club_name_validation_provider.dart';

final clubProvider = StateNotifierProvider<ClubNotifier, Club>((ref) {
  return ClubNotifier(ref);
});

class ClubNotifier extends StateNotifier<Club> {
  ClubNotifier(this.ref)
      : super(
          Club(
            clubName: '',
            clubEnglishName: '',
            clubImage: '',
            clubDescription: '',
            clubRoom: '없음',
            clubGeneration: '',
            clubDues: 0,
          ),
        );

  final Ref ref;
  final ClubInfo clubInfo = ClubInfo();

  Future<void> clubNameValidation(String clubName, String clubEnglishName) async {
    final isValid = await clubInfo.clubNameValidation(clubName, clubEnglishName);

    if (isValid) {
      state.clubName = clubName;
      state.clubEnglishName = clubEnglishName;

      ref.read(clubNameValidationProvider.notifier).state = ClubNameValidationState.valid;
    } else {
      ref.read(clubNameValidationProvider.notifier).state = ClubNameValidationState.invalid;
    }
  }
}
