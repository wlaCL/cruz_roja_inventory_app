import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String message) {
    final snackBar = new SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 16.0),
      ),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
