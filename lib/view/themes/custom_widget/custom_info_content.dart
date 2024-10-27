import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomInfoContent extends StatelessWidget {
  final String infoContent;

  const CustomInfoContent({
    super.key,
    required this.infoContent,
  });

  @override
  Widget build(BuildContext context) {
    return Text(infoContent, style: context.textTheme.titleSmall);
  }
}
