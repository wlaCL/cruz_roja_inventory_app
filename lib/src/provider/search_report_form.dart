import 'package:flutter/material.dart';

class SearchFormReport extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _placa = "";
  String _fecha = "";

  bool isValid() {
    return formKey.currentState?.validate() ?? false;
  }

  String get placa => this._placa;
  set placa(String value) {
    this._placa = value;
  }

  String get fecha => this._fecha;
  set fecha(String value) {
    this._fecha = value;
  }
}
