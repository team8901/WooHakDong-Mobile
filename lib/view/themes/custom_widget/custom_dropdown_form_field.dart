import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const CustomDropdownFormField({
    super.key,
    required this.labelText,
    required this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      style: context.textTheme.titleSmall,
      elevation: 0,
      dropdownColor: context.colorScheme.surfaceContainer,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: context.textTheme.titleSmall?.copyWith(
          color: context.colorScheme.outline,
        ),
        errorStyle: context.textTheme.labelLarge?.copyWith(
          color: context.colorScheme.error,
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.error),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.surfaceContainer),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.primary),
        ),
      ),
      items: items
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(value, style: context.textTheme.titleSmall),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
