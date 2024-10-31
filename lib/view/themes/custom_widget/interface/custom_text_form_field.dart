import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final bool readOnly;
  final bool enabled;
  final bool ignore;
  final String? initialValue;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.readOnly = false,
    this.enabled = true,
    this.ignore = false,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.controller,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: context.textTheme.titleSmall,
      textInputAction: textInputAction,
      initialValue: initialValue,
      readOnly: readOnly,
      enabled: enabled,
      obscureText: ignore,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      minLines: 1,
      maxLines: null,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
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
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadiusM),
          borderSide: BorderSide(color: context.colorScheme.surfaceContainer),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
