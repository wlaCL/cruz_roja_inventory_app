import 'dart:convert';

import 'package:app_sistema_invetnario/src/models/inventario_response.dart';
import 'package:app_sistema_invetnario/src/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Inventario extends ChangeNotifier {
  final _baseUrl = '192.168.1.5:3000';
  final storage = FlutterSecureStorage();
  String? token;
  List<Products> productos = [];
  int code = 0;
  String? message;
  bool? ok;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 100),
  );

  String? _placa;

  set placa(String value) {
    this._placa = value;
  }

  String get placa => _placa!;

  final StreamController<dynamic> _suggestionStreamContoller =
      new StreamController.broadcast();
  Stream<dynamic> get suggestionStream =>
      this._suggestionStreamContoller.stream;

  Future<dynamic> searchProducts(String query) async {
    try {
      productos.clear();
      token = await storage.read(key: 'id_token');
      final url = Uri.http(_baseUrl,
          '/api/productos_ambulancias/search/$query/$_placa'); //arreglar conexion

      final response = await http.get(url, headers: {'x-token': '$token'});
      if (response.statusCode == 200) {
        final searchResponse = InventarioResponse.fromJson(response.body);
        productos = searchResponse.data;

        code = response.statusCode;
      }
    } catch (error) {}
    return '';
  }

  void getSuggestionsByQuery(String searchTerm, String placa) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.searchProducts(value);
      this._suggestionStreamContoller.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 25), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  Future createRegister({id, cantidad, reporte, carga}) async {
    String? message;
    try {
      token = await storage.read(key: 'id_token');

      final Map<String, dynamic> registro = {
        'id': id,
        'cant_consumo': cantidad,
        'id_reporte': reporte,
        'carga': carga
      };

      final _url = Uri.http(_baseUrl, '/api/inventario');
      final response =
          await http.post(_url, body: jsonEncode(registro), headers: {
        "accept": "application/json",
        "content-type": "application/json",
        'x-token': '$token'
      });
      final respuesta = jsonDecode(response.body);

      if (response.statusCode == 422) {
        message = respuesta["errors"][0]["msg"];
      }
      print(respuesta);
      code = response.statusCode;
      message = respuesta["msg"];
    } catch (error) {}
    return message;
  }

  Future searchScan(String id, String placa) async {
    productos.clear();
    try {
      final url =
          Uri.http(_baseUrl, '/api/productos_ambulancias/scan/$id/$placa');
      token = await storage.read(key: 'id_token');
      final response = await http.get(url, headers: {'x-token': '$token'});
      final Map<String, dynamic> responseDecode = jsonDecode(response.body);

      final searchResponse = InventarioResponse.fromJson(response.body);

      productos = searchResponse.data;
      if (response.statusCode == 422) {
        message = responseDecode["errors"][0]["msg"];
      }
      if (response.statusCode == 200) {
        ok:
        true;
      } else {
        ok:
        false;
      }

      print(message);
    } catch (error) {
      print(error);
    }
    return productos;
  }
}
