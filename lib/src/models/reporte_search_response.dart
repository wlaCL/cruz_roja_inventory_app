// To parse this JSON data, do
//
//     final reporteSearchResponse = reporteSearchResponseFromMap(jsonString);

import 'dart:convert';

class ReporteSearchResponse {
  ReporteSearchResponse({
    required this.ok,
    required this.msg,
    required this.reportes,
  });

  bool ok;
  String msg;
  List<Reporte> reportes;

  factory ReporteSearchResponse.fromJson(String str) =>
      ReporteSearchResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReporteSearchResponse.fromMap(Map<String, dynamic> json) =>
      ReporteSearchResponse(
        ok: json["ok"],
        msg: json["msg"],
        reportes:
            List<Reporte>.from(json["reportes"].map((x) => Reporte.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "msg": msg,
        "reportes": List<dynamic>.from(reportes.map((x) => x.toMap())),
      };
}

class Reporte {
  Reporte({
    required this.idReporte,
    required this.placa,
    required this.idTrabaja,
    required this.fecha,
    required this.novedades,
    required this.base,
    required this.conductor,
    required this.asistente,
    required this.registroProductos,
    required this.trabaja,
  });

  String idReporte;
  String placa;
  String idTrabaja;
  DateTime fecha;
  String novedades;
  String base;
  String conductor;
  String asistente;
  List<RegistroProducto> registroProductos;
  Trabaja trabaja;

  factory Reporte.fromJson(String str) => Reporte.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Reporte.fromMap(Map<String, dynamic> json) => Reporte(
        idReporte: json["id_reporte"],
        placa: json["placa"],
        idTrabaja: json["id_trabaja"],
        fecha: DateTime.parse(json["fecha"]),
        novedades: json["novedades"],
        base: json["base"],
        conductor: json["conductor"],
        asistente: json["asistente"],
        registroProductos: List<RegistroProducto>.from(
            json["registro_productos"].map((x) => RegistroProducto.fromMap(x))),
        trabaja: Trabaja.fromMap(json["trabaja"]),
      );

  Map<String, dynamic> toMap() => {
        "id_reporte": idReporte,
        "placa": placa,
        "id_trabaja": idTrabaja,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "novedades": novedades,
        "base": base,
        "conductor": conductor,
        "asistente": asistente,
        "registro_productos":
            List<dynamic>.from(registroProductos.map((x) => x.toMap())),
        "trabaja": trabaja.toMap(),
      };
}

class RegistroProducto {
  RegistroProducto({
    required this.idRegisproduc,
    required this.idReporte,
    required this.idProducambu,
    required this.cantConsumo,
    required this.carga,
  });

  String idRegisproduc;
  String idReporte;
  String idProducambu;
  int cantConsumo;
  int carga;

  factory RegistroProducto.fromJson(String str) =>
      RegistroProducto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegistroProducto.fromMap(Map<String, dynamic> json) =>
      RegistroProducto(
        idRegisproduc: json["id_regisproduc"],
        idReporte: json["id_reporte"],
        idProducambu: json["id_producambu"],
        cantConsumo: json["cant_consumo"],
        carga: json["carga"],
      );

  Map<String, dynamic> toMap() => {
        "id_regisproduc": idRegisproduc,
        "id_reporte": idReporte,
        "id_producambu": idProducambu,
        "cant_consumo": cantConsumo,
        "carga": carga,
      };
}

class Trabaja {
  Trabaja({
    required this.idTrabaja,
    required this.placa,
    required this.cedula,
    required this.fechaInicio,
    required this.fechaFin,
    required this.rol,
    required this.persona,
  });

  String idTrabaja;
  String placa;
  String cedula;
  DateTime fechaInicio;
  DateTime fechaFin;
  String rol;
  Persona persona;

  factory Trabaja.fromJson(String str) => Trabaja.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Trabaja.fromMap(Map<String, dynamic> json) => Trabaja(
        idTrabaja: json["id_trabaja"],
        placa: json["placa"],
        cedula: json["cedula"],
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
        fechaFin: DateTime.parse(json["fecha_fin"]),
        rol: json["rol"],
        persona: Persona.fromMap(json["persona"]),
      );

  Map<String, dynamic> toMap() => {
        "id_trabaja": idTrabaja,
        "placa": placa,
        "cedula": cedula,
        "fecha_inicio":
            "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
        "fecha_fin":
            "${fechaFin.year.toString().padLeft(4, '0')}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}",
        "rol": rol,
        "persona": persona.toMap(),
      };
}

class Persona {
  Persona({
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.estado,
  });

  String cedula;
  String nombre;
  String apellido;
  bool estado;

  factory Persona.fromJson(String str) => Persona.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Persona.fromMap(Map<String, dynamic> json) => Persona(
        cedula: json["cedula"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "cedula": cedula,
        "nombre": nombre,
        "apellido": apellido,
        "estado": estado,
      };
}
