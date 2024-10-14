import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/custom_widget/custom_border_text_form_field.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club/club_provider.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/spacing.dart';
import 'club_register_info_check_page.dart';

class ClubRegisterDescriptionFormPage extends ConsumerWidget {
  const ClubRegisterDescriptionFormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final clubNotifier = ref.read(clubProvider.notifier);

    String? clubDescription;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPaddingM,
            vertical: defaultPaddingM,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '어떤 동아리인지 궁금해요',
                style: context.textTheme.titleLarge,
              ),
              const Gap(defaultGapXL * 2),
              Text(
                '동아리 설명',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(defaultGapS),
              Form(
                key: formKey,
                child: CustomBorderTextFormField(
                  onSaved: (value) => clubDescription = value,
                  hintText: '동아리에 대해서 설명해 주세요',
                  minLines: 7,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '동아리 설명을 입력해 주세요';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () async {
            if (formKey.currentState?.validate() == true) {
              formKey.currentState?.save();

              clubNotifier.saveClubDescription(clubDescription!);

              if (context.mounted) {
                _pushInfoCheckPage(context);
              }
            }
          },
          buttonText: '다음',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  void _pushInfoCheckPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterInfoCheckPage(),
      ),
    );
  }
}
