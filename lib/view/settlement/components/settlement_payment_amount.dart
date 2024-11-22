import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/service/general/general_format.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class PaymentAmountWidget extends StatelessWidget {
  final int groupAmount;

  const PaymentAmountWidget({
    super.key,
    required this.groupAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('결제 금액', style: context.textTheme.titleLarge),
          const Gap(defaultGapM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '총 금액',
                style: context.textTheme.bodyLarge,
              ),
              Text(
                GeneralFormat.formatClubDues(groupAmount),
                style: context.textTheme.titleLarge,
              ),
            ],
          ),
          const Gap(defaultGapM / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '기본 요금',
                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
              ),
              Text(
                '30,000원',
                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '회원당 추가 요금',
                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
              ),
              Text(
                GeneralFormat.formatClubDues(groupAmount - 30000),
                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
