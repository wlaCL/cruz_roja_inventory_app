import 'package:app_sistema_invetnario/src/shares_preferences/preferences_user.dart';
import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  final prefs = new PreferencesUser();
  final ligthTheme = ThemeData.light().copyWith(
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[300],
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.red.withOpacity(0.7),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(color: Colors.indigo.withOpacity(0.7)),
    textTheme: TextTheme(
        headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        headline6: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black)),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.indigo.withOpacity(0.7),
        contentTextStyle: TextStyle(color: Colors.white),
        actionTextColor: Colors.white),
  );

  final blackTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.indigo,
      scaffoldBackgroundColor: Colors.grey[500],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.red.withOpacity(0.7),
      ),
      appBarTheme: AppBarTheme(color: Color(0xff212121)),
      textTheme: TextTheme(
        headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      dialogTheme:
          DialogTheme(backgroundColor: Colors.grey[500], elevation: 10.0),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.indigo.withOpacity(0.7),
        actionTextColor: Colors.white,
      ),
      canvasColor: Colors.grey[300]);

  bool _darkTheme = false;
  bool _customTheme = false;
  ThemeData _currentTheme = ThemeData.light().copyWith(
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[500],
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.red.withOpacity(0.7),
    ),
    appBarTheme: AppBarTheme(color: Colors.indigo.withOpacity(0.7)),
    textTheme: TextTheme(
        headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        headline6: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black)),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Color(0xff212121),
        contentTextStyle: TextStyle(color: Colors.white),
        actionTextColor: Colors.white),
  );

  ThemeChanger(int theme) {
    switch (theme) {
      case 1:
        _darkTheme = false;
        _customTheme = true;
        _currentTheme = ligthTheme;
        break;

      case 2:
        _darkTheme = true;
        _customTheme = false;
        _currentTheme = blackTheme;
        break;
    }
  }

  bool get darkTheme => this._darkTheme;
  bool get customTheme => this._customTheme;

  ThemeData get currentTheme => this._currentTheme;

  set darkTheme(bool value) {
    if (value) {
      _currentTheme = blackTheme;
      _customTheme = false;
      _darkTheme = value;
      prefs.color = 2;
    } else {
      _currentTheme = ligthTheme;
      _customTheme = true;
      _darkTheme = false;
    }
    notifyListeners();
  }

  set customTheme(bool value) {
    if (value) {
      _currentTheme = ligthTheme;
      _customTheme = value;
      _darkTheme = false;
      prefs.color = 1;
    } else {
      _currentTheme = blackTheme;
      _customTheme = false;
      _darkTheme = true;
    }
    notifyListeners();
  }
}
