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
      );

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
      };
}
