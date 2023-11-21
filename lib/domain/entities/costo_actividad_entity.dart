class CostoActividadEntity {
  CostoActividadEntity({
    required this.actividadId,
    required this.metaIndicadorId,
    required this.costo,
    required this.actividad,
    required this.meta,
    required this.year,
    required this.indicador,
  });

  String actividadId;
  String metaIndicadorId;
  String costo;
  String actividad;
  String meta;
  String year;
  String indicador;

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
