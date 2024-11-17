import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class ClubDuesInOutTypeListTile extends StatelessWidget {
  final String title;
  final String type;
  final String selectedType;
  final Function(String) onTap;

  const ClubDuesInOutTypeListTile({
    super.key,
    required this.title,
    required this.type,
    required this.selectedType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(type);
        Navigator.pop(context);
        GeneralFunctions.toastMessage('${_getFilterText(type)} 내역이에요');
      },
      highlightColor: context.colorScheme.surfaceContainer,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPaddingM,
          vertical: defaultPaddingM / 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.bodyLarge,
            ),
            if (selectedType == type)
              Icon(
                size: 20,
                Symbols.check_circle_rounded,
                color: context.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  String _getFilterText(String? type) {
    switch (type) {
      case 'DEPOSIT':
        return '입금';
      case 'WITHDRAW':
        return '출금';
      default:
        return '전체';
    }
  }
}
