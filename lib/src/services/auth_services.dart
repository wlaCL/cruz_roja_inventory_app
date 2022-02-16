import 'package:app_sistema_invetnario/src/shares_preferences/preferences_user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {
  //ServerConect server = ServerConect();
  //late final String _baseUrl = server.ip;
  final _baseUrl = '192.168.1.9:3000';
  String? name;
  String? lastName;
  final storage = FlutterSecureStorage();
  final prefs = PreferencesUser();

  Future<String?> loginUser(String cedula, String password) async {
    final Map<String, dynamic> authData = {
      'cedula': cedula,
      'password': password,
      'dispositivo': prefs.dispositivo
    };
    final url = Uri.http(_baseUrl, '/api/auth/app');
    try {
      final resp = await http.post(url, body: jsonEncode(authData), headers: {
        "accept": "application/json",
        "content-type": "application/json"
      });

      final Map<String, dynamic> decodeResp = jsonDecode(resp.body);

      if (decodeResp.containsKey('token')) {
        prefs.name = decodeResp['persona']['nombre'];
        prefs.lastName = decodeResp['persona']['apellido'];
        prefs.cedula = decodeResp["persona"]['cedula'];
        await storage.write(key: 'id_token', value: decodeResp['token']);
        return null;
      } else {
        return decodeResp['msg'];
      }
    } catch (error) {
      return 'Error de conexión con el servidor intente más tarde';
    }
  }

  Future<String> isAuthenticated() async {
    return await storage.read(key: 'id_token') ?? '';
  }
}
