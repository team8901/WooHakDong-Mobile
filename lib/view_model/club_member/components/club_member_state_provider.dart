import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'club_member_state.dart';

final clubMemberStateProvider = StateProvider<ClubMemberState>((ref) => ClubMemberState.initial);
