import 'package:flutter/material.dart';

class InputDecorationLogin {
  static InputDecoration authInputDecoration(
      {required IconData? icon, required String hintText}) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.red.withOpacity(.7),
      ),
      border: InputBorder.none,
      //hintMaxLines: 1,
      hintText: hintText,
      hintStyle:
          TextStyle(fontSize: 16.0, color: Colors.black.withOpacity(0.8)),
      hintMaxLines: 1,
    );
  }
}
