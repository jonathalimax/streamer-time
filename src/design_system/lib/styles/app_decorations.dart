import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

InputDecoration appInputTextDecoration(
  BuildContext context,
  String placeholder,
) {
  return InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade200
            : kcLightPurple.withOpacity(0.5),
        width: 2,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 2,
      ),
    ),
    hintText: placeholder,
    hintStyle: TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
}
