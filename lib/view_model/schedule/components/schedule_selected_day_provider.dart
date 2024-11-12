import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleSelectedDayProvider = StateProvider<DateTime?>((ref) => DateTime.now());
