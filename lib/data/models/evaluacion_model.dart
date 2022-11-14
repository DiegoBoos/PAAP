import 'package:paap/domain/entities/evaluacion_entity.dart';

class EvaluacionModel extends EvaluacionEntity {
  EvaluacionModel({
    required String evaluacionId,
    required String perfilId,
    String? resumen,
    String? fortalezas,
    String? debilidades,
    String? riesgos,
    String? finalizado,
    String? usuarioIdCoordinador,
    String? fechaEvaluacion,
    String? preAprobado,
    String? recordStatus,
  }) : super(
            evaluacionId: evaluacionId,
            perfilId: perfilId,
            resumen: resumen ?? '',
            fortalezas: fortalezas ?? '',
            debilidades: debilidades ?? '',
            riesgos: riesgos ?? '',
            finalizado: finalizado ?? '',
            usuarioIdCoordinador: usuarioIdCoordinador ?? '',
            fechaEvaluacion: fechaEvaluacion ?? '',
            preAprobado: preAprobado ?? '',
            recordStatus: recordStatus ?? '');

  factory EvaluacionModel.fromJson(Map<String, dynamic> json) =>
      EvaluacionModel(
        evaluacionId: json["EvaluacionId"].toString(),
        perfilId: json["PerfilId"],
        resumen: json["Resumen"],
        fortalezas: json["Fortalezas"],
        debilidades: json["Debilidades"],
        riesgos: json["Riesgos"],
        finalizado: json["Finalizado"],
        usuarioIdCoordinador: json["UsuarioIdCoordinador"],
        fechaEvaluacion: json["FechaEvaluacion"],
        preAprobado: json["PreAprobado"],
        recordStatus: json["RecordStatus"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "EvaluacionId": evaluacionId,
        "PerfilId": perfilId,
        "Resumen": resumen,
        "Fortalezas": fortalezas,
        "Debilidades": debilidades,
        "Riesgos": riesgos,
        "Finalizado": finalizado,
        "UsuarioIdCoordinador": usuarioIdCoordinador,
        "FechaEvaluacion": fechaEvaluacion,
        "PreAprobado": preAprobado,
        "RecordStatus": recordStatus,
      };
}
