import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/group/components/group_controller.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/group/components/group_state.dart';
import 'package:woohakdong/view_model/group/components/group_state_provider.dart';

import '../../service/general/general_functions.dart';
import '../../view_model/group/group_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interface/custom_counter_text_form_field.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';

class GroupAddPage extends ConsumerStatefulWidget {
  const GroupAddPage({super.key});

  @override
  ConsumerState createState() => _GroupAddPageState();
}

class _GroupAddPageState extends ConsumerState<GroupAddPage> {
  final _formKey = GlobalKey<FormState>();
  late final GroupController _groupController;

  @override
  void initState() {
    super.initState();
    _groupController = GroupController();
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
          title: const Text('모임 등록'),
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
                  CustomTextFormField(
                    labelText: '모임비',
                    hintText: '없으면 0을 입력해 주세요',
                    keyboardType: TextInputType.number,
                    controller: _groupController.amount,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '모임비 입력해 주세요';
                      }
                      return null;
                    },
                    inputFormatters: [
                      CurrencyTextInputFormatter.currency(
                        symbol: '',
                        locale: 'ko_KR',
                      ),
                      LengthLimitingTextInputFormatter(10),
                    ],
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
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
                    textInputAction: TextInputAction.done,
                    controller: _groupController.chatPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '카카오톡 채팅방 비밀번호를 입력해 주세요';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () async {
              if (_formKey.currentState?.validate() == true) {
                try {
                  await groupNotifier.addGroup(
                    _groupController.name.text,
                    _groupController.description.text,
                    int.tryParse(_groupController.amount.text.replaceAll(',', '')) ?? 0,
                    _groupController.chatLink.text,
                    _groupController.chatPassword.text,
                    int.parse(_groupController.memberLimit.text),
                  );

                  if (context.mounted) {
                    Navigator.pop(context);

                    GeneralFunctions.toastMessage('모임이 등록되었어요');
                  }
                } catch (e) {
                  await GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
                }
              }
            },
            buttonText: '등록',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
            isLoading: groupState == GroupState.adding,
          ),
        ),
      ),
    );
  }
}
