class PerfilPreInversionCofinanciadorActividadFinancieraEntity {
  PerfilPreInversionCofinanciadorActividadFinancieraEntity({
    this.actividadFinancieraId,
    this.perfilPreInversionId,
    this.cofinanciadorId,
    this.desembolsoId,
    this.valor,
    this.actividadFinanciera,
    this.desembolso,
    this.recordStatus,
  });

  String? actividadFinancieraId;
  String? perfilPreInversionId;
  String? cofinanciadorId;
  String? desembolsoId;
  String? valor;
  String? recordStatus;
  String? actividadFinanciera;
  String? desembolso;

  PerfilPreInversionCofinanciadorActividadFinancieraEntity copyWith({
    String? actividadFinancieraId,
    String? perfilPreInversionId,
    String? cofinanciadorId,
    String? desembolsoId,
    String? valor,
    String? recordStatus,
  }) {
    return PerfilPreInversionCofinanciadorActividadFinancieraEntity(
      actividadFinancieraId:
          actividadFinancieraId ?? this.actividadFinancieraId,
      perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
      cofinanciadorId: cofinanciadorId ?? this.cofinanciadorId,
      desembolsoId: desembolsoId ?? this.desembolsoId,
      valor: valor ?? this.valor,
      recordStatus: recordStatus ?? this.recordStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        "ActividadFinancieraId": actividadFinancieraId,
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "DesembolsoId": desembolsoId,
        "Valor": valor,
        "RecordStatus": recordStatus,
      };
}
