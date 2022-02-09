import 'package:flutter/material.dart';

class AuthFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String cedula = "";
  String password = "";
  bool _isloading = false;
  bool get isLoading => this._isloading;

  set isLoading(bool value) {
    this._isloading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
