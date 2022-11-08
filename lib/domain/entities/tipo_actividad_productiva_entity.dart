class TipoActividadProductivaEntity {
  TipoActividadProductivaEntity({
    required this.tipoActividadProductivaId,
    required this.nombre,
    required this.descripcion,
    required this.tipoProyectoId,
  });

  String tipoActividadProductivaId;
  String nombre;
  String descripcion;
  String tipoProyectoId;

  factory TipoActividadProductivaEntity.fromJson(Map<String, dynamic> json) =>
      TipoActividadProductivaEntity(
        tipoActividadProductivaId: json["TipoActividadProductivaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        tipoProyectoId: json["TipoProyectoId"],
      );

  Map<String, dynamic> toJson() => {
        "TipoActividadProductivaId": tipoActividadProductivaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "TipoProyectoId": tipoProyectoId,
      };
}
