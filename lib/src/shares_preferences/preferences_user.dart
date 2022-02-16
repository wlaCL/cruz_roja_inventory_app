import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUser {
  static final PreferencesUser _instancia = new PreferencesUser._internal();

  factory PreferencesUser() {
    return _instancia;
  }

  PreferencesUser._internal();
  late SharedPreferences _prefs;

  initPref() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //GET y SET del Genero
  int get color {
    return _prefs.getInt('color') ?? 1;
  }

  set name(String value) {
    this._prefs.setString('name', value);
  }

  set lastName(String value) {
    this._prefs.setString('lastName', value);
  }

  set cedula(String value) {
    this._prefs.setString('cedula', value);
  }

  String get cedula {
    return _prefs.getString('cedula') ?? '';
  }

  String get name {
    return _prefs.getString('name') ?? '';
  }

  String get lastName {
    return _prefs.getString('lastName') ?? '';
  }

  set color(int color) {
    this._prefs.setInt('color', color);
  }

  String get dispositivo {
    return _prefs.getString('dispositivo') ?? '';
  }

  set dispositivo(String dispositivo) {
    _prefs.setString('dispositivo', dispositivo);
  }
}
