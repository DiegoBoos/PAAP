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

  Map<String, dynamic> toJson() => {
        "TipoActividadProductivaId": tipoActividadProductivaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "TipoProyectoId": tipoProyectoId,
      };
}
