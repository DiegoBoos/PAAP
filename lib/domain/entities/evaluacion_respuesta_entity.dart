class EvaluacionRespuestaEntity {
  EvaluacionRespuestaEntity({
    required this.criterioId,
    required this.evaluacionId,
    required this.opcionId,
    required this.observacion,
    required this.recordStatus,
    required this.remoteEvaluacionId,
  });

  String criterioId;
  String evaluacionId;
  String opcionId;
  String observacion;
  String recordStatus;
  String remoteEvaluacionId;

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

  factory EvaluacionRespuestaEntity.fromJson(Map<String, dynamic> json) =>
      EvaluacionRespuestaEntity(
        criterioId: json["CriterioId"],
        evaluacionId: json["EvaluacionId"],
        opcionId: json["OpcionId"],
        observacion: json["Observacion"],
        recordStatus: json["RecordStatus"],
        remoteEvaluacionId: json["RemoteEvaluacionId"],
      );

  Map<String, dynamic> toJson() => {
        "CriterioId": criterioId,
        "EvaluacionId": evaluacionId,
        "OpcionId": opcionId,
        "Observacion": observacion,
        "RecordStatus": recordStatus,
        "RemoteEvaluacionId": remoteEvaluacionId,
      };
}
