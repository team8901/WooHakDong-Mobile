import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_pop_scope.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../service/payment/payment_result_payload.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/spacing.dart';

class SettlementCompletePage extends StatelessWidget {
  final PaymentResultPayload paymentResult;

  const SettlementCompletePage({
    super.key,
    required this.paymentResult,
  });

  @override
  Widget build(BuildContext context) {
    PaymentResultPayload payload = paymentResult;
    bool isSuccess = payload.isSuccess;

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
                if (isSuccess)
                  Text(
                    '결제가 완료되었어요 🤗',
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  )
                else
                  Text(
                    '결제에 실패했어요 😢',
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: context.colorScheme.error,
                    ),
                  ),
                if (isSuccess)
                  Text(
                    '이번 학기에도 우학동을 이용해주셔서 감사해요',
                    style: context.textTheme.headlineLarge,
                  )
                else
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
            buttonText: '우학동 다시 시작하기',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
