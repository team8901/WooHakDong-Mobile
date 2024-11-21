import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path_provider/path_provider.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/club_register/club_register_other_info_form_page.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/components/name/club_name_validation_state.dart';

import '../../view_model/club/club_provider.dart';
import '../../view_model/club/components/name/club_name_validation_provider.dart';
import '../../view_model/util/s3_image_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/button/custom_info_tooltip.dart';
import '../themes/custom_widget/interface/custom_counter_text_form_field.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'components/club_register_image_dialog.dart';

class ClubRegisterNameInfoFormPage extends ConsumerStatefulWidget {
  const ClubRegisterNameInfoFormPage({super.key});

  @override
  ConsumerState<ClubRegisterNameInfoFormPage> createState() => _ClubRegisterNameInfoFormPageState();
}

class _ClubRegisterNameInfoFormPageState extends ConsumerState<ClubRegisterNameInfoFormPage> {
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _descriptionFormKey = GlobalKey<FormState>();

  late TextEditingController _clubNameController;
  late TextEditingController _clubEnglishNameController;
  late TextEditingController _clubDescriptionController;

  @override
  void initState() {
    super.initState();
    _clubNameController = TextEditingController();
    _clubEnglishNameController = TextEditingController();
    _clubDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _clubNameController.dispose();
    _clubEnglishNameController.dispose();
    _clubDescriptionController.dispose();
    super.dispose();
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
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: context.textTheme.bodySmall,
        title: const Text('1 / 4'),
      ),
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
                '영문 이름은 동아리 전용 페이지에 사용돼요',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(defaultGapXL),
              Row(
                children: [
                  Text(
                    '동아리 로고 및 대표 사진',
                    style: context.textTheme.labelLarge,
                  ),
                  const Gap(defaultGapS / 2),
                  const CustomInfoTooltip(tooltipMessage: '10MB 이하의 사진만 업로드 가능해요'),
                ],
              ),
              const Gap(defaultGapM),
              SizedBox(
                width: 96.r,
                height: 96.r,
                child: InkWell(
                  borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => ClubRegisterImageDialog(s3ImageNotifier: s3ImageNotifier),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: context.colorScheme.surfaceContainer),
                      image: s3ImageState.pickedImages.isEmpty
                          ? null
                          : DecorationImage(
                              image: FileImage(s3ImageState.pickedImages[0]),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: s3ImageState.pickedImages.isEmpty
                        ? Center(
                            child: Icon(
                              Symbols.camera_alt_rounded,
                              color: context.colorScheme.outline,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
              const Gap(defaultGapXL),
              Text(
                '동아리 기본 정보',
                style: context.textTheme.labelLarge,
              ),
              const Gap(defaultGapM),
              Form(
                key: _nameFormKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _clubNameController,
                      labelText: '이름',
                      keyboardType: TextInputType.name,
                      onChanged: (value) => clubNameValidationNotifier.state = ClubNameValidationState.notChecked,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '동아리 이름을 입력해 주세요';
                        }
                        return null;
                      },
                    ),
                    const Gap(defaultGapM),
                    CustomTextFormField(
                      controller: _clubEnglishNameController,
                      labelText: '영문 이름',
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
              const Gap(defaultGapM),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
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
                  const Gap(defaultGapXL),
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
                        if (_nameFormKey.currentState?.validate() != true) return;

                        clubNotifier.clubNameValidation(
                          _clubNameController.text,
                          _clubEnglishNameController.text,
                        );
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
              const Gap(defaultGapM),
              Form(
                key: _descriptionFormKey,
                child: CustomCounterTextFormField(
                  controller: _clubDescriptionController,
                  labelText: '설명',
                  hintText: '300자 이내로 입력해 주세요',
                  minLines: 5,
                  maxLength: 300,
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
            if (_nameFormKey.currentState?.validate() != true) return;

            if (clubNameValidationState != ClubNameValidationState.valid) {
              GeneralFunctions.toastMessage('동아리 이름을 중복 확인해 주세요');
              return;
            }

            if (_descriptionFormKey.currentState?.validate() != true) return;

            if (s3ImageState.pickedImages.isEmpty) {
              final byteData = await rootBundle.load('assets/images/club/club_basic_image.jpg');
              final tempFile = File('${(await getTemporaryDirectory()).path}/club_basic_image.jpg');
              await tempFile.writeAsBytes(byteData.buffer.asUint8List());

              List<File> pickedImage = [tempFile];
              await s3ImageNotifier.setImage(pickedImage);
            }

            clubNotifier.saveClubInfo(
              _clubNameController.text,
              _clubEnglishNameController.text,
              _clubDescriptionController.text,
            );

            if (context.mounted) {
              _pushOtherInfoPage(context);
            }
          },
          buttonText: '다음',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
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
