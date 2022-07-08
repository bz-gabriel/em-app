import 'package:emapp/core/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

TextFormField criarTextFormField({
  required String titulo,
  required TextEditingController controller,
  required keyboardType,
  required validator,
  required icon,
  required obscureText,
}) {
  return TextFormField(
    decoration: InputDecoration(
      label: Text(titulo),
      border: decorationTextFormFieldLogin,
      enabledBorder: decorationTextFormFieldLogin,
      prefixIcon: Icon(icon),
    ),
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    obscureText: obscureText,
  );
}
