class PerfilPreInversionCofinanciadorActividadFinancieraEntity {
  PerfilPreInversionCofinanciadorActividadFinancieraEntity({
    required this.actividadFinancieraId,
    required this.perfilPreInversionId,
    required this.cofinanciadorId,
    required this.desembolsoId,
    required this.valor,
    this.actividadFinanciera,
    this.desembolso,
    required this.recordStatus,
  });

  String actividadFinancieraId;
  String perfilPreInversionId;
  String cofinanciadorId;
  String desembolsoId;
  String valor;
  String recordStatus;
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
