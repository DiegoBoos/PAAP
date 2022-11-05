class TipoTenenciaEntity {
  TipoTenenciaEntity({
    required this.tipoTenenciaId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoTenenciaId;
  String nombre;
  String descripcion;

  factory TipoTenenciaEntity.fromJson(Map<String, dynamic> json) =>
      TipoTenenciaEntity(
        tipoTenenciaId: json["TipoTenenciaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "TipoTenenciaId": tipoTenenciaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
