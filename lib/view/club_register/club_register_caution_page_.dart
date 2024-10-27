import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/club_register/club_register_info_form_page.dart';
import 'package:woohakdong/view/club_register/components/club_register_caution.dart';
import 'package:woohakdong/view_model/club/components/club_name_validation_provider.dart';
import 'package:woohakdong/view_model/club/components/club_name_validation_state.dart';
import 'package:woohakdong/view_model/util/s3_image_provider.dart';

import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/spacing.dart';
import 'components/club_register_caution_introduce.dart';

class ClubRegisterCautionPage extends ConsumerWidget {
  const ClubRegisterCautionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      onPopInvokedWithResult: (didPop, dynamic) {
        if (didPop) {
          ref.invalidate(s3ImageProvider);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(defaultPaddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClubRegisterCautionIntroduce(),
                Gap(defaultGapXL * 2),
                ClubRegisterCaution(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () => _pushNameInfoPage(context, ref),
            buttonText: '다 읽었어요',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }

  void _pushNameInfoPage(BuildContext context, WidgetRef ref) {
    ref.read(clubNameValidationProvider.notifier).state = ClubNameValidationState.notChecked;

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterNameInfoFormPage(),
      ),
    );
  }
}
