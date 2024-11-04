import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'member_state.dart';

final memberStateProvider = StateProvider<MemberState>((ref) => MemberState.memberNotRegistered);
