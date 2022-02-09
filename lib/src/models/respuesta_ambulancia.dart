// To parse this JSON data, do
//
//     final respuestaAmbulancia = respuestaAmbulanciaFromMap(jsonString);

import 'dart:convert';

import 'package:app_sistema_invetnario/src/models/models.dart';

RespuestaAmbulancia respuestaAmbulanciaFromMap(String str) =>
    RespuestaAmbulancia.fromMap(json.decode(str));

String respuestaAmbulanciaToMap(RespuestaAmbulancia data) =>
    json.encode(data.toMap());

class RespuestaAmbulancia {
  RespuestaAmbulancia({
    required this.ok,
    required this.msg,
    required this.ambulancias,
  });

  bool ok;
  String msg;
  List<Ambulancia> ambulancias;

  factory RespuestaAmbulancia.fromMap(Map<String, dynamic> json) =>
      RespuestaAmbulancia(
        ok: json["ok"],
        msg: json["msg"],
        ambulancias: List<Ambulancia>.from(
            json["ambulancias"].map((x) => Ambulancia.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "msg": msg,
        "ambulancias": List<dynamic>.from(ambulancias.map((x) => x.toMap())),
      };
}
