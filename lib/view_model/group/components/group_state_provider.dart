import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'group_state.dart';

final groupStateProvider = StateProvider<GroupState>((ref) => GroupState.initial);
