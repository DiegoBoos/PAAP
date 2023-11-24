class ActividadFinancieraEntity {
  ActividadFinancieraEntity({
    this.actividadFinancieraId,
    this.nombre,
    this.descripcion,
    this.activo,
    this.tipoMovimientoId,
  });

  String? actividadFinancieraId;
  String? nombre;
  String? descripcion;
  String? activo;
  String? tipoMovimientoId;

  Map<String, dynamic> toJson() => {
        "ActividadFinancieraId": actividadFinancieraId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Activo": activo,
        "TipoMovimientoId": tipoMovimientoId,
      };
}
