import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? indicatorColor;
  final double? size;

  const CustomProgressIndicator({
    super.key,
    this.indicatorColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: indicatorColor ?? context.colorScheme.inversePrimary,
        size: size ?? 24,
      ),
    );
  }
}
