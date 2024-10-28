import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view_model/item/item_provider.dart';

import '../../model/item/item.dart';

final itemListProvider = FutureProvider<List<Item>>((ref) async {
  return await ref.read(itemProvider.notifier).getItemList();
});
