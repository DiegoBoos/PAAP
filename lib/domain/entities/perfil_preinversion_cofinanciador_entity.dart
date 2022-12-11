class PerfilPreInversionCofinanciadorEntity {
  PerfilPreInversionCofinanciadorEntity(
      {required this.perfilPreInversionId,
      required this.cofinanciadorId,
      this.nombre,
      this.telefonoMovil,
      this.correo,
      required this.monto,
      required this.participacion,
      required this.recordStatus,
      this.isEditing = false,
      this.canCreateDesembolso = false});

  String perfilPreInversionId;
  String cofinanciadorId;
  String? nombre;
  String? telefonoMovil;
  String? correo;
  String monto;
  String participacion;
  String recordStatus;
  bool isEditing;
  bool canCreateDesembolso;

  PerfilPreInversionCofinanciadorEntity copyWith({
    String? perfilPreInversionId,
    String? cofinanciadorId,
    String? monto,
    String? participacion,
    String? recordStatus,
    bool? isEditing,
    bool? canCreateDesembolso,
  }) {
    return PerfilPreInversionCofinanciadorEntity(
      perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
      cofinanciadorId: cofinanciadorId ?? this.cofinanciadorId,
      monto: monto ?? this.monto,
      participacion: participacion ?? this.participacion,
      recordStatus: recordStatus ?? this.recordStatus,
      isEditing: isEditing ?? this.isEditing,
      canCreateDesembolso: canCreateDesembolso ?? this.canCreateDesembolso,
    );
  }

  factory PerfilPreInversionCofinanciadorEntity.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        monto: json["Monto"],
        participacion: json["Participacion"],
        recordStatus: json["RecordStatus"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "Monto": monto,
        "Participacion": participacion,
        "RecordStatus": recordStatus,
      };
}
