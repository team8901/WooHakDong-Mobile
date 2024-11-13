import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club/components/club_state.dart';
import '../../view_model/club/components/club_state_provider.dart';
import '../../view_model/club/current_club_info_provider.dart';
import '../../view_model/util/components/s3_image_state.dart';
import '../../view_model/util/s3_image_provider.dart';
import '../club_register/components/club_register_image_dialog.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/button/custom_info_tooltip.dart';
import '../themes/custom_widget/interface/custom_counter_text_form_field.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'components/club_info_edit_controller.dart';

class ClubInfoEditPage extends ConsumerStatefulWidget {
  const ClubInfoEditPage({super.key});

  @override
  ConsumerState<ClubInfoEditPage> createState() => _ClubInfoEditPageState();
}

class _ClubInfoEditPageState extends ConsumerState<ClubInfoEditPage> {
  final _formKey = GlobalKey<FormState>();
  late final ClubInfoEditController _clubInfoEditController;

  @override
  void initState() {
    super.initState();
    _clubInfoEditController = ClubInfoEditController();
  }

  @override
  void dispose() {
    _clubInfoEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentClubInfo = ref.watch(currentClubInfoProvider);

    _clubInfoEditController.updateFromClubInfo(currentClubInfo);

    final imageProvider = CachedNetworkImageProvider(currentClubInfo.clubImage!);
    final s3ImageNotifier = ref.read(s3ImageProvider.notifier);
    final s3ImageState = ref.watch(s3ImageProvider);
    final clubStateNotifier = ref.read(clubStateProvider.notifier);
    final clubState = ref.watch(clubStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('정보 수정'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Center(
                  child: SizedBox(
                    width: 192.r,
                    height: 192.r,
                    child: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => ClubRegisterImageDialog(s3ImageNotifier: s3ImageNotifier),
                      ),
                      child: Stack(
                        children: [
                          SizedBox.expand(
                            child: Ink(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: context.colorScheme.surfaceContainer),
                                image: s3ImageState.pickedImages.isEmpty
                                    ? DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: FileImage(s3ImageState.pickedImages[0]),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12.r,
                            right: 12.r,
                            child: Container(
                              width: 36.r,
                              height: 36.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.colorScheme.inverseSurface,
                              ),
                              child: Icon(
                                Symbols.camera_alt_rounded,
                                color: context.colorScheme.surfaceDim,
                                size: 20,
                                fill: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(defaultGapXL),
                Text(
                  '동아리 기본 정보',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                GestureDetector(
                  onTap: () => GeneralFunctions.toastMessage('동아리 이름은 수정할 수 없어요'),
                  child: CustomTextFormField(
                    labelText: '동아리 이름',
                    initialValue: currentClubInfo.clubName,
                    readOnly: true,
                    enabled: false,
                  ),
                ),
                const Gap(defaultGapM),
                GestureDetector(
                  onTap: () => GeneralFunctions.toastMessage('동아리 영문 이름은 수정할 수 없어요'),
                  child: CustomTextFormField(
                    labelText: '동아리 영문 이름',
                    initialValue: currentClubInfo.clubEnglishName,
                    readOnly: true,
                    enabled: false,
                  ),
                ),
                const Gap(defaultGapM),
                CustomCounterTextFormField(
                  controller: _clubInfoEditController.description,
                  labelText: '동아리 설명',
                  hintText: '500자 이내로 입력해 주세요',
                  minLines: 1,
                  maxLength: 300,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '동아리 설명을 입력해 주세요';
                    }
                    return null;
                  },
                ),
                const Gap(defaultGapXL),
                Text(
                  '동아리 추가 정보',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  controller: _clubInfoEditController.generation,
                  labelText: '현재 기수',
                  hintText: '비워놔도 돼요',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  controller: _clubInfoEditController.dues,
                  labelText: '동아리 회비',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CurrencyTextInputFormatter.currency(
                      symbol: '',
                      locale: 'ko_KR',
                    )
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '동아리 회비를 입력해 주세요';
                    }
                    return null;
                  },
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  controller: _clubInfoEditController.room,
                  labelText: '동아리 방',
                  hintText: '비워놔도 돼요',
                ),
                const Gap(defaultGapXL),
                Text(
                  '카카오톡 채팅방',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  controller: _clubInfoEditController.chatLink,
                  labelText: '카카오톡 채팅방 링크',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '카카오톡 채팅방 링크를 입력해 주세요';
                    }
                    return null;
                  },
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  controller: _clubInfoEditController.chatPassword,
                  labelText: '카카오톡 채팅방 비밀번호',
                  hintText: '비워놔도 돼요',
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () async {
            if (!_formKey.currentState!.validate()) return;

            _formKey.currentState!.save();

            try {
              clubStateNotifier.state = ClubState.loading;

              final clubImage = await _getUpdatedClubImage(s3ImageNotifier, s3ImageState);

              await _updateClubInfo(clubImage);

              if (context.mounted) {
                ref.invalidate(s3ImageProvider);
                GeneralFunctions.toastMessage('동아리 정보가 수정되었어요');
                clubStateNotifier.state = ClubState.clubRegistered;
                Navigator.pop(context);
              }
            } catch (e) {
              clubStateNotifier.state = ClubState.clubRegistered;
              GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
            }
          },
          buttonText: '저장',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          isLoading: clubState == ClubState.loading,
        ),
      ),
    );
  }

  Future<String> _getUpdatedClubImage(S3ImageNotifier s3ImageNotifier, S3ImageState s3ImageState) async {
    if (s3ImageState.pickedImages.isEmpty) {
      return ref.read(currentClubInfoProvider).clubImage ?? '';
    }

    List<String> imageUrls = await s3ImageNotifier.setImageUrl('1');
    final itemImageUrl = imageUrls.isNotEmpty ? imageUrls[0] : '';
    String itemImageForServer = itemImageUrl.split('?').first;
    await s3ImageNotifier.uploadImagesToS3();

    return itemImageForServer;
  }

  Future<void> _updateClubInfo(String clubImage) async {
    final currentClubInfoNotifier = ref.read(currentClubInfoProvider.notifier);
    await currentClubInfoNotifier.updateCurrentClubInfo(
      clubImage,
      _clubInfoEditController.description.text,
      _clubInfoEditController.room.text,
      _clubInfoEditController.generation.text,
      int.parse(_clubInfoEditController.dues.text.replaceAll(',', '')),
      _clubInfoEditController.chatLink.text,
      _clubInfoEditController.chatPassword.text,
    );
  }
}
