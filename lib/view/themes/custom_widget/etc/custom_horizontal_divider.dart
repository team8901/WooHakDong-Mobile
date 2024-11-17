import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../spacing.dart';

class CustomHorizontalDivider extends StatelessWidget {
  const CustomHorizontalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.colorScheme.surfaceContainer,
      thickness: 0.6,
      height: 0,
      indent: defaultPaddingM,
      endIndent: defaultPaddingM,
    );
  }
}
