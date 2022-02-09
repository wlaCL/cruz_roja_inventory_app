import 'package:flutter/material.dart';

class RegisterProductForm extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _ambulancia = "";
  String _categoria = "";
  String _tipo = "";
  String _nombre = "";
  String _categoriaNombre = "";
  int _cantidad = 0;

  String get ambulancia => this._ambulancia;
  set ambulancia(String ambulancia) {
    this._ambulancia = ambulancia;
    //notifyListeners();
  }

  String get categoriaNombre => this._categoriaNombre;
  set categoriaNombre(String value) {
    this._categoriaNombre = value;
  }

  String get categoria => this._categoria;
  set categoria(String categoria) {
    this._categoria = categoria;
    //notifyListeners();
  }

  String get tipo => this._tipo;
  set tipo(String tipo) {
    this._tipo = tipo;
    //notifyListeners();
  }

  String get nombre => this._nombre;
  set nombre(String nombre) {
    this._nombre = nombre;
  }

  int get cantidad => this._cantidad;
  set cantidad(int valor) {
    this.cantidad = valor;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
