import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../spacing.dart';

class CustomCounterTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final bool readOnly;
  final String? initialValue;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final int minLines;
  final int maxLength;

  const CustomCounterTextFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.controller,
    required this.minLines,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: context.textTheme.titleSmall,
      textInputAction: textInputAction,
      initialValue: initialValue,
      readOnly: readOnly,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      minLines: minLines,
      maxLines: null,
      maxLength: maxLength,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPaddingS,
          vertical: defaultPaddingXS,
        ),
        labelText: labelText,
        labelStyle: context.textTheme.titleSmall?.copyWith(
          color: context.colorScheme.outline,
        ),
        hintText: hintText,
        hintStyle: context.textTheme.titleSmall?.copyWith(
          color: context.colorScheme.outline,
        ),
        counterStyle: context.textTheme.labelLarge?.copyWith(
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
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
