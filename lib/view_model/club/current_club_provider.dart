import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/club/club.dart';

import 'club_id_provider.dart';
import 'club_list_provider.dart';

final currentClubProvider = Provider<Club?>((ref) {
  final clubListData = ref.watch(clubListProvider);
  final savedClubId = ref.watch(clubIdProvider);

  return clubListData.when(
    data: (clubList) {
      if (clubList.isNotEmpty) {
        if (savedClubId != null) {
          return clubList.firstWhere(
            (club) => club.clubId == savedClubId,
            orElse: () => clubList[0],
          );
        } else {
          return clubList[0];
        }
      } else {
        return null;
      }
    },
    loading: () => null,
    error: (_, __) => null,
  );
});
