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
import 'package:woohakdong/view_model/club/club_list_provider.dart';

import '../../model/club/club.dart';
import '../../repository/club/club_repository.dart';
import '../../view_model/club/components/club_state.dart';
import '../../view_model/club/components/club_state_provider.dart';
import '../../view_model/util/components/s3_image_state.dart';
import '../../view_model/util/s3_image_provider.dart';
import '../club_register/components/club_register_image_dialog.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interface/custom_counter_text_form_field.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';

class ClubInfoEditPage extends ConsumerStatefulWidget {
  final Club currentClubInfo;

  const ClubInfoEditPage({
    super.key,
    required this.currentClubInfo,
  });

  @override
  ConsumerState<ClubInfoEditPage> createState() => _ClubInfoEditPageState();
}

class _ClubInfoEditPageState extends ConsumerState<ClubInfoEditPage> {
  late final TextEditingController clubDescriptionController;
  late final TextEditingController clubRoomController;
  late final TextEditingController clubGenerationController;
  late final TextEditingController clubGroupChatLinkController;
  late final TextEditingController clubGroupChatPasswordController;
  late final TextEditingController clubDuesController;

  @override
  void initState() {
    super.initState();
    clubDescriptionController = TextEditingController(text: widget.currentClubInfo.clubDescription);
    clubRoomController = TextEditingController(text: widget.currentClubInfo.clubRoom);
    clubGenerationController = TextEditingController(text: widget.currentClubInfo.clubGeneration);
    clubGroupChatLinkController = TextEditingController(text: widget.currentClubInfo.clubGroupChatLink);
    clubGroupChatPasswordController = TextEditingController(text: widget.currentClubInfo.clubGroupChatPassword);
    clubDuesController = TextEditingController(text: widget.currentClubInfo.clubDues.toString());
  }

  @override
  void dispose() {
    clubDescriptionController.dispose();
    clubRoomController.dispose();
    clubGenerationController.dispose();
    clubGroupChatLinkController.dispose();
    clubGroupChatPasswordController.dispose();
    clubDuesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final s3ImageNotifier = ref.read(s3ImageProvider.notifier);
    final s3ImageState = ref.watch(s3ImageProvider);
    final imageProvider = CachedNetworkImageProvider(widget.currentClubInfo.clubImage!);
    final ClubRepository clubRepository = ClubRepository();
    final clubState = ref.watch(clubStateProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, dynamic) {
        if (didPop) {
          ref.invalidate(s3ImageProvider);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('정보 수정'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPaddingM),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '동아리 로고 및 대표 사진',
                    style: context.textTheme.labelLarge,
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
                            // The image background
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
                      initialValue: widget.currentClubInfo.clubName,
                      readOnly: true,
                      enabled: false,
                    ),
                  ),
                  const Gap(defaultGapM),
                  GestureDetector(
                    onTap: () => GeneralFunctions.toastMessage('동아리 영문 이름은 수정할 수 없어요'),
                    child: CustomTextFormField(
                      labelText: '동아리 영문 이름',
                      initialValue: widget.currentClubInfo.clubEnglishName,
                      readOnly: true,
                      enabled: false,
                    ),
                  ),
                  const Gap(defaultGapM),
                  CustomCounterTextFormField(
                    controller: clubDescriptionController,
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
                    controller: clubGenerationController,
                    labelText: '현재 기수',
                    hintText: '비워놔도 돼요',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const Gap(defaultGapM),
                  CustomTextFormField(
                    controller: clubDuesController,
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
                    controller: clubRoomController,
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
                    controller: clubGroupChatLinkController,
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
                    controller: clubGroupChatPasswordController,
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
              if (formKey.currentState?.validate() == true) {
                formKey.currentState?.save();

                try {
                  ref.read(clubStateProvider.notifier).state = ClubState.loading;

                  String clubImage = await _getUpdatedClubImage(s3ImageNotifier, s3ImageState);

                  final updatedClubInfo = await clubRepository.editClubInfo(
                    _updatedClubInfo(clubImage),
                    widget.currentClubInfo.clubId!,
                  );

                  if (context.mounted) {
                    ref.invalidate(clubListProvider);
                    ref.invalidate(s3ImageProvider);
                    Navigator.pop(context, updatedClubInfo);
                  }
                } catch (e) {
                  ref.read(clubStateProvider.notifier).state = ClubState.clubRegistered;
                  GeneralFunctions.toastMessage('동아리 정보 수정에 실패했어요');
                }
              }
            },
            buttonText: '저장',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
            isLoading: clubState == ClubState.loading,
          ),
        ),
      ),
    );
  }

  Future<String> _getUpdatedClubImage(S3ImageNotifier s3ImageNotifier, S3ImageState s3ImageState) async {
    if (s3ImageState.pickedImages.isEmpty) {
      return widget.currentClubInfo.clubImage!;
    } else {
      List<String> imageUrls = await s3ImageNotifier.setImageUrl('1');
      final itemImageUrl = imageUrls.isNotEmpty ? imageUrls[0] : '';
      String itemImageForServer = itemImageUrl.substring(0, itemImageUrl.indexOf('?'));
      await s3ImageNotifier.uploadImagesToS3();
      return itemImageForServer;
    }
  }

  Club _updatedClubInfo(String clubImage) {
    return widget.currentClubInfo.copyWith(
      clubImage: clubImage,
      clubDescription: clubDescriptionController.text,
      clubRoom: clubRoomController.text,
      clubGeneration: clubGenerationController.text,
      clubDues: int.parse(clubDuesController.text.replaceAll(',', '')),
      clubGroupChatLink: clubGroupChatLinkController.text,
      clubGroupChatPassword: clubGroupChatPasswordController.text,
    );
  }
}
