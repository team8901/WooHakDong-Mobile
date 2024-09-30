import 'package:flutter/cupertino.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class RecommendWord extends StatelessWidget {
  const RecommendWord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '학교 계정으로 로그인해 주세요',
        style: context.textTheme.bodySmall!.copyWith(
          color: context.colorScheme.primary,
        ),
      ),
    );
  }
}