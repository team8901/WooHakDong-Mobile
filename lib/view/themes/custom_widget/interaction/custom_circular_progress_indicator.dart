import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color? indicatorColor;

  const CustomCircularProgressIndicator({
    super.key,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: indicatorColor ?? context.colorScheme.inversePrimary,
        size: 24,
      ),
    );
  }
}
