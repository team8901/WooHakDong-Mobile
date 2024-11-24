import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view_model/club/components/availability/club_availability_state.dart';
import 'package:woohakdong/view_model/club/components/availability/club_availability_state_provider.dart';
import 'package:woohakdong/view_model/club/components/club_state.dart';
import 'package:woohakdong/view_model/club/components/club_state_provider.dart';
import 'package:woohakdong/view_model/club/components/name/club_name_validation_state.dart';
import 'package:woohakdong/view_model/util/s3_image_provider.dart';

import '../../model/club/club.dart';
import '../../repository/club/club_repository.dart';
import 'club_id_provider.dart';
import 'components/name/club_name_validation_provider.dart';

final clubProvider = StateNotifierProvider<ClubNotifier, Club>((ref) {
  return ClubNotifier(ref);
});

class ClubNotifier extends StateNotifier<Club> {
  final Ref ref;
  final ClubRepository clubRepository = ClubRepository();

  ClubNotifier(this.ref) : super(Club());

  Future<void> clubNameValidation(String clubName, String clubEnglishName) async {
    final isValid = await clubRepository.clubNameValidation(clubName, clubEnglishName);

    if (isValid) {
      ref.read(clubNameValidationProvider.notifier).state = ClubNameValidationState.valid;
    } else {
      ref.read(clubNameValidationProvider.notifier).state = ClubNameValidationState.invalid;
    }
  }

  void saveClubInfo(
    String clubName,
    String clubEnglishName,
    String clubDescription,
  ) {
    state = state.copyWith(
      clubName: clubName,
      clubEnglishName: clubEnglishName,
      clubDescription: clubDescription,
    );
  }

  void saveClubOtherInfo(
    String clubGeneration,
    int clubDues,
    String clubRoom,
    String clubGroupChatLink,
    String clubGroupChatPassword,
  ) {
    state = state.copyWith(
      clubGeneration: clubGeneration,
      clubDues: clubDues,
      clubRoom: clubRoom,
      clubGroupChatLink: clubGroupChatLink,
      clubGroupChatPassword: clubGroupChatPassword,
    );
  }

  Future<void> registerClub() async {
    ref.read(clubStateProvider.notifier).state = ClubState.loading;

    try {
      List<String> imageUrls = await ref.read(s3ImageProvider.notifier).setImageUrl('1');
      final clubImageUrl = imageUrls.isNotEmpty ? imageUrls[0] : '';
      String clubImageForServer = clubImageUrl.substring(0, clubImageUrl.indexOf('?'));
      await ref.read(s3ImageProvider.notifier).uploadImagesToS3();

      final clubId = await clubRepository.registerClubInfo(state.copyWith(clubImage: clubImageForServer));

      if (clubId != null) {
        await ref.read(clubIdProvider.notifier).saveClubId(clubId);
      }
    } catch (e) {
      ref.read(clubStateProvider.notifier).state = ClubState.clubNotRegistered;
      rethrow;
    }
  }

  Future<void> checkClubAvailability() async {
    try {
      final currentClubId = ref.watch(clubIdProvider);
      await clubRepository.checkClubAvailability(currentClubId!);

      ref.read(clubAvailabilityStateProvider.notifier).state = ClubAvailabilityState.available;
    } catch (e) {
      ref.read(clubAvailabilityStateProvider.notifier).state = ClubAvailabilityState.notAvailable;
    }
  }
}
