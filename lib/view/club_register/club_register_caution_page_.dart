import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/club_register/club_register_name_info_form_page.dart';
import 'package:woohakdong/view/club_register/components/club_register_caution.dart';

import '../../view_model/auth/auth_provider.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/spacing.dart';
import 'components/club_register_caution_introduce.dart';

class ClubRegisterCautionPage extends ConsumerWidget {
  const ClubRegisterCautionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
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
          onTap: () {
            //authNotifier.signOut();
            _pushNameInfoPage(context);
          },
          buttonText: '알겠어요',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  void _pushNameInfoPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterNameInfoFormPage(),
      ),
      (route) => false,
    );
  }
}
