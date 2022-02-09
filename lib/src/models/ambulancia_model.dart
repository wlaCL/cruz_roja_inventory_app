class Ambulancia {
  Ambulancia({
    required this.numVehiculo,
    required this.descripcion,
    required this.placa,
    required this.estado,
  });

  String numVehiculo;
  String descripcion;
  String placa;
  bool estado;

  factory Ambulancia.fromMap(Map<String, dynamic> json) => Ambulancia(
        numVehiculo: json["num_vehiculo"],
        descripcion: json["descripcion"],
        placa: json["placa"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "num_vehiculo": numVehiculo,
        "descripcion": descripcion,
        "placa": placa,
        "estado": estado,
      };
}
