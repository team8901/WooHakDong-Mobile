import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/view/setting/components/setting_info_box.dart';
import 'package:woohakdong/view/setting/components/setting_service_box.dart';

import '../themes/spacing.dart';
import 'components/setting_app_box.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingAppBox(),
              Gap(defaultGapXL),
              SettingInfoBox(),
              Gap(defaultGapXL),
              SettingServiceBox(),
            ],
          ),
        ),
      ),
    );
  }
}
