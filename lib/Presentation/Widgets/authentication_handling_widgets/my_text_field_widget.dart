import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/consts/outline_input_border.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.colorScheme,
    this.prefixIcon,
    this.suffix,
    this.validator,
    this.obscure = false,
    required this.label,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.formatters,
    this.textDirection = TextDirection.ltr,
  });

  final TextEditingController controller;
  final ColorScheme colorScheme;
  final Widget? prefixIcon, suffix;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged, onSubmitted;
  final bool obscure, enabled;
  final String label;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int? maxLines;
  final List<TextInputFormatter>? formatters;
  final TextDirection textDirection;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatters,
      maxLines: maxLines,
      enabled: enabled,
      onFieldSubmitted: onSubmitted,
      textDirection: textDirection,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      textInputAction: inputAction,
      obscureText: obscure,
      obscuringCharacter: '•',
      keyboardType: inputType,
      decoration: InputDecoration(
        errorBorder: outlineInputBorder(colorScheme.error),
        enabledBorder: outlineInputBorder(colorScheme.primaryContainer),
        disabledBorder: outlineInputBorder(Colors.grey),
        focusedErrorBorder: outlineInputBorder(colorScheme.error),
        focusedBorder: outlineInputBorder(colorScheme.primary),
        suffixIcon: suffix,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.white,
        alignLabelWithHint: true,
        labelText: label,
        prefixIconColor: colorScheme.primary,
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension PhoneValidaton on String {
  bool isPhoneValid() {
    return RegExp(r'^(\+2)?01[0125]\d{8}$').hasMatch(this);
  }
}
