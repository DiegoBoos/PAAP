class MetaIndicadorEntity {
  MetaIndicadorEntity(
      {required this.metaIndicadorId,
      required this.indicadorId,
      required this.year,
      required this.meta,
      required this.costo,
      required this.indicador});

  String metaIndicadorId;
  String indicadorId;
  String year;
  String meta;
  String costo;
  String indicador;

  factory MetaIndicadorEntity.fromJson(Map<String, dynamic> json) =>
      MetaIndicadorEntity(
        metaIndicadorId: json["MetaIndicadorId"],
        indicadorId: json["IndicadorId"],
        year: json["Year"],
        meta: json["Meta"],
        costo: json["Costo"],
        indicador: json["Indicador"],
      );

  Map<String, dynamic> toJson() => {
        "MetaIndicadorId": metaIndicadorId,
        "IndicadorId": indicadorId,
        "Year": year,
        "Meta": meta,
        "Costo": costo,
        "Indicador": indicador
      };
}
