class PerfilPreInversionCofinanciadorActividadFinancieraEntity {
  PerfilPreInversionCofinanciadorActividadFinancieraEntity({
    required this.actividadFinancieraId,
    required this.perfilPreInversionId,
    required this.cofinanciadorId,
    required this.desembolsoId,
    required this.valor,
    required this.recordStatus,
  });

  String actividadFinancieraId;
  String perfilPreInversionId;
  String cofinanciadorId;
  String desembolsoId;
  String valor;
  String recordStatus;

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

  factory PerfilPreInversionCofinanciadorActividadFinancieraEntity.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorActividadFinancieraEntity(
        actividadFinancieraId: json["ActividadFinancieraId"],
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        desembolsoId: json["DesembolsoId"],
        valor: json["Valor"],
        recordStatus: json["RecordStatus"],
      );

  Map<String, dynamic> toJson() => {
        "ActividadFinancieraId": actividadFinancieraId,
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "DesembolsoId": desembolsoId,
        "Valor": valor,
        "RecordStatus": recordStatus,
      };
}
