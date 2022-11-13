class EvaluacionRespuestaEntity {
  EvaluacionRespuestaEntity(
      {required this.criterioId,
      required this.evaluacionId,
      required this.opcionId,
      required this.observacion});

  String criterioId;
  String evaluacionId;
  String opcionId;
  String observacion;

  EvaluacionRespuestaEntity copyWith(
      {String? criterioId,
      String? evaluacionId,
      String? opcionId,
      String? observacion}) {
    return EvaluacionRespuestaEntity(
        criterioId: criterioId ?? this.criterioId,
        evaluacionId: evaluacionId ?? this.evaluacionId,
        opcionId: opcionId ?? this.opcionId,
        observacion: observacion ?? this.observacion);
  }

  factory EvaluacionRespuestaEntity.fromJson(Map<String, dynamic> json) =>
      EvaluacionRespuestaEntity(
        criterioId: json["CriterioId"],
        evaluacionId: json["EvaluacionId"],
        opcionId: json["OpcionId"],
        observacion: json["Observacion"],
      );

  Map<String, dynamic> toJson() => {
        "CriterioId": criterioId,
        "EvaluacionId": evaluacionId,
        "OpcionId": opcionId,
        "Observacion": observacion,
      };
}
