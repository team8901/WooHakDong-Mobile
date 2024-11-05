import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/repository/club/current_club_repository.dart';
import 'package:woohakdong/view_model/club/club_id_provider.dart';

import '../../model/club/current_club.dart';

final currentClubInfoProvider = StateNotifierProvider<CurrentClubInfoNotifier, CurrentClub>((ref) {
  return CurrentClubInfoNotifier(ref);
});

class CurrentClubInfoNotifier extends StateNotifier<CurrentClub> {
  final Ref ref;
  final CurrentClubRepository currentClubRepository = CurrentClubRepository();

  CurrentClubInfoNotifier(this.ref) : super(CurrentClub());

  Future<void> getCurrentClubInfo() async {
    final currentClubId = ref.watch(clubIdProvider);

    final CurrentClub currentClub = await currentClubRepository.getCurrentClubInfo(currentClubId!);

    state = currentClub;
  }

  Future<void> updateCurrentClubInfo(
    String clubImage,
    String clubDescription,
    String clubRoom,
    String clubGeneration,
    int clubDues,
    String clubGroupChatLink,
    String clubGroupChatPassword,
  ) async {
    final currentClubId = ref.watch(clubIdProvider);

    final CurrentClub updatedCurrentClub = await currentClubRepository.updateCurrentClubInfo(
      state.copyWith(
        clubImage: clubImage,
        clubDescription: clubDescription,
        clubRoom: clubRoom,
        clubGeneration: clubGeneration,
        clubDues: clubDues,
        clubGroupChatLink: clubGroupChatLink,
        clubGroupChatPassword: clubGroupChatPassword,
      ),
      currentClubId!,
    );

    state = updatedCurrentClub;
  }
}
