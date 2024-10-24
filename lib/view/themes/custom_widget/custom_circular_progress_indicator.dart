import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.colorScheme.primary,
        backgroundColor: context.colorScheme.inversePrimary,
        strokeAlign: BorderSide.strokeAlignInside,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
