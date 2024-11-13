import 'package:flutter/cupertino.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: context.colorScheme.onSurface,
      ),
    );
  }
}
