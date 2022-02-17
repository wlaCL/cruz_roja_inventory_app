import 'dart:convert';
import 'package:app_sistema_invetnario/src/models/models.dart';
import 'package:app_sistema_invetnario/src/models/respuesta_productos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RegisterProductServices extends ChangeNotifier {
  final _baseUrl = '192.168.1.5:3000';
  List<Ambulancia> ambulancias = [];
  List<Categoria> categorias = [];
  String categoryName = "";
  String categoryID = "";
  bool isLoading = false;
  int code = 0;
  final _storage = FlutterSecureStorage();
  String? token;

  Future dataLoad() async {
    try {
      token = await _storage.read(key: 'id_token');
      await this.loadAmbulances();
      await this.loadCategories();
      this.isLoading = true;
    } catch (error) {
      this.isLoading = false;
    }
    return this.isLoading;
  }

  Future loadAmbulances() async {
    final url = Uri.http(_baseUrl, '/api/ambulancias');
    try {
      final resp = await http.get(url, headers: {'x-token': '$token'});
      final respuesta = respuestaAmbulanciaFromMap(resp.body);
      ambulancias = respuesta.ambulancias;
    } catch (error) {}
    return this.ambulancias;
  }

  Future loadCategories() async {
    final url = Uri.http(_baseUrl, '/api/categorias/busqueda');
    try {
      final resp = await http.get(url, headers: {'x-token': '$token'});
      final respuesta = respuestaProductoFromMap(resp.body);
      categorias = respuesta.categorias;
      categorias.forEach((categoria) {
        if (categoria.nombre == "Varios") {
          categoryName = categoria.nombre;
          categoryID = categoria.idCategoria;
        }
      });
    } catch (error) {}
    return this.categorias;
  }

  Future<String> createProduct(String id, String nombre, String placa,
      String cantidad, String tipo) async {
    String message = "";
    final Map<dynamic, String> register = {
      'id': id,
      'nombre': nombre,
      'placa': placa,
      'cantidad': cantidad,
      'tipo': (tipo == "Insumo Médico") ? "Insumo Medico" : tipo
    };

    final url = Uri.http(_baseUrl, '/api/productos/app');

    try {
      final resp = await http.post(url, body: jsonEncode(register), headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-token": '$token'
      });

      final decodeResp = jsonDecode(resp.body);
      if (resp.statusCode == 422) {
        message = decodeResp['errors'][0]["msg"];
      }
      if (resp.statusCode == 200) {
        code = resp.statusCode;
      } else {
        code = 0;
      }

      message = decodeResp["msg"];
    } catch (error) {}
    return message;
  }
}
