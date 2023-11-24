class VisitaEntity {
  VisitaEntity({
    this.perfilId,
    this.tipoVisitaId,
    this.fechaInicial,
    this.fechaFinal,
    this.estadoVisitaId,
    this.observacion,
    this.usuarioId,
    this.fechaRegistro,
    this.recordStatus,
  });

  String? perfilId;
  String? tipoVisitaId;
  String? fechaInicial;
  String? fechaFinal;
  String? estadoVisitaId;
  String? observacion;
  String? usuarioId;
  String? fechaRegistro;
  String? recordStatus;

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
