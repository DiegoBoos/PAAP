class PerfilPreInversionCofinanciadorDesembolsoEntity {
  PerfilPreInversionCofinanciadorDesembolsoEntity({
    this.perfilPreInversionId,
    this.cofinanciadorId,
    this.desembolsoId,
    this.fecha,
    this.desembolso,
    this.recordStatus,
  });

  String? perfilPreInversionId;
  String? cofinanciadorId;
  String? desembolsoId;
  String? fecha;
  String? desembolso;
  String? recordStatus;

  PerfilPreInversionCofinanciadorDesembolsoEntity copyWith({
    String? perfilPreInversionId,
    String? cofinanciadorId,
    String? desembolsoId,
    String? fecha,
    String? recordStatus,
  }) {
    return PerfilPreInversionCofinanciadorDesembolsoEntity(
      perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
      cofinanciadorId: cofinanciadorId ?? this.cofinanciadorId,
      desembolsoId: desembolsoId ?? this.desembolsoId,
      fecha: fecha ?? this.fecha,
      recordStatus: recordStatus ?? this.recordStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "DesembolsoId": desembolsoId,
        "Fecha": fecha,
        "RecordStatus": recordStatus,
      };
}
