class EvaluacionEntity {
  EvaluacionEntity({
    required this.evaluacionId,
    required this.perfilId,
    required this.resumen,
    required this.fortalezas,
    required this.debilidades,
    required this.riesgos,
    required this.finalizado,
    required this.usuarioIdCoordinador,
    required this.fechaEvaluacion,
    required this.preAprobado,
    required this.recordStatus,
    required this.remoteEvaluacionId,
  });

  String evaluacionId;
  String perfilId;
  String resumen;
  String fortalezas;
  String debilidades;
  String riesgos;
  String finalizado;
  String usuarioIdCoordinador;
  String fechaEvaluacion;
  String preAprobado;
  String recordStatus;
  String remoteEvaluacionId;

  factory EvaluacionEntity.fromJson(Map<String, dynamic> json) =>
      EvaluacionEntity(
        evaluacionId: json["EvaluacionId"],
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
        remoteEvaluacionId: json["RemoteEvaluacionId"],
      );

  Map<String, dynamic> toJson() => {
        //"EvaluacionId": evaluacionId,
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
        "RemoteEvaluacionId": remoteEvaluacionId,
      };

  EvaluacionEntity copyWith({
    String? evaluacionId,
    String? perfilId,
    String? resumen,
    String? fortalezas,
    String? debilidades,
    String? riesgos,
    String? finalizado,
    String? usuarioIdCoordinador,
    String? fechaEvaluacion,
    String? preAprobado,
    String? recordStatus,
    String? remoteEvaluacionId,
  }) =>
      EvaluacionEntity(
        evaluacionId: evaluacionId ?? this.evaluacionId,
        perfilId: perfilId ?? this.perfilId,
        resumen: resumen ?? this.resumen,
        fortalezas: fortalezas ?? this.fortalezas,
        debilidades: debilidades ?? this.debilidades,
        riesgos: riesgos ?? this.riesgos,
        finalizado: finalizado ?? this.finalizado,
        usuarioIdCoordinador: usuarioIdCoordinador ?? this.usuarioIdCoordinador,
        fechaEvaluacion: fechaEvaluacion ?? this.fechaEvaluacion,
        preAprobado: preAprobado ?? this.preAprobado,
        recordStatus: recordStatus ?? this.recordStatus,
        remoteEvaluacionId: remoteEvaluacionId ?? this.remoteEvaluacionId,
      );
}
