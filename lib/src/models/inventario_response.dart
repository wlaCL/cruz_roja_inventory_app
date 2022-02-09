// To parse this JSON data, do
//
//     final inventarioResponse = inventarioResponseFromMap(jsonString);

import 'dart:convert';

class InventarioResponse {
  InventarioResponse({
    required this.ok,
    required this.msg,
    required this.data,
  });

  bool ok;
  String msg;
  List<Products> data;

  factory InventarioResponse.fromJson(String str) =>
      InventarioResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InventarioResponse.fromMap(Map<String, dynamic> json) =>
      InventarioResponse(
        ok: json["ok"],
        msg: json["msg"],
        data: List<Products>.from(json["data"].map((x) => Products.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Products {
  Products({
    required this.idTipoprod,
    required this.idCategoria,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    required this.canMinima,
    required this.tipo,
    required this.categorium,
    required this.productos,
  });

  String idTipoprod;
  String idCategoria;
  String nombre;
  String descripcion;
  bool estado;
  int canMinima;
  String tipo;
  Categorium categorium;
  List<Producto> productos;

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        idTipoprod: json["id_tipoprod"],
        idCategoria: json["id_categoria"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        canMinima: json["can_minima"],
        tipo: json["tipo"],
        categorium: Categorium.fromMap(json["categorium"]),
        productos: List<Producto>.from(
            json["productos"].map((x) => Producto.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id_tipoprod": idTipoprod,
        "id_categoria": idCategoria,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
        "can_minima": canMinima,
        "tipo": tipo,
        "categorium": categorium.toMap(),
        "productos": List<dynamic>.from(productos.map((x) => x.toMap())),
      };
}

class Categorium {
  Categorium({
    required this.nombre,
  });

  String nombre;

  factory Categorium.fromJson(String str) =>
      Categorium.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categorium.fromMap(Map<String, dynamic> json) => Categorium(
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
      };
}

class Producto {
  Producto({
    required this.idProducto,
    required this.fechaCaducidad,
    required this.cantidad,
    required this.estado,
    required this.productoAmbulancia,
  });

  String idProducto;
  dynamic fechaCaducidad;
  int cantidad;
  bool estado;
  List<ProductoAmbulancia> productoAmbulancia;

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        idProducto: json["id_producto"],
        fechaCaducidad: json["fecha_caducidad"],
        cantidad: json["cantidad"],
        estado: json["estado"],
        productoAmbulancia: List<ProductoAmbulancia>.from(
            json["producto_ambulancia"]
                .map((x) => ProductoAmbulancia.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id_producto": idProducto,
        "fecha_caducidad": fechaCaducidad,
        "cantidad": cantidad,
        "estado": estado,
        "producto_ambulancia":
            List<dynamic>.from(productoAmbulancia.map((x) => x.toMap())),
      };
}

class ProductoAmbulancia {
  ProductoAmbulancia({
    required this.idProducambu,
    required this.idProducto,
    required this.placa,
    required this.cantAmbulancia,
    required this.estado,
    required this.stock,
  });

  String idProducambu;
  String idProducto;
  String placa;
  int cantAmbulancia;
  bool estado;
  int stock;

  factory ProductoAmbulancia.fromJson(String str) =>
      ProductoAmbulancia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductoAmbulancia.fromMap(Map<String, dynamic> json) =>
      ProductoAmbulancia(
        idProducambu: json["id_producambu"],
        idProducto: json["id_producto"],
        placa: json["placa"],
        cantAmbulancia: json["cant_ambulancia"],
        estado: json["estado"],
        stock: json["stock"],
      );

  Map<String, dynamic> toMap() => {
        "id_producambu": idProducambu,
        "id_producto": idProducto,
        "placa": placa,
        "cant_ambulancia": cantAmbulancia,
        "estado": estado,
        "stock": stock,
      };
}
