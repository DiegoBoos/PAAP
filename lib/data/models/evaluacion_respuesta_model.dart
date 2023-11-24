import 'package:paap/domain/entities/evaluacion_respuesta_entity.dart';

class EvaluacionRespuestaModel extends EvaluacionRespuestaEntity {
  EvaluacionRespuestaModel({
    String? criterioId,
    String? evaluacionId,
    String? opcionId,
    String? observacion,
    String? recordStatus,
    String? remoteEvaluacionId,
  }) : super(
          criterioId: criterioId,
          evaluacionId: evaluacionId,
          opcionId: opcionId,
          observacion: observacion,
          recordStatus: recordStatus,
          remoteEvaluacionId: remoteEvaluacionId,
        );

  factory EvaluacionRespuestaModel.fromJson(Map<String, dynamic> json) =>
      EvaluacionRespuestaModel(
        criterioId: json["CriterioId"],
        evaluacionId: json["EvaluacionId"],
        opcionId: json["OpcionId"],
        observacion: json["Observacion"],
        recordStatus: json["RecordStatus"],
        remoteEvaluacionId: json["RemoteEvaluacionId"],
      );
}
