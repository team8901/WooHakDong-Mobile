import 'package:flutter/material.dart';
import 'package:woohakdong/service/general/general_format.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class SettlementBottomButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;
  final int amount;

  const SettlementBottomButton({
    super.key,
    required this.isLoading,
    required this.onTap,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(
          left: defaultPaddingM,
          right: defaultPaddingM,
          bottom: defaultPaddingM,
        ),
        width: double.infinity,
        height: 52,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          highlightColor: context.colorScheme.surfaceContainer,
          child: Ink(
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(defaultBorderRadiusM),
            ),
            child: isLoading
                ? const CustomProgressIndicator()
                : Center(
                    child: Text(
                      '${GeneralFormat.formatClubDues(amount)} 결제하기',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.inversePrimary,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
