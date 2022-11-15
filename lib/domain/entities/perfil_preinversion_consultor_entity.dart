class PerfilPreInversionConsultorEntity {
  PerfilPreInversionConsultorEntity({
    required this.perfilPreInversionId,
    required this.consultorId,
    required this.revisionId,
    required this.fechaRevision,
  });

  String perfilPreInversionId;
  String consultorId;
  String revisionId;
  String fechaRevision;

  factory PerfilPreInversionConsultorEntity.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionConsultorEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        consultorId: json["ConsultorId"],
        revisionId: json["RevisionId"],
        fechaRevision: json["FechaRevision"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "ConsultorId": consultorId,
        "RevisionId": revisionId,
        "FechaRevision": fechaRevision,
      };
}
