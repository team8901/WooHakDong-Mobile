import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path_provider/path_provider.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/club_register/club_register_other_info_form_page.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/components/club_name_validation_state.dart';

import '../../view_model/club/club_provider.dart';
import '../../view_model/club/components/club_name_validation_provider.dart';
import '../../view_model/util/s3_image_provider.dart';
import '../themes/custom_widget/custom_bottom_button.dart';
import '../themes/custom_widget/custom_counter_text_form_field.dart';
import '../themes/custom_widget/custom_text_form_field.dart';
import '../themes/spacing.dart';

class ClubRegisterNameInfoFormPage extends ConsumerStatefulWidget {
  const ClubRegisterNameInfoFormPage({super.key});

  @override
  ConsumerState<ClubRegisterNameInfoFormPage> createState() => _ClubRegisterNameInfoFormPageState();
}

class _ClubRegisterNameInfoFormPageState extends ConsumerState<ClubRegisterNameInfoFormPage> {
  final GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> descriptionFormKey = GlobalKey<FormState>();

  late TextEditingController clubNameController;
  late TextEditingController clubEnglishNameController;
  late TextEditingController clubDescriptionController;

  @override
  void initState() {
    super.initState();
    clubNameController = TextEditingController();
    clubEnglishNameController = TextEditingController();
    clubDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    clubNameController.dispose();
    clubEnglishNameController.dispose();
    clubDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clubNotifier = ref.read(clubProvider.notifier);
    final clubNameValidationState = ref.watch(clubNameValidationProvider);
    final clubNameValidationNotifier = ref.read(clubNameValidationProvider.notifier);
    final s3ImageNotifier = ref.read(s3ImageProvider.notifier);
    final s3ImageState = ref.watch(s3ImageProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '동아리에 대해서 알고 싶어요',
                style: context.textTheme.headlineSmall,
              ),
              Text(
                '영문 이름은 동아리 페이지를 만드는 데 사용돼요',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(defaultGapXL),
              Text(
                '동아리 로고 및 대표 사진',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(defaultGapS),
              SizedBox(
                width: 96.r,
                height: 96.r,
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
                              Symbols.camera_alt_rounded,
                              color: context.colorScheme.outline,
                            ),
                          )
                        : SizedBox(
                            width: 96.r,
                            height: 96.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                              child: Image.file(
                                s3ImageState.pickedImages[0],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const Gap(defaultGapXL),
              Form(
                key: nameFormKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: clubNameController,
                      labelText: '동아리 이름',
                      keyboardType: TextInputType.name,
                      onChanged: (value) => clubNameValidationNotifier.state = ClubNameValidationState.notChecked,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '동아리 이름을 입력해 주세요';
                        }
                        return null;
                      },
                    ),
                    const Gap(defaultGapXL),
                    CustomTextFormField(
                      controller: clubEnglishNameController,
                      labelText: '동아리 영문 이름',
                      hintText: '소문자와 숫자만 입력해 주세요',
                      keyboardType: TextInputType.name,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9]'))],
                      onChanged: (value) => clubNameValidationNotifier.state = ClubNameValidationState.notChecked,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '동아리 영문 이름을 입력해 주세요';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Gap(defaultGapXL),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (clubNameValidationState == ClubNameValidationState.valid)
                    Text(
                      '사용 가능한 동아리 이름이에요',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.tertiary,
                      ),
                    )
                  else if (clubNameValidationState == ClubNameValidationState.invalid)
                    Text(
                      '이미 사용 중인 동아리 이름이에요',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.error,
                      ),
                    )
                  else if (clubNameValidationState == ClubNameValidationState.notChecked)
                    const SizedBox(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPaddingL / 3,
                      vertical: defaultPaddingL / 6,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (nameFormKey.currentState?.validate() == true) {
                          clubNotifier.clubNameValidation(
                            clubNameController.text,
                            clubEnglishNameController.text,
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          '중복 확인',
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: descriptionFormKey,
                child: CustomCounterTextFormField(
                  controller: clubDescriptionController,
                  labelText: '동아리 설명',
                  maxLength: 500,
                  keyboardType: TextInputType.text,
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
            if (nameFormKey.currentState?.validate() == true) {
              if (clubNameValidationState == ClubNameValidationState.valid) {
                if (descriptionFormKey.currentState?.validate() == true) {
                  if (s3ImageState.pickedImages.isEmpty) {
                    final byteData = await rootBundle.load('assets/images/club/club_basic_image.jpg');

                    final tempFile = File('${(await getTemporaryDirectory()).path}/club_basic_image.jpg');
                    await tempFile.writeAsBytes(byteData.buffer.asUint8List());

                    List<File> pickedImage = [tempFile];
                    await s3ImageNotifier.setClubImage(pickedImage);
                  }

                  clubNotifier.saveClubInfo(
                    clubNameController.text,
                    clubEnglishNameController.text,
                    clubDescriptionController.text,
                  );

                  if (context.mounted) {
                    _pushOtherInfoPage(context);
                  }
                }
              } else if (clubNameValidationState == ClubNameValidationState.invalid ||
                  clubNameValidationState == ClubNameValidationState.notChecked) {
                GeneralFunctions.generalToastMessage('동아리 이름을 중복 확인해 주세요');
              }
            }
          },
          buttonText: '다음',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  Future<void> _pickClubImage(S3ImageNotifier s3ImageNotifier) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);

      List<File> pickedImage = [imageFile];

      await s3ImageNotifier.setClubImage(pickedImage);
    }
  }

  void _pushOtherInfoPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterOtherInfoFormPage(),
      ),
    );
  }
}
