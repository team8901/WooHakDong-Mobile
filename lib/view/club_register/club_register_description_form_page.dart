import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../themes/spacing.dart';

class ClubRegisterDescriptionFormPage extends ConsumerStatefulWidget {
  const ClubRegisterDescriptionFormPage({super.key});

  @override
  ConsumerState<ClubRegisterDescriptionFormPage> createState() => _ClubRegisterDescriptionFormPageState();
}

class _ClubRegisterDescriptionFormPageState extends ConsumerState<ClubRegisterDescriptionFormPage> {
  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ),
    );
  }
}
