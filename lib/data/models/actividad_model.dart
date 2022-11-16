import '../../domain/entities/actividad_entity.dart';

class ActividadModel extends ActividadEntity {
  ActividadModel(
      {required String actividadId,
      required String nombre,
      required String indicadorId,
      required String indicador})
      : super(
            actividadId: actividadId,
            nombre: nombre,
            indicadorId: indicadorId,
            indicador: indicador);

  factory ActividadModel.fromJson(Map<String, dynamic> json) => ActividadModel(
        actividadId: json["ActividadId"],
        nombre: json["Nombre"],
        indicadorId: json["IndicadorId"],
        indicador: json["Indicador"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "ActividadId": actividadId,
        "Nombre": nombre,
        "IndicadorId": indicadorId,
        "Indicador": indicador,
      };
}
