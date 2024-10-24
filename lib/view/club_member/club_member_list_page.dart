import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../service/logger/logger.dart';
import '../../view_model/club/current_club_provider.dart';

class ClubMemberListPage extends ConsumerWidget {
  const ClubMemberListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentClubInfo = ref.watch(currentClubProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원'),
        actions: [
          IconButton(
            onPressed: () {
              logger.i(currentClubInfo?.clubImage);
            },
            icon: const Icon(Symbols.search_rounded),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Club ID: ${currentClubInfo?.clubId}'),
          Text('Club Name: ${currentClubInfo?.clubName}'),
          Text('Club Description: ${currentClubInfo?.clubDescription}'),

        ],
      ),
    );
  }
}
