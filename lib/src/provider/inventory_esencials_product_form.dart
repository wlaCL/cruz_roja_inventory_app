import 'package:flutter/material.dart';

class InventoryEsencialsForm extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _cantidad = "";
  String _carga = "";

  String get cantidad => _cantidad;

  String get carga => _carga;

  set cantidad(String value) {
    this._cantidad = value;
  }

  set carga(String value) {
    this._carga = value;
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
