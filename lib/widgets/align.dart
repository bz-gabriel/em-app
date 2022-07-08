import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Align criarAlign() {
  return Align(
    alignment: Alignment.bottomRight,
    child: RichText(
      text: const TextSpan(
        style: TextStyle(
          color: Colors.grey,
          fontSize: 10, //_size.width * 0.030,
          fontWeight: FontWeight.w400,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Esqueceu sua senha?',
          ),
        ],
      ),
    ),
  );
}
