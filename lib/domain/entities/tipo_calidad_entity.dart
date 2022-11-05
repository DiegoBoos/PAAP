class TipoCalidadEntity {
  TipoCalidadEntity({
    required this.tipoCalidadId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoCalidadId;
  String nombre;
  String descripcion;

  factory TipoCalidadEntity.fromJson(Map<String, dynamic> json) =>
      TipoCalidadEntity(
        tipoCalidadId: json["TipoCalidadId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "TipoCalidadId": tipoCalidadId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
