class TipoActividadProductivaEntity {
  TipoActividadProductivaEntity({
    this.tipoActividadProductivaId,
    this.nombre,
    this.descripcion,
    this.tipoProyectoId,
  });

  String? tipoActividadProductivaId;
  String? nombre;
  String? descripcion;
  String? tipoProyectoId;

  Map<String, dynamic> toJson() => {
        "TipoActividadProductivaId": tipoActividadProductivaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "TipoProyectoId": tipoProyectoId,
      };
}
