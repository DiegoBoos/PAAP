class PerfilPreInversionCofinanciadorRubroEntity {
  PerfilPreInversionCofinanciadorRubroEntity({
    required this.perfilPreInversionId,
    required this.cofinanciadorId,
    required this.desembolsoId,
    required this.actividadFinancieraId,
    required this.rubroId,
    required this.valor,
    this.actividadFinanciera,
    this.rubro,
    this.desembolso,
    required this.recordStatus,
  });

  String perfilPreInversionId;
  String cofinanciadorId;
  String desembolsoId;
  String actividadFinancieraId;
  String rubroId;
  String valor;
  String? actividadFinanciera;
  String? rubro;
  String? desembolso;
  String recordStatus;

  PerfilPreInversionCofinanciadorRubroEntity copyWith({
    String? perfilPreInversionId,
    String? cofinanciadorId,
    String? desembolsoId,
    String? actividadFinancieraId,
    String? rubroId,
    String? valor,
    String? recordStatus,
  }) {
    return PerfilPreInversionCofinanciadorRubroEntity(
      perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
      cofinanciadorId: cofinanciadorId ?? this.cofinanciadorId,
      desembolsoId: desembolsoId ?? this.desembolsoId,
      actividadFinancieraId:
          actividadFinancieraId ?? this.actividadFinancieraId,
      rubroId: rubroId ?? this.rubroId,
      valor: valor ?? this.valor,
      recordStatus: recordStatus ?? this.recordStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "DesembolsoId": desembolsoId,
        "ActividadFinancieraId": actividadFinancieraId,
        "RubroId": rubroId,
        "Valor": valor,
        "RecordStatus": recordStatus,
      };
}
