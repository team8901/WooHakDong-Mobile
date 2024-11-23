import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view_model/group/group_provider.dart';

import '../payment/payment_page.dart';
import 'components/settlement_bottom_button.dart';
import 'components/settlement_payment_amount.dart';
import 'components/settlement_payment_info.dart';
import 'components/settlement_payment_method.dart';

class SettlementInfoPage extends ConsumerStatefulWidget {
  const SettlementInfoPage({super.key});

  @override
  ConsumerState<SettlementInfoPage> createState() => _SettlementInfoPageState();
}

class _SettlementInfoPageState extends ConsumerState<SettlementInfoPage> {
  bool _isLoading = false;
  String? _selectedPg;

  @override
  void initState() {
    super.initState();
    _selectedPg = 'kakaopay';
  }

  @override
  Widget build(BuildContext context) {
    final serviceFeeGroupInfo = ref.watch(groupProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentInfoWidget(groupName: serviceFeeGroupInfo.groupName!),
              const Divider(
                height: 58,
                thickness: 8,
                color: Color(0xFFF2F3F6),
              ),
              PaymentMethodWidget(
                selectedPg: _selectedPg!,
                onSelectedPgChanged: (String newPg) {
                  setState(() => _selectedPg = newPg);
                },
              ),
              const Divider(
                height: 58,
                thickness: 8,
                color: Color(0xFFF2F3F6),
              ),
              PaymentAmountWidget(groupAmount: serviceFeeGroupInfo.groupAmount!),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SettlementBottomButton(
        isLoading: _isLoading,
        amount: serviceFeeGroupInfo.groupAmount!,
        onTap: () async {
          if (_isLoading) return;

          if (_selectedPg == 'tosspay' || _selectedPg == 'naverpay') {
            GeneralFunctions.toastMessage('현재 지원하지 않는 결제 수단이에요');
            return;
          }

          try {
            setState(() => _isLoading = true);

            const uuid = Uuid();
            final merchantUid = 'payment-${uuid.v4()}'.substring(0, 40);

            await ref.read(groupProvider.notifier).getOrderIdServiceFeeGroup(merchantUid);

            if (context.mounted) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => PaymentPage(
                    pg: _selectedPg!,
                    merchantUid: merchantUid,
                  ),
                ),
              );

              setState(() => _isLoading = false);
            }
          } catch (e) {
            setState(() => _isLoading = false);
            GeneralFunctions.toastMessage('결제 시도 중 오류가 발생했어요\n다시 시도해 주세요');
            rethrow;
          }
        },
      ),
    );
  }
}
