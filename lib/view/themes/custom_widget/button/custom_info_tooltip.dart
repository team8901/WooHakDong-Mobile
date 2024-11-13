import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../spacing.dart';

class CustomInfoTooltip extends StatelessWidget {
  final String tooltipMessage;

  const CustomInfoTooltip({
    super.key,
    required this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      message: tooltipMessage,
      textStyle: context.textTheme.bodyMedium?.copyWith(
        color: const Color(0xFFFCFCFC),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPaddingS,
        vertical: defaultPaddingXS,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF6C6E75).withOpacity(0.8),
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
      ),
      child: const Icon(
        Symbols.info_rounded,
        size: 14,
      ),
    );
  }
}
