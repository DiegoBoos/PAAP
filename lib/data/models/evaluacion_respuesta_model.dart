import 'package:paap/domain/entities/evaluacion_respuesta_entity.dart';

class EvaluacionRespuestaModel extends EvaluacionRespuestaEntity {
  EvaluacionRespuestaModel(
      {required String criterioId,
      required String evaluacionId,
      required String opcionId,
      String? observacion})
      : super(
            criterioId: criterioId,
            evaluacionId: evaluacionId,
            opcionId: opcionId,
            observacion: observacion ?? '');

  factory EvaluacionRespuestaModel.fromJson(Map<String, dynamic> json) =>
      EvaluacionRespuestaModel(
        criterioId: json["CriterioId"],
        evaluacionId: json["EvaluacionId"],
        opcionId: json["OpcionId"],
        observacion: json["Observacion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "CriterioId": criterioId,
        "EvaluacionId": evaluacionId,
        "OpcionId": opcionId,
        "Observacion": observacion,
      };
}
