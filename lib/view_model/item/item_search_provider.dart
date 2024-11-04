import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/item/item.dart';
import 'item_provider.dart';

final itemSearchProvider = FutureProvider.autoDispose.family<List<Item>, String>((ref, keyword) {
  if (keyword.isEmpty) return [];
  final itemNotifier = ref.watch(itemProvider.notifier);
  return itemNotifier.getItemList(keyword, null);
});