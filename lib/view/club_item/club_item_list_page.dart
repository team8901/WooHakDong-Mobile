import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ClubItemListPage extends ConsumerWidget {
  const ClubItemListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('물품'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Symbols.search_rounded),
          ),
        ],
      ),
    );
  }
}
