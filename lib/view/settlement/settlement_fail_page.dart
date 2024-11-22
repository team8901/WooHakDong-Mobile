import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_pop_scope.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/spacing.dart';

class SettlementFailPage extends StatelessWidget {
  const SettlementFailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPopScope(
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: defaultPaddingM * 3,
              left: defaultPaddingM,
              right: defaultPaddingM,
              bottom: defaultPaddingM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '결제에 실패했어요 😢',
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: context.colorScheme.error,
                  ),
                ),
                Text(
                  '다시 시도해 주세요',
                  style: context.textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () async => await Phoenix.rebirth(context),
            buttonText: '돌아가기',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
