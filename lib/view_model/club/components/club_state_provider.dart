import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'club_state.dart';

final clubStateProvider = StateProvider<ClubState>((ref) => ClubState.clubNotRegistered);
