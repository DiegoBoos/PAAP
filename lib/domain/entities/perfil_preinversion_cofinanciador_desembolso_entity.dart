class PerfilPreInversionCofinanciadorDesembolsoEntity {
  PerfilPreInversionCofinanciadorDesembolsoEntity({
    required this.perfilPreInversionId,
    required this.cofinanciadorId,
    required this.desembolsoId,
    required this.fecha,
  });

  String perfilPreInversionId;
  String cofinanciadorId;
  String desembolsoId;
  String fecha;

  PerfilPreInversionCofinanciadorDesembolsoEntity copyWith({
    String? perfilPreInversionId,
    String? cofinanciadorId,
    String? desembolsoId,
    String? fecha,
  }) {
    return PerfilPreInversionCofinanciadorDesembolsoEntity(
      perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
      cofinanciadorId: cofinanciadorId ?? this.cofinanciadorId,
      desembolsoId: desembolsoId ?? this.desembolsoId,
      fecha: fecha ?? this.fecha,
    );
  }

  factory PerfilPreInversionCofinanciadorDesembolsoEntity.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorDesembolsoEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        desembolsoId: json["DesembolsoId"],
        fecha: json["Fecha"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "DesembolsoId": desembolsoId,
        "Fecha": fecha,
      };
}
