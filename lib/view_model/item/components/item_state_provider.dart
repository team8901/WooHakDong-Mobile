import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'item_state.dart';

final itemStateProvider = StateProvider<ItemState>((ref) => ItemState.initial);
