import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final double? edgeOffset;
  final Widget child;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    this.edgeOffset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: context.colorScheme.primary,
      backgroundColor: context.colorScheme.surfaceBright,
      onRefresh: onRefresh,
      edgeOffset: edgeOffset ?? 0,
      child: child,
    );
  }
}
