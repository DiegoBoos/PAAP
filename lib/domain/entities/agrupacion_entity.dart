class AgrupacionEntity {
  AgrupacionEntity(
      {required this.agrupacionId,
      required this.nombre,
      required this.descripcion,
      required this.convocatoriaId});

  String agrupacionId;
  String nombre;
  String descripcion;
  String convocatoriaId;

  factory AgrupacionEntity.fromJson(Map<String, dynamic> json) =>
      AgrupacionEntity(
        agrupacionId: json["AgrupacionId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        convocatoriaId: json["ConvocatoriaId"],
      );

  Map<String, dynamic> toJson() => {
        "AgrupacionId": agrupacionId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "ConvocatoriaId": convocatoriaId
      };
}
