import 'package:flutter/material.dart';

InputDecoration appInputTextDecoration(
  BuildContext context,
  String placeholder,
) {
  return InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black12,
        width: 1,
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
