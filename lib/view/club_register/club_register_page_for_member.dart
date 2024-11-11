import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_register/club_register_caution_page_.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../club_info/components/club_info_bottom_sheet.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/interaction/custom_pop_scope.dart';
import '../themes/spacing.dart';

class ClubRegisterPageForMember extends StatelessWidget {
  const ClubRegisterPageForMember({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPopScope(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet(
                useSafeArea: true,
                context: context,
                builder: (context) => const ClubInfoBottomSheet(),
              ),
              icon: const Icon(Symbols.list_rounded),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: defaultPaddingM * 3,
              left: defaultPaddingM,
              right: defaultPaddingM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '동아리 임원진만 이용할 수 있어요',
                  style: context.textTheme.headlineLarge,
                ),
                Text(
                  '동아리를 새로 등록해 보세요!',
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomButton(
            onTap: () => _pushCautionPage(context),
            buttonText: '등록하기',
            buttonColor: Theme.of(context).colorScheme.primary,
            buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }

  void _pushCautionPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ClubRegisterCautionPage(),
      ),
    );
  }
}
