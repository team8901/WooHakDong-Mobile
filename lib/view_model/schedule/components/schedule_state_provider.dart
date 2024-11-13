import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view_model/schedule/components/schedule_state.dart';

final scheduleStateProvider = StateProvider<ScheduleState>((ref) => ScheduleState.initial);
