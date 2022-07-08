import 'package:flutter/material.dart';

final mainColor = Colors.green.shade400;
final secondMainColor = Colors.green.shade50;

final defaultStyleButton = OutlinedButton.styleFrom(
  primary: mainColor,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  side: BorderSide(
    width: 1,
    color: mainColor,
  ),
);

final decorationTextFormFieldLogin = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: mainColor),
  borderRadius: BorderRadius.circular(15),
);
