class CostoActividadEntity {
  CostoActividadEntity({
    this.actividadId,
    this.metaIndicadorId,
    this.costo,
    this.actividad,
    this.meta,
    this.year,
    this.indicador,
  });

  String? actividadId;
  String? metaIndicadorId;
  String? costo;
  String? actividad;
  String? meta;
  String? year;
  String? indicador;

  Map<String, dynamic> toJson() => {
        "ActividadId": actividadId,
        "MetaIndicadorId": metaIndicadorId,
        "Costo": costo,
        "Actividad": actividad,
        "Meta": meta,
        "Year": year,
        "Indicador": indicador,
      };
}
