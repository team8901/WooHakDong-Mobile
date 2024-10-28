import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/item/item_history.dart';
import 'item_provider.dart';

final itemHistoryListProvider = FutureProvider.family<List<ItemHistory>, int>((ref, itemId) async {
  return await ref.read(itemProvider.notifier).getItemHistoryList(itemId);
});
