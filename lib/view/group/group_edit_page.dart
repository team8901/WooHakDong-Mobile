import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/group/group.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/group/components/group_state.dart';
import '../../view_model/group/components/group_state_provider.dart';
import '../../view_model/group/group_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interface/custom_counter_text_form_field.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'components/group_controller.dart';

class GroupEditPage extends ConsumerStatefulWidget {
  final Group groupInfo;

  const GroupEditPage({
    super.key,
    required this.groupInfo,
  });

  @override
  ConsumerState createState() => _GroupEditPageState();
}

class _GroupEditPageState extends ConsumerState<GroupEditPage> {
  final _formKey = GlobalKey<FormState>();
  late final GroupController _groupController;
  bool _groupIsActivated = false;

  @override
  void initState() {
    super.initState();
    _groupController = GroupController();
    _groupController.updateFromGroupInfo(widget.groupInfo);
    _groupIsActivated = widget.groupInfo.groupIsActivated!;
  }

  @override
  void dispose() {
    super.dispose();
    _groupController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupState = ref.watch(groupStateProvider);
    final groupNotifier = ref.read(groupProvider.notifier);

    return PopScope(
      canPop: groupState != GroupState.adding,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('모임 수정'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPaddingM),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '모임 정보',
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const Gap(defaultGapM),
                  CustomTextFormField(
                    labelText: '제목',
                    controller: _groupController.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '모임 제목을 입력해 주세요';
                      }
                      return null;
                    },
                  ),
                  const Gap(defaultGapM),
                  CustomCounterTextFormField(
                    labelText: '설명',
                    hintText: '100자 이내로 입력해 주세요',
                    minLines: 2,
                    maxLength: 100,
                    controller: _groupController.description,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '모임 설명을 입력해 주세요';
                      }
                      return null;
                    },
                  ),
                  const Gap(defaultGapM),
                  GestureDetector(
                    onTap: () => GeneralFunctions.toastMessage('모임비는 수정할 수 없어요'),
                    child: CustomTextFormField(
                      labelText: '모임비',
                      initialValue: widget.groupInfo.groupAmount.toString(),
                      readOnly: true,
                      enabled: false,
                    ),
                  ),
                  const Gap(defaultGapM),
                  CustomTextFormField(
                    labelText: '모임 최대 인원',
                    keyboardType: TextInputType.number,
                    controller: _groupController.memberLimit,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '최대 인원을 입력해 주세요';
                      }
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const Gap(defaultGapXL),
                  Text(
                    '모임 추가 정보',
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const Gap(defaultGapM),
                  CustomTextFormField(
                    labelText: '카카오톡 채팅방 링크',
                    controller: _groupController.chatLink,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '카카오톡 채팅방 링크를 입력해 주세요';
                      }
                      return null;
                    },
                  ),
                  const Gap(defaultGapM),
                  CustomTextFormField(
                    labelText: '카카오톡 채팅방 비밀번호',
                    hintText: '비워놔도 돼요',
                    controller: _groupController.chatPassword,
                    textInputAction: TextInputAction.done,
                  ),
                  const Gap(defaultGapM),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: context.colorScheme.surfaceContainer),
                      borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                    ),
                    padding: const EdgeInsets.only(
                      left: defaultPaddingS,
                      right: defaultPaddingS / 4,
                      top: defaultPaddingS / 4,
                      bottom: defaultPaddingS / 4,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('모임 모집 여부', style: context.textTheme.titleSmall),
                        ),
                        Transform.scale(
                          scale: 0.75,
                          child: CupertinoSwitch(
                            value: _groupIsActivated,
                            onChanged: (value) => setState(() => _groupIsActivated = !_groupIsActivated),
                            trackColor: context.colorScheme.surfaceContainer,
                            activeColor: context.colorScheme.primary,
                            thumbColor: context.colorScheme.surfaceDim,
                          ),
                        ),
                      ],
                    ),
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

              try {
                await groupNotifier.updateGroup(
                  widget.groupInfo.groupId!,
                  _groupController.name.text,
                  _groupController.description.text,
                  _groupController.chatLink.text,
                  _groupController.chatPassword.text,
                  _groupIsActivated,
                  int.parse(_groupController.memberLimit.text),
                );

                if (context.mounted) {
                  GeneralFunctions.toastMessage('모임이 수정되었어요');
                  Navigator.pop(context);
                }
              } catch (e) {
                await GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
              }
            },
            buttonText: '저장',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
            isLoading: groupState == GroupState.adding,
          ),
        ),
      ),
    );
  }
}
