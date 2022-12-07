class PerfilPreInversionCofinanciadorActividadFinancieraEntity {
  PerfilPreInversionCofinanciadorActividadFinancieraEntity(
      {required this.actividadFinancieraId,
      required this.perfilPreInversionId,
      required this.cofinanciadorId,
      required this.desembolsoId,
      required this.valor,
      this.actividadFinanciera,
      this.desembolso,
      required this.recordStatus,
      this.canCreateRubro = false});

  String actividadFinancieraId;
  String perfilPreInversionId;
  String cofinanciadorId;
  String desembolsoId;
  String valor;
  String recordStatus;
  String? actividadFinanciera;
  String? desembolso;
  bool canCreateRubro;

  PerfilPreInversionCofinanciadorActividadFinancieraEntity copyWith({
    String? actividadFinancieraId,
    String? perfilPreInversionId,
    String? cofinanciadorId,
    String? desembolsoId,
    String? valor,
    String? recordStatus,
    bool? canCreateRubro,
  }) {
    return PerfilPreInversionCofinanciadorActividadFinancieraEntity(
      actividadFinancieraId:
          actividadFinancieraId ?? this.actividadFinancieraId,
      perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
      cofinanciadorId: cofinanciadorId ?? this.cofinanciadorId,
      desembolsoId: desembolsoId ?? this.desembolsoId,
      valor: valor ?? this.valor,
      recordStatus: recordStatus ?? this.recordStatus,
      canCreateRubro: canCreateRubro ?? this.canCreateRubro,
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
