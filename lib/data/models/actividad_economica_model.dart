import 'package:paap/domain/entities/actividad_economica_entity.dart';

class ActividadEconomicaModel extends ActividadEconomicaEntity {
  ActividadEconomicaModel({
    String? actividadEconomicaId,
    String? nombre,
    String? descripcion,
  }) : super(
            actividadEconomicaId: actividadEconomicaId,
            nombre: nombre,
            descripcion: descripcion);

  factory ActividadEconomicaModel.fromJson(Map<String, dynamic> json) =>
      ActividadEconomicaModel(
        actividadEconomicaId: json["ActividadEconomicaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );
}
