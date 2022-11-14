class VisitaEntity {
  VisitaEntity({
    required this.perfilId,
    required this.tipoVisitaId,
    required this.fechaInicial,
    required this.fechaFinal,
    required this.estadoVisitaId,
    required this.observacion,
    required this.usuarioId,
    required this.fechaRegistro,
    required this.recordStatus,
  });

  String perfilId;
  String tipoVisitaId;
  String fechaInicial;
  String fechaFinal;
  String estadoVisitaId;
  String observacion;
  String usuarioId;
  String fechaRegistro;
  String recordStatus;

  factory VisitaEntity.fromJson(Map<String, dynamic> json) => VisitaEntity(
        perfilId: json["PerfilId"],
        tipoVisitaId: json["TipoVisitaId"],
        fechaInicial: json["FechaInicial"],
        fechaFinal: json["FechaFinal"],
        estadoVisitaId: json["EstadoVisitaId"],
        observacion: json["Observacion"],
        usuarioId: json["UsuarioId"],
        fechaRegistro: json["FechaRegistro"],
        recordStatus: json["FechaRegistro"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilId": perfilId,
        "TipoVisitaId": tipoVisitaId,
        "FechaInicial": fechaInicial,
        "FechaFinal": fechaFinal,
        "EstadoVisitaId": estadoVisitaId,
        "Observacion": observacion,
        "UsuarioId": usuarioId,
        "FechaRegistro": fechaRegistro,
        "RecordStatus": recordStatus,
      };
}
