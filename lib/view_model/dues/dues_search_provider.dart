import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/dues/dues.dart';
import '../../repository/dues/dues_repository.dart';
import '../club/club_id_provider.dart';

final duesSearchProvider = FutureProvider.autoDispose.family<List<Dues>, String>((ref, keyword) async {
  if (keyword.isEmpty) return [];

  final currentClubId = ref.read(clubIdProvider);
  final DuesRepository duesRepository = DuesRepository();

  final duesSearchedList = await duesRepository.getDuesList(
    currentClubId!,
    null,
    keyword,
  );

  return duesSearchedList;
});
