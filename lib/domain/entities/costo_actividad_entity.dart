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

  factory CostoActividadEntity.fromJson(Map<String, dynamic> json) =>
      CostoActividadEntity(
        actividadId: json["ActividadId"],
        metaIndicadorId: json["MetaIndicadorId"],
        costo: json["Costo"],
        actividad: json["Actividad"],
        meta: json["Meta"],
        year: json["Year"],
        indicador: json["Indicador"],
      );

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
