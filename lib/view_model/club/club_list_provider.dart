import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/club/club.dart';

import 'club_provider.dart';

final clubListProvider = FutureProvider<List<Club>>((ref) async {
  return await ref.read(clubProvider.notifier).getClubList();
});
