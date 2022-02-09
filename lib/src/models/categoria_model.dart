// To parse this JSON data, do
//
//     final categoria = categoriaFromMap(jsonString);

class Categoria {
  Categoria({
    required this.idCategoria,
    required this.nombre,
    this.descripcion,
  });

  String idCategoria;
  String nombre;
  String? descripcion;

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        idCategoria: json["id_categoria"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "id_categoria": idCategoria,
        "nombre": nombre,
        "descripcion": descripcion,
      };
}
