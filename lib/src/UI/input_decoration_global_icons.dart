import 'package:flutter/material.dart';

class InputDecorationGlobal {
  static InputDecoration formInputDecoration(
      {required String labelText, IconData? icon}) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.red.withOpacity(.7),
      ),
      border: InputBorder.none,
      //hintMaxLines: 1,
      hintText: labelText,
      hintStyle: TextStyle(fontSize: 16.0, color: Colors.black38),
      hintMaxLines: 1,
    );
  }
}
