import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments ?? 'No data';
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificaciones"),
      ),
    );
  }
}
