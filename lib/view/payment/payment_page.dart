import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:woohakdong/view/settlement/settlement_fail_page.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/group/group_provider.dart';
import '../../view_model/member/member_provider.dart';
import '../settlement/settlement_complete_page.dart';

class PaymentPage extends ConsumerWidget {
  final String pg;
  final String merchantUid;

  const PaymentPage({
    super.key,
    required this.pg,
    required this.merchantUid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceFeeGroupInfo = ref.watch(groupProvider);
    final memberInfo = ref.watch(memberProvider);

    return IamportPayment(
      appBar: AppBar(),
      initialChild: Scaffold(body: CustomProgressIndicator(indicatorColor: context.colorScheme.surfaceContainer)),
      userCode: 'imp06661826',
      data: PaymentData(
        pg: pg,
        payMethod: 'card',
        name: serviceFeeGroupInfo.groupName,
        merchantUid: merchantUid,
        amount: serviceFeeGroupInfo.groupAmount!,
        buyerName: memberInfo!.memberName,
        buyerTel: memberInfo.memberPhoneNumber!,
        buyerEmail: memberInfo.memberEmail,
        appScheme: 'com.team8901.whd.woohakdong',
      ),
      callback: (Map<String, String> result) async {
        try {
          if (result['imp_success'] == 'true' || result['success'] == 'true') {
            await Future.delayed(const Duration(milliseconds: 500));

            await ref.read(groupProvider.notifier).confirmPaymentServiceFeeGroup(
                  result['merchant_uid']!,
                  result['imp_uid']!,
                );
          }

          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => SettlementCompletePage(paymentResult: result)),
              (route) => false,
            );
          }
        } catch (e) {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => const SettlementFailPage()),
              (route) => false,
            );
          }
        }
      },
    );
  }
}
