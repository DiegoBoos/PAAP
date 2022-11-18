class PerfilPreInversionCofinanciadorRubroEntity {
  PerfilPreInversionCofinanciadorRubroEntity({
    required this.perfilPreInversionId,
    required this.cofinanciadorId,
    required this.desembolsoId,
    required this.actividadFinancieraId,
    required this.rubroId,
    required this.valor,
  });

  String perfilPreInversionId;
  String cofinanciadorId;
  String desembolsoId;
  String actividadFinancieraId;
  String rubroId;
  String valor;

  PerfilPreInversionCofinanciadorRubroEntity copyWith(
      {String? perfilPreInversionId,
      String? cofinanciadorId,
      String? desembolsoId,
      String? actividadFinancieraId,
      String? rubroId,
      String? valor}) {
    return PerfilPreInversionCofinanciadorRubroEntity(
        perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
        cofinanciadorId: cofinanciadorId ?? this.cofinanciadorId,
        desembolsoId: desembolsoId ?? this.desembolsoId,
        actividadFinancieraId:
            actividadFinancieraId ?? this.actividadFinancieraId,
        rubroId: rubroId ?? this.rubroId,
        valor: valor ?? this.valor);
  }

  factory PerfilPreInversionCofinanciadorRubroEntity.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorRubroEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        desembolsoId: json["DesembolsoId"],
        actividadFinancieraId: json["ActividadFinancieraId"],
        rubroId: json["RubroId"],
        valor: json["Valor"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "DesembolsoId": desembolsoId,
        "ActividadFinancieraId": actividadFinancieraId,
        "RubroId": rubroId,
        "Valor": valor,
      };
}
