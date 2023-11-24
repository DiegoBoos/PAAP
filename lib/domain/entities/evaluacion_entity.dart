class EvaluacionEntity {
  EvaluacionEntity({
    this.evaluacionId,
    this.perfilId,
    this.resumen,
    this.fortalezas,
    this.debilidades,
    this.riesgos,
    this.finalizado,
    this.usuarioIdCoordinador,
    this.fechaEvaluacion,
    this.preAprobado,
    this.recordStatus,
    this.remoteEvaluacionId,
  });

  String? evaluacionId;
  String? perfilId;
  String? resumen;
  String? fortalezas;
  String? debilidades;
  String? riesgos;
  String? finalizado;
  String? usuarioIdCoordinador;
  String? fechaEvaluacion;
  String? preAprobado;
  String? recordStatus;
  String? remoteEvaluacionId;

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
