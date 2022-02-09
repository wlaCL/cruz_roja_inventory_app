import 'package:flutter/material.dart';

class PasswordForm extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String password = "";
  String newPassword = "";
  String confirmPassword = "";
  bool _activeButton = false;

  set activeButton(bool value) {
    this._activeButton = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
