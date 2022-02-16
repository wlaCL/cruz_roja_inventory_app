import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReportService extends ChangeNotifier {
  final _baseUrl = "192.168.1.9:3000";
  final storage = const FlutterSecureStorage();
  String? token;
  String? reporte;
  String message = "";
  int? code;
  bool isReport = false;
  bool _isFinish = false;

  set isFinish(bool value) {
    _isFinish = value;
    notifyListeners();
  }

  bool get isFinish => _isFinish;

  Future<String> isReporte(String fecha, String placa) async {
    final Map<String, dynamic> data = {'placa': placa, 'fecha': fecha};
    final url = Uri.http(_baseUrl, '/api/reporte/exist');

    try {
      token = await storage.read(key: 'id_token');
      final resp = await http.post(url, body: jsonEncode(data), headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-token": '$token'
      });

      final Map<String, dynamic> decodeReps = jsonDecode(resp.body);

      if (resp.statusCode == 200) {
        reporte = decodeReps["reporte"]["id_reporte"];
        message = decodeReps["msg"];
      }

      if (resp.statusCode == 400) {
        reporte = decodeReps["reporte"]["id_reporte"];
        message = decodeReps["msg"];
      }

      if (resp.statusCode == 422) {
        message = decodeReps["errors"][0]["msg"];
      }
      message = decodeReps["msg"];
      code = resp.statusCode;
    } catch (error) {
      message = "No existe conexión a internet";
    }
    return message;
  }

  Future<String> createReport(String placa, String fecha) async {
    final Map<String, dynamic> data = {'placa': placa, 'fecha': fecha};
    final url = Uri.http(_baseUrl, '/api/reporte');

    try {
      token = await storage.read(key: 'id_token');
      final resp = await http.post(url, body: jsonEncode(data), headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-token": '$token'
      });

      final Map<String, dynamic> decodeReps = jsonDecode(resp.body);

      if (resp.statusCode == 422) {
        message = decodeReps["errors"][0]["msg"];
      }
      if (resp.statusCode == 200) {
        code = 200;
      }

      message = decodeReps["msg"];
    } catch (error) {
      message = "No existe conexión a internet";
    }
    return message;
  }

  Future<String> uptateReport(
      String asistente, String conductor, String base, String novedades) async {
    try {
      token = await storage.read(key: 'id_token');
      final url = Uri.http(_baseUrl, '/api/reporte');

      final Map<String, dynamic> dataReport = {
        'id': reporte,
        'asistente': asistente,
        'conductor': conductor,
        'base': base,
        'novedades': novedades
      };

      final response =
          await http.put(url, body: jsonEncode(dataReport), headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
        'x-token': '$token'
      });

      final respuesta = jsonDecode(response.body);

      if (response.statusCode == 422) {
        message = respuesta["errors"][0]["msg"];
      }

      if (response.statusCode == 200) {
        code = 200;
      }
      message = respuesta["msg"];
    } catch (error) {
      message = "Servicio no disponible por el momento";
    }
    return message;
  }
}
