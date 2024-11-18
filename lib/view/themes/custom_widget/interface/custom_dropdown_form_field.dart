import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../spacing.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final List<Map<String, String>> items;
  final ValueChanged<String?>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final void Function()? onTap;
  final double? menuMaxHeight;

  const CustomDropdownFormField({
    super.key,
    required this.labelText,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.onTap,
    this.menuMaxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      icon: Icon(
        Symbols.keyboard_arrow_down_rounded,
        color: context.colorScheme.outline,
      ),
      style: context.textTheme.titleSmall,
      elevation: 0,
      menuMaxHeight: menuMaxHeight?.h ?? MediaQuery.of(context).size.height * 0.5,
      dropdownColor: context.colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(0),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPaddingS,
          vertical: defaultPaddingXS,
        ),
        labelText: labelText,
        labelStyle: context.textTheme.titleSmall?.copyWith(
          color: context.colorScheme.outline,
        ),
        errorStyle: context.textTheme.labelLarge?.copyWith(
          color: context.colorScheme.error,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          borderSide: BorderSide(color: context.colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          borderSide: BorderSide(color: context.colorScheme.error),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          borderSide: BorderSide(color: context.colorScheme.surfaceContainer),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          borderSide: BorderSide(color: context.colorScheme.primary),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item['value'],
          child: Text(item['displayText']!, style: context.textTheme.titleSmall),
        );
      }).toList(),
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: onTap,
    );
  }
}
