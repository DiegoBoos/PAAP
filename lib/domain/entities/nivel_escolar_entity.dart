class NivelEscolarEntity {
  NivelEscolarEntity({
    required this.nivelEscolarId,
    required this.nombre,
    required this.descripcion,
  });

  String nivelEscolarId;
  String nombre;
  String descripcion;

  factory NivelEscolarEntity.fromJson(Map<String, dynamic> json) =>
      NivelEscolarEntity(
        nivelEscolarId: json["NivelEscolarId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "NivelEscolarId": nivelEscolarId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
