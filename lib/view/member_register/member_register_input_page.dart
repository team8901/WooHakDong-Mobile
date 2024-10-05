import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/member_register/components/member_register_button.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/member/member_provider.dart';
import '../../view_model/user/user_info_provider.dart';
import '../themes/spacing.dart';
import 'member_register_info_check_page.dart';

class MemberRegisterInputPage extends ConsumerWidget {
  const MemberRegisterInputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final userInfo = ref.watch(userInfoProvider);
    final memberNotifier = ref.read(memberProvider.notifier);
    final member = ref.read(memberProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: defaultPaddingM,
            left: defaultPaddingM,
            right: defaultPaddingM,
            bottom: defaultPaddingM,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '회장님의 정보를 알려주세요',
                        style: context.textTheme.titleLarge,
                      ),
                      const Gap(defaultGapXL * 2),
                      Form(
                        key: formKey,
                        child: userInfo.when(
                          data: (userModel) {
                            member.email = userModel.email!;
                            member.name = userModel.name!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  style: context.textTheme.titleSmall,
                                  textInputAction: TextInputAction.next,
                                  initialValue: userModel.email,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: '이메일 주소',
                                    labelStyle:
                                        context.textTheme.titleSmall?.copyWith(color: context.colorScheme.outline),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.outline)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.primary)),
                                  ),
                                ),
                                const Gap(defaultGapXL),
                                TextFormField(
                                  style: context.textTheme.titleSmall,
                                  textInputAction: TextInputAction.next,
                                  initialValue: userModel.name,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: '이름',
                                    labelStyle:
                                        context.textTheme.titleSmall?.copyWith(color: context.colorScheme.outline),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.outline)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.primary)),
                                  ),
                                ),
                                const Gap(defaultGapXL),
                                TextFormField(
                                  style: context.textTheme.titleSmall,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: '성별',
                                    labelStyle:
                                        context.textTheme.titleSmall?.copyWith(color: context.colorScheme.outline),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.outline)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.primary)),
                                  ),
                                  onSaved: (value) => member.gender = value ?? '',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '성별을 입력해 주세요';
                                    }
                                    return null;
                                  },
                                ),
                                const Gap(defaultGapXL),
                                TextFormField(
                                  style: context.textTheme.titleSmall,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: '학과',
                                    labelStyle:
                                        context.textTheme.titleSmall?.copyWith(color: context.colorScheme.outline),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.outline)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.primary)),
                                  ),
                                  onSaved: (value) => member.department = value ?? '',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '학과를 입력해 주세요';
                                    }
                                    return null;
                                  },
                                ),
                                const Gap(defaultGapXL),
                                TextFormField(
                                  style: context.textTheme.titleSmall,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: '학번',
                                    labelStyle:
                                        context.textTheme.titleSmall?.copyWith(color: context.colorScheme.outline),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.outline)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.primary)),
                                  ),
                                  onSaved: (value) => member.studentId = value ?? '',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '학번을 입력해 주세요';
                                    }
                                    return null;
                                  },
                                ),
                                const Gap(defaultGapXL),
                                TextFormField(
                                  style: context.textTheme.titleSmall,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: '휴대폰 번호',
                                    labelStyle:
                                        context.textTheme.titleSmall?.copyWith(color: context.colorScheme.outline),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.outline)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: context.colorScheme.primary)),
                                  ),
                                  onSaved: (value) => member.phoneNumber = value ?? '',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '휴대폰 번호를 입력해 주세요';
                                    }
                                    return null;
                                  },
                                ),
                                const Gap(defaultGapXL),
                              ],
                            );
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (error, stackTrace) => Text('Error: $error'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MemberRegisterButton(
                onTap: () {
                  if (formKey.currentState?.validate() == true) {
                    formKey.currentState?.save();
                    memberNotifier.updateMember(member);

                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const MemberRegisterInfoCheckPage(),
                      ),
                    );
                  }
                },
                buttonText: '다음',
                buttonColor: Theme.of(context).colorScheme.primary,
                buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
