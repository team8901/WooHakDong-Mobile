import 'package:flutter/material.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class CustomTapDebouncer extends StatelessWidget {
  final Future<void> Function()? onTap;
  final Widget Function(BuildContext context, Future<void> Function()? onTap) builder;

  const CustomTapDebouncer({
    super.key,
    required this.onTap,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return TapDebouncer(
      cooldown: const Duration(milliseconds: 1000),
      onTap: onTap,
      builder: (context, onTap) => builder(context, onTap),
    );
  }
}
