import 'package:design_system/styles/app_decorations.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String placeholder;
  final Color? tintColor;
  final Widget? suffix;
  final bool isPassword;
  final bool autoCorrect;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const AppTextField({
    Key? key,
    required this.placeholder,
    this.tintColor,
    this.suffix,
    this.isPassword = false,
    this.autoCorrect = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.textInputAction,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: isPassword,
      autocorrect: autoCorrect,
      textCapitalization: textCapitalization,
      enableSuggestions: true,
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: appInputTextDecoration(context, placeholder),
    );
  }
}
