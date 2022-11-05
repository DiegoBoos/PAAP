class ActividadFinancieraEntity {
  ActividadFinancieraEntity({
    required this.actividadFinancieraId,
    required this.nombre,
    required this.descripcion,
    required this.activo,
    required this.tipoMovimientoId,
  });

  String actividadFinancieraId;
  String nombre;
  String descripcion;
  String activo;
  String tipoMovimientoId;

  factory ActividadFinancieraEntity.fromJson(Map<String, dynamic> json) =>
      ActividadFinancieraEntity(
        actividadFinancieraId: json["ActividadFinancieraId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        activo: json["Activo"],
        tipoMovimientoId: json["TipoMovimientoId"],
      );

  Map<String, dynamic> toJson() => {
        "ActividadFinancieraId": actividadFinancieraId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Activo": activo,
        "TipoMovimientoId": tipoMovimientoId,
      };
}
