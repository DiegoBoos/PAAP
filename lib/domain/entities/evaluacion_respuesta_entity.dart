class EvaluacionRespuestaEntity {
  EvaluacionRespuestaEntity({
    this.criterioId,
    this.evaluacionId,
    this.opcionId,
    this.observacion,
    this.recordStatus,
    this.remoteEvaluacionId,
  });

  String? criterioId;
  String? evaluacionId;
  String? opcionId;
  String? observacion;
  String? recordStatus;
  String? remoteEvaluacionId;

  EvaluacionRespuestaEntity copyWith({
    String? criterioId,
    String? evaluacionId,
    String? opcionId,
    String? observacion,
    String? recordStatus,
    String? remoteEvaluacionId,
  }) {
    return EvaluacionRespuestaEntity(
      criterioId: criterioId ?? this.criterioId,
      evaluacionId: evaluacionId ?? this.evaluacionId,
      opcionId: opcionId ?? this.opcionId,
      observacion: observacion ?? this.observacion,
      recordStatus: recordStatus ?? this.recordStatus,
      remoteEvaluacionId: remoteEvaluacionId ?? this.remoteEvaluacionId,
    );
  }

  Map<String, dynamic> toJson() => {
        "CriterioId": criterioId,
        "EvaluacionId": evaluacionId,
        "OpcionId": opcionId,
        "Observacion": observacion,
        "RecordStatus": recordStatus,
        "RemoteEvaluacionId": remoteEvaluacionId,
      };
}
