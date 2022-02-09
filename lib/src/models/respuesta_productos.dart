// To parse this JSON data, do
//
//     final respuesta = respuestaFromMap(jsonString);

import 'dart:convert';

import 'categoria_model.dart';

RespuestaProducto respuestaProductoFromMap(String str) =>
    RespuestaProducto.fromMap(json.decode(str));

String respuestaProductoToMap(RespuestaProducto data) =>
    json.encode(data.toMap());

class RespuestaProducto {
  RespuestaProducto({
    required this.msg,
    required this.categorias,
    required this.registros,
  });

  String msg;
  List<Categoria> categorias;
  int registros;

  factory RespuestaProducto.fromMap(Map<String, dynamic> json) =>
      RespuestaProducto(
        msg: json["msg"],
        categorias: List<Categoria>.from(
            json["categorias"].map((x) => Categoria.fromMap(x))),
        registros: json["registros"],
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
        "categorias": List<dynamic>.from(categorias.map((x) => x.toMap())),
        "registros": registros,
      };
}
