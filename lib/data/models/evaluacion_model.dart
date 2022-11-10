import 'package:paap/domain/entities/evaluacion_entity.dart';

class EvaluacionModel extends EvaluacionEntity {
  EvaluacionModel({
    required String evaluacionId,
    required String perfilId,
    required String resumen,
    required String fortalezas,
    required String debilidades,
    required String riesgos,
    required String finalizado,
    required String fechaEvaluacion,
    required String preAprobado,
  }) : super(
            evaluacionId: evaluacionId,
            perfilId: perfilId,
            resumen: resumen,
            fortalezas: fortalezas,
            debilidades: debilidades,
            riesgos: riesgos,
            finalizado: finalizado,
            fechaEvaluacion: fechaEvaluacion,
            preAprobado: preAprobado);

  factory EvaluacionModel.fromJson(Map<String, dynamic> json) =>
      EvaluacionModel(
        evaluacionId: json["EvaluacionId"],
        perfilId: json["PerfilId"],
        resumen: json["Resumen"],
        fortalezas: json["Fortalezas"],
        debilidades: json["Debilidades"],
        riesgos: json["Riesgos"],
        finalizado: json["Finalizado"],
        fechaEvaluacion: json["FechaEvaluacion"],
        preAprobado: json["PreAprobado"],
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
        "FechaEvaluacion": fechaEvaluacion,
        "PreAprobado": preAprobado,
      };
}
