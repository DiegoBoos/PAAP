class PerfilCofinanciadorEntity {
  PerfilCofinanciadorEntity({
    this.perfilId,
    this.cofinanciadorId,
    this.nombre,
    this.telefonoMovil,
    this.correo,
    this.municipio,
    this.monto,
    this.participacion,
    this.recordStatus,
  });

  String? perfilId;
  String? cofinanciadorId;
  String? nombre;
  String? telefonoMovil;
  String? correo;
  String? municipio;
  String? monto;
  String? participacion;
  String? recordStatus;

  PerfilCofinanciadorEntity copyWith({
    String? perfilId,
    String? cofinanciadorId,
    String? monto,
    String? participacion,
    String? recordStatus,
  }) {
    return PerfilCofinanciadorEntity(
      perfilId: perfilId ?? this.perfilId,
      cofinanciadorId: cofinanciadorId ?? this.cofinanciadorId,
      monto: monto ?? this.monto,
      participacion: participacion ?? this.participacion,
      recordStatus: recordStatus ?? this.recordStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        "PerfilId": perfilId,
        "CofinanciadorId": cofinanciadorId,
        "Monto": monto,
        "Participacion": participacion,
        "RecordStatus": recordStatus,
      };
}
