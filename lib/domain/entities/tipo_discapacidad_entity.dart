class TipoDiscapacidadEntity {
  TipoDiscapacidadEntity({
    required this.tipoDiscapacidadId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoDiscapacidadId;
  String nombre;
  String descripcion;

  factory TipoDiscapacidadEntity.fromJson(Map<String, dynamic> json) =>
      TipoDiscapacidadEntity(
        tipoDiscapacidadId: json["TipoDiscapacidadId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "TipoDiscapacidadId": tipoDiscapacidadId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
