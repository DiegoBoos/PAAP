class AgrupacionEntity {
  AgrupacionEntity(
      {required this.agrupacionId,
      required this.nombre,
      required this.descripcion});

  String agrupacionId;
  String nombre;
  String descripcion;

  factory AgrupacionEntity.fromJson(Map<String, dynamic> json) =>
      AgrupacionEntity(
          agrupacionId: json["AgrupacionId"],
          nombre: json["Nombre"],
          descripcion: json["Descripcion"]);

  Map<String, dynamic> toJson() => {
        "AgrupacionId": agrupacionId,
        "Nombre": nombre,
        "Descripcion": descripcion
      };
}
