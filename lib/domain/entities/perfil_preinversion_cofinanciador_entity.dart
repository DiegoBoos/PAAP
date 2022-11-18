class PerfilPreInversionCofinanciadorEntity {
  PerfilPreInversionCofinanciadorEntity({
    required this.perfilPreInversionId,
    required this.cofinanciadorId,
    required this.monto,
    required this.participacion,
  });

  String perfilPreInversionId;
  String cofinanciadorId;
  String monto;
  String participacion;

  PerfilPreInversionCofinanciadorEntity copyWith({
    String? perfilPreInversionId,
    String? cofinanciadorId,
    String? monto,
    String? participacion,
  }) {
    return PerfilPreInversionCofinanciadorEntity(
      perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
      cofinanciadorId: cofinanciadorId ?? this.cofinanciadorId,
      monto: monto ?? this.monto,
      participacion: participacion ?? this.participacion,
    );
  }

  factory PerfilPreInversionCofinanciadorEntity.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        monto: json["Monto"],
        participacion: json["Participacion"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "Monto": monto,
        "Participacion": participacion,
      };
}
