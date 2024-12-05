import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club/club_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interface/custom_text_form_field.dart';
import '../themes/spacing.dart';
import 'club_register_info_check_page.dart';

class ClubRegisterOtherInfoFormPage extends ConsumerStatefulWidget {
  const ClubRegisterOtherInfoFormPage({super.key});

  @override
  ConsumerState<ClubRegisterOtherInfoFormPage> createState() => _ClubRegisterOtherInfoFormPageState();
}

class _ClubRegisterOtherInfoFormPageState extends ConsumerState<ClubRegisterOtherInfoFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _generationController;
  late TextEditingController _duesController;
  late TextEditingController _roomController;
  late TextEditingController _groupChatLinkController;
  late TextEditingController _groupChatPasswordController;

  @override
  void initState() {
    super.initState();
    _generationController = TextEditingController();
    _duesController = TextEditingController();
    _roomController = TextEditingController();
    _groupChatLinkController = TextEditingController();
    _groupChatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _generationController.dispose();
    _duesController.dispose();
    _roomController.dispose();
    _groupChatLinkController.dispose();
    _groupChatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clubNotifier = ref.read(clubProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: context.textTheme.bodySmall,
        title: const Text('2 / 4'),
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
                  '동아리의 다른 정보도 필요해요',
                  style: context.textTheme.headlineSmall,
                ),
                const Gap(defaultGapXL * 2),
                Text(
                  '동아리 추가 정보',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  labelText: '현재 기수',
                  hintText: '비워놔도 돼요',
                  keyboardType: TextInputType.number,
                  controller: _generationController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  labelText: '회비',
                  keyboardType: TextInputType.number,
                  controller: _duesController,
                  inputFormatters: [
                    CurrencyTextInputFormatter.currency(
                      symbol: '',
                      locale: 'ko_KR',
                    ),
                    LengthLimitingTextInputFormatter(10),
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
                  labelText: '동아리 방',
                  hintText: '비워놔도 돼요',
                  controller: _roomController,
                ),
                const Gap(defaultGapXL),
                Text(
                  '카카오톡 채팅방',
                  style: context.textTheme.labelLarge,
                ),
                const Gap(defaultGapM),
                CustomTextFormField(
                  labelText: '카카오톡 채팅방 링크',
                  keyboardType: TextInputType.text,
                  controller: _groupChatLinkController,
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
                  controller: _groupChatPasswordController,
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
            if (_formKey.currentState?.validate() != true) return;

            clubNotifier.saveClubOtherInfo(
              _generationController.text,
              int.tryParse(_duesController.text.replaceAll(',', '')) ?? 0,
              _roomController.text,
              _groupChatLinkController.text,
              _groupChatPasswordController.text,
            );

            if (context.mounted) {
              _pushInfoCheckPage(context);
            }
          },
          buttonText: '다음',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
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
