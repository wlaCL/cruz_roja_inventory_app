import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SecurityService extends ChangeNotifier {
  final String _baseUrl = '192.168.1.5:3000';
  int? code;
  final storage = FlutterSecureStorage();
  Future<String> changePassword(password, newpassword) async {
    final token = await storage.read(key: 'id_token');
    final Map<String, dynamic> service = {
      'contrasena': password,
      'nuevacontrasena': newpassword
    };
    final url = Uri.http(_baseUrl, '/api/auth/change/pwuser');

    try {
      final resp = await http.put(url, body: jsonEncode(service), headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-token": '$token'
      });
      final Map<String, dynamic> decodeResp = jsonDecode(resp.body);

      if (resp.statusCode == 200) {
        code = resp.statusCode;
        return decodeResp["msg"];
      }
      return decodeResp["msg"];
    } catch (error) {
      return "Intenta realizar la operación mas tarde";
    }
  }
}
