class PerfilPreInversionConsultorEntity {
  PerfilPreInversionConsultorEntity({
    required this.perfilPreInversionId,
    required this.consultorId,
    required this.revisionId,
    required this.fechaRevision,
    required this.recordStatus,
  });

  String perfilPreInversionId;
  String consultorId;
  String revisionId;
  String fechaRevision;
  String recordStatus;

  factory PerfilPreInversionConsultorEntity.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionConsultorEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        consultorId: json["ConsultorId"],
        revisionId: json["RevisionId"],
        fechaRevision: json["FechaRevision"],
        recordStatus: json["RecordStatus"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "ConsultorId": consultorId,
        "RevisionId": revisionId,
        "FechaRevision": fechaRevision,
        "RecordStatus": recordStatus,
      };
}
