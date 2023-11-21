class PerfilPreInversionConsultorEntity {
  PerfilPreInversionConsultorEntity({
    required this.perfilPreInversionId,
    required this.consultorId,
    required this.revisionId,
    required this.fechaRevision,
    this.recordStatus,
    this.revision,
    this.consultor,
  });

  String perfilPreInversionId;
  String consultorId;
  String revisionId;
  String fechaRevision;
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
