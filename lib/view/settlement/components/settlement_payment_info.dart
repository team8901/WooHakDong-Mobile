import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class PaymentInfoWidget extends StatelessWidget {
  final String groupName;

  const PaymentInfoWidget({
    super.key,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('결제 정보', style: context.textTheme.titleLarge),
          const Gap(defaultGapM),
          Text(
            groupName,
            style: context.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
