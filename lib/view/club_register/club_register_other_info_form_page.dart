import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club/club_provider.dart';
import '../../view_model/util/s3_image_provider.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/custom_widget/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'club_register_description_form_page.dart';

class ClubRegisterOtherInfoFormPage extends ConsumerStatefulWidget {
  const ClubRegisterOtherInfoFormPage({super.key});

  @override
  ConsumerState<ClubRegisterOtherInfoFormPage> createState() => _ClubRegisterOtherInfoFormPageState();
}

class _ClubRegisterOtherInfoFormPageState extends ConsumerState<ClubRegisterOtherInfoFormPage> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController clubGenerationController;
  late TextEditingController clubDuesController;
  late TextEditingController? clubRoomController;

  @override
  void initState() {
    super.initState();
    clubGenerationController = TextEditingController();
    clubDuesController = TextEditingController();
    clubRoomController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    clubGenerationController.dispose();
    clubDuesController.dispose();
    clubRoomController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s3ImageNotifier = ref.read(s3ImageProvider.notifier);
    final s3ImageState = ref.watch(s3ImageProvider);
    final clubNotifier = ref.read(clubProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPaddingM,
            vertical: defaultPaddingM,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '동아리 기본 정보가 필요해요',
                  style: context.textTheme.titleLarge,
                ),
                const Gap(defaultGapS / 2),
                Text(
                  '동아리 방은 비워놔도 돼요',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const Gap(defaultGapXL * 2),
                Text(
                  '동아리 사진',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const Gap(defaultGapS),
                SizedBox(
                  width: double.infinity,
                  height: 180.h,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                    onTap: () => _pickClubImage(s3ImageNotifier),
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colorScheme.surfaceContainer,
                        ),
                        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                      ),
                      child: s3ImageState.pickedImages.isEmpty
                          ? Center(
                              child: Icon(
                                Icons.add,
                                color: context.colorScheme.onSurface,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                              child: Image.file(
                                s3ImageState.pickedImages[0],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 180.h,
                              ),
                            ),
                    ),
                  ),
                ),
                const Gap(defaultGapXL),
                CustomTextFormField(
                  controller: clubGenerationController,
                  labelText: '동아리 기수',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '동아리 기수를 입력해 주세요';
                    }
                    return null;
                  },
                ),
                const Gap(defaultGapXL),
                CustomTextFormField(
                  controller: clubDuesController,
                  labelText: '동아리 회비',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CurrencyTextInputFormatter.currency(
                      locale: 'ko',
                      decimalDigits: 0,
                      symbol: '',
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '동아리 회비를 입력해 주세요';
                    }
                    return null;
                  },
                ),
                const Gap(defaultGapXL),
                CustomTextFormField(
                  controller: clubRoomController,
                  labelText: '동아리 방',
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () async {
            if (formKey.currentState?.validate() == true) {
              formKey.currentState?.save();

              await clubNotifier.saveClubOtherInfo(
                s3ImageState.s3ImageUrls[0],
                clubGenerationController.text,
                int.parse(clubDuesController.text.replaceAll(',', '')),
                clubRoomController!.text,
              );

              if (context.mounted) {
                _pushDescriptionPage(context);
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

  Future<void> _pickClubImage(S3ImageNotifier s3ImageNotifier) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);

      List<File> pickedImage = [imageFile];

      await s3ImageNotifier.setPickedImages(pickedImage, '1');
    }
  }

  void _pushDescriptionPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterDescriptionFormPage(),
      ),
    );
  }
}
