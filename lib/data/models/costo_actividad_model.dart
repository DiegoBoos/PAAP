import '../../domain/entities/costo_actividad_entity.dart';

class CostoActividadModel extends CostoActividadEntity {
  CostoActividadModel({
    required String actividadId,
    required String metaIndicadorId,
    required String costo,
    required String actividad,
    required String meta,
    required String year,
    required String indicador,
  }) : super(
            actividadId: actividadId,
            metaIndicadorId: metaIndicadorId,
            costo: costo,
            actividad: actividad,
            meta: meta,
            year: year,
            indicador: indicador);

  factory CostoActividadModel.fromJson(Map<String, dynamic> json) =>
      CostoActividadModel(
        actividadId: json["ActividadId"],
        metaIndicadorId: json["MetaIndicadorId"],
        costo: json["Costo"],
        actividad: json["Actividad"],
        meta: json["Meta"],
        year: json["Year"],
        indicador: json["Indicador"],
      );
}
