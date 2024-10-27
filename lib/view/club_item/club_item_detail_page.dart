import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ClubItemDetailPage extends ConsumerWidget {
  final int? itemId;

  const ClubItemDetailPage({
    super.key,
    this.itemId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemId.toString()),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Symbols.delete_rounded),
          ),
        ],
      ),
    );
  }
}
