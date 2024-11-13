import 'package:flutter/material.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class CustomTapDebouncer extends StatelessWidget {
  final Duration cooldown;
  final Future<void> Function()? onTap;
  final Widget Function(BuildContext context, Future<void> Function()? onTap) builder;

  const CustomTapDebouncer({
    super.key,
    this.cooldown = const Duration(milliseconds: 1000),
    required this.onTap,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return TapDebouncer(
      cooldown: cooldown,
      onTap: onTap,
      builder: (context, onTap) => builder(context, onTap),
    );
  }
}
