import 'package:flutter/material.dart';

class FormSearchPdf extends ChangeNotifier {
  String _placa = "";
  String _fecha = "";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String get fecha => _fecha;

  set fecha(String fecha) {
    _fecha = fecha;
    notifyListeners();
  }

  String get placa => _placa;
  set placa(String placa) {
    _placa = placa;
    notifyListeners();
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
