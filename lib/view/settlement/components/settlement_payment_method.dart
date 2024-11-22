import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String selectedPg;
  final ValueChanged<String> onSelectedPgChanged;

  const PaymentMethodWidget({
    super.key,
    required this.selectedPg,
    required this.onSelectedPgChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('결제 수단', style: context.textTheme.titleLarge),
          const Gap(defaultGapM),
          InkWell(
            onTap: () => onSelectedPgChanged('kakaopay'),
            borderRadius: BorderRadius.circular(defaultBorderRadiusM),
            highlightColor: context.colorScheme.surfaceContainer,
            child: Ink(
              height: 52,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedPg == 'kakaopay'
                      ? context.colorScheme.inverseSurface
                      : context.colorScheme.surfaceContainer,
                ),
                borderRadius: BorderRadius.circular(defaultBorderRadiusM),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPaddingS),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logos/kakao_payment_logo.png',
                      height: 24,
                    ),
                    Text('카카오페이', style: context.textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ),
          const Gap(defaultGapS),
          InkWell(
            onTap: () => onSelectedPgChanged('tosspay'),
            borderRadius: BorderRadius.circular(defaultBorderRadiusM),
            highlightColor: context.colorScheme.surfaceContainer,
            child: Ink(
              height: 52,
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedPg == 'tosspay'
                      ? context.colorScheme.inverseSurface
                      : context.colorScheme.surfaceContainer,
                ),
                borderRadius: BorderRadius.circular(defaultBorderRadiusM),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPaddingS),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logos/toss_payment_logo.svg',
                      height: 16,
                    ),
                    Text('토스페이', style: context.textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ),
          const Gap(defaultGapS),
          InkWell(
            onTap: () => onSelectedPgChanged('naverpay'),
            borderRadius: BorderRadius.circular(defaultBorderRadiusM),
            highlightColor: context.colorScheme.surfaceContainer,
            child: Ink(
              height: 52,
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedPg == 'naverpay'
                      ? context.colorScheme.inverseSurface
                      : context.colorScheme.surfaceContainer,
                ),
                borderRadius: BorderRadius.circular(defaultBorderRadiusM),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPaddingS),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logos/naver_payment_logo.svg',
                      height: 22,
                    ),
                    Text('네이버페이', style: context.textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
