//SHA1: B4:F1:7D:16:FA:6C:66:FA:13:0F:E2:EE:FE:DB:98:55:91:B7:9F:49

import 'dart:async';

import 'package:app_sistema_invetnario/src/shares_preferences/preferences_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? dispositivo;
  static StreamController<String> _messageStreamController =
      StreamController.broadcast();
  static Stream<String> get messageStream => _messageStreamController.stream;
  static final prefs = PreferencesUser();

  static Future _backgroundHandler(RemoteMessage message) async {
    //print('onBackground Handler ${message.messageId}');
    _messageStreamController.add(message.notification?.body ?? 'No body');
    //_messageStreamController.add(message.data['paramedico'] ?? 'No hay datos');
    //_messageStreamController.add(message.data['cedula'] ?? 'No hay datos');
    //_messageStreamController.add(message.data['ambulancia'] ?? 'No hay datos');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessage Handler ${message.messageId}');
    //_messageStreamController.add(message.data);
    _messageStreamController.add(message.notification?.body ?? 'No body');
    //_messageStreamController.add(message.notification?.title ?? 'No title');
    //_messageStreamController.add(message.data['fecha'] ?? 'No hay datos');
    //_messageStreamController.add(message.data['paramedico'] ?? 'No hay datos');
    //_messageStreamController.add(message.data['cedula'] ?? 'No hay datos');
    //_messageStreamController.add(message.data['ambulancia'] ?? 'No hay datos');
  }

  static Future _onMessageOpenAdd(RemoteMessage message) async {
    //print('onMessage Handler ${message.messageId}');
    // _messageStreamController.add(message.data);
    _messageStreamController.add(message.notification?.body ?? 'No body');
    //_messageStreamController.add(message.notification?.title ?? 'No title');
    //_messageStreamController.add(message.data['fecha'] ?? 'No hay datos');
    //_messageStreamController.add(message.data['paramedico'] ?? 'No hay datos');
    //_messageStreamController.add(message.data['cedula'] ?? 'No hay datos');
    //_messageStreamController.add(message.data['ambulancia'] ?? 'No hay datos');
  }

  static Future initalizeApp() async {
    //push notification
    await Firebase.initializeApp();
    dispositivo = await FirebaseMessaging.instance.getToken();
    prefs.dispositivo = dispositivo!;

    //handlersnull
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenAdd);

    //local notification
  }

  static closeStreams() {
    _messageStreamController.close();
  }
}
