import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClubItemHistoryPage extends ConsumerWidget {
  const ClubItemHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전체 물품 대여 내역'),
      ),
    );
  }
}
