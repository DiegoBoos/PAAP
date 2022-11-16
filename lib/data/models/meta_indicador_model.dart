import 'package:paap/domain/entities/meta_indicador_entity.dart';

class MetaIndicadorModel extends MetaIndicadorEntity {
  MetaIndicadorModel(
      {required String metaIndicadorId,
      required String indicadorId,
      required String year,
      required String meta,
      required String costo,
      required String indicador})
      : super(
            metaIndicadorId: metaIndicadorId,
            indicadorId: indicadorId,
            year: year,
            meta: meta,
            costo: costo,
            indicador: indicador);

  factory MetaIndicadorModel.fromJson(Map<String, dynamic> json) =>
      MetaIndicadorModel(
        metaIndicadorId: json["MetaIndicadorId"],
        indicadorId: json["IndicadorId"],
        year: json["Year"],
        meta: json["Meta"],
        costo: json["Costo"],
        indicador: json["Indicador"],
      );
  @override
  Map<String, dynamic> toJson() => {
        "MetaIndicadorId": metaIndicadorId,
        "IndicadorId": indicadorId,
        "Year": year,
        "Meta": meta,
        "Costo": costo,
        "Indicador": indicador
      };
}
