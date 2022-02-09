import 'package:flutter/material.dart';

class InputDecorationForm {
  static InputDecoration formInputDecoration(
      {required String labelText, IconData? icon}) {
    return InputDecoration(
      border: InputBorder.none,
      //hintMaxLines: 1,
      hintText: labelText,
      hintStyle: TextStyle(fontSize: 16.0, color: Colors.black38),
      hintMaxLines: 1,
    );
  }
}
