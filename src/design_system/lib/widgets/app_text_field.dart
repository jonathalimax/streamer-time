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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: isPassword,
      autocorrect: autoCorrect,
      textCapitalization: textCapitalization,
      enableSuggestions: true,
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        suffix: suffix,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: tintColor ?? Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
