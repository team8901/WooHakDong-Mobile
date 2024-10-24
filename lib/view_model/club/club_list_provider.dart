import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/club/club.dart';
import 'package:woohakdong/repository/club/club_repository.dart';

final clubListProvider = FutureProvider<List<Club>>((ref) async {
  return await ClubRepository().getClubList();
});
