import 'package:flutter/material.dart';

class FinishReportProvider extends ChangeNotifier {
  String _asistente = "";
  String _conductor = "";
  String _base = "";
  String _novedades = "";
  GlobalKey<FormState> formKeyReport = GlobalKey<FormState>();

  String get asistente => _asistente;
  set asistente(String value) {
    _asistente = value;
  }

  String get conductor => _conductor;
  set conductor(String value) {
    _conductor = value;
  }

  String get base => _base;
  set base(String value) {
    _base = value;
  }

  String get novedades => _novedades;
  set novedades(String value) {
    _novedades = value;
  }

  bool isValidForm() {
    return formKeyReport.currentState?.validate() ?? false;
  }
}
