class PerfilPreInversionCofinanciadorEntity {
  PerfilPreInversionCofinanciadorEntity({
    this.perfilPreInversionId,
    this.cofinanciadorId,
    this.nombre,
    this.telefonoMovil,
    this.correo,
    this.municipio,
    this.monto,
    this.participacion,
    this.recordStatus,
  });

  String? perfilPreInversionId;
  String? cofinanciadorId;
  String? nombre;
  String? telefonoMovil;
  String? correo;
  String? municipio;
  String? monto;
  String? participacion;
  String? recordStatus;

  PerfilPreInversionCofinanciadorEntity copyWith({
    String? perfilPreInversionId,
    String? cofinanciadorId,
    String? monto,
    String? participacion,
    String? recordStatus,
  }) {
    return PerfilPreInversionCofinanciadorEntity(
      perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
      cofinanciadorId: cofinanciadorId ?? this.cofinanciadorId,
      monto: monto ?? this.monto,
      participacion: participacion ?? this.participacion,
      recordStatus: recordStatus ?? this.recordStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "Monto": monto,
        "Participacion": participacion,
        "RecordStatus": recordStatus,
      };
}
