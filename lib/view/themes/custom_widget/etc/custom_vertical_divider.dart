import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: VerticalDivider(
        color: context.colorScheme.outline,
        thickness: 0.6,
        width: 0,
      ),
    );
  }
}
