class PerfilPreInversionConsultorEntity {
  PerfilPreInversionConsultorEntity({
    this.perfilPreInversionId,
    this.consultorId,
    this.revisionId,
    this.fechaRevision,
    this.recordStatus,
    this.revision,
    this.consultor,
  });

  String? perfilPreInversionId;
  String? consultorId;
  String? revisionId;
  String? fechaRevision;
  String? recordStatus;
  String? revision;
  String? consultor;

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "ConsultorId": consultorId,
        "RevisionId": revisionId,
        "FechaRevision": fechaRevision,
        "RecordStatus": recordStatus,
        "Revision": revision,
        "Consultor": consultor,
      };
}
