class GrupoEspecialEntity {
  GrupoEspecialEntity({
    required this.grupoEspecialId,
    required this.nombre,
    required this.descripcion,
  });

  String grupoEspecialId;
  String nombre;
  String descripcion;

  factory GrupoEspecialEntity.fromJson(Map<String, dynamic> json) =>
      GrupoEspecialEntity(
        grupoEspecialId: json["GrupoEspecialId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "GrupoEspecialId": grupoEspecialId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
