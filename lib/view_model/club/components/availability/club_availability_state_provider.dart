import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'club_availability_state.dart';

final clubAvailabilityStateProvider = StateProvider<ClubAvailabilityState>((ref) => ClubAvailabilityState.notAvailable);
