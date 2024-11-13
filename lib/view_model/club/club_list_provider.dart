import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/club/club.dart';
import '../../repository/club/club_repository.dart';
import 'components/club_state.dart';
import 'components/club_state_provider.dart';

final clubListProvider = StateNotifierProvider<ClubListNotifier, List<Club>>((ref) {
  return ClubListNotifier(ref);
});

class ClubListNotifier extends StateNotifier<List<Club>> {
  final Ref ref;
  final ClubRepository clubRepository = ClubRepository();

  ClubListNotifier(this.ref) : super([]);

  Future<void> getClubList() async {
    try {
      final List<Club> clubList = await clubRepository.getClubList();

      if (clubList.isEmpty) {
        ref.read(clubStateProvider.notifier).state = ClubState.clubNotRegistered;
      } else {
        ref.read(clubStateProvider.notifier).state = ClubState.clubRegistered;
      }

      state = clubList;
    } catch (e) {
      rethrow;
    }
  }
}
