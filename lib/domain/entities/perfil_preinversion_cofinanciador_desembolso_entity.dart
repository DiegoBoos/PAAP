class PerfilPreInversionCofinanciadorDesembolsoEntity {
  PerfilPreInversionCofinanciadorDesembolsoEntity({
    required this.perfilPreInversionId,
    required this.cofinanciadorId,
    required this.desembolsoId,
    required this.fecha,
    this.desembolso,
    required this.recordStatus,
  });

  String perfilPreInversionId;
  String cofinanciadorId;
  String desembolsoId;
  String fecha;
  String? desembolso;
  String recordStatus;

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

  factory PerfilPreInversionCofinanciadorDesembolsoEntity.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorDesembolsoEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        desembolsoId: json["DesembolsoId"],
        fecha: json["Fecha"],
        recordStatus: json["RecordStatus"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "DesembolsoId": desembolsoId,
        "Fecha": fecha,
        "RecordStatus": recordStatus,
      };
}
