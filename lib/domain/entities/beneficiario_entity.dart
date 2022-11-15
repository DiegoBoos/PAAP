class BeneficiarioEntity {
  BeneficiarioEntity({
    required this.beneficiarioId,
    required this.nombre1,
    required this.nombre2,
    required this.apellido1,
    required this.apellido2,
    required this.generoId,
    required this.fechaNacimiento,
    required this.fechaExpedicionDocumento,
    required this.grupoEspecialId,
    required this.telefonoMovil,
    required this.activo,
    required this.tipoIdentificacionId,
  });

  String beneficiarioId;
  String nombre1;
  String nombre2;
  String apellido1;
  String apellido2;
  String generoId;
  String fechaNacimiento;
  String fechaExpedicionDocumento;
  String grupoEspecialId;
  String telefonoMovil;
  String activo;
  String tipoIdentificacionId;

  BeneficiarioEntity copyWith({
    String? beneficiarioId,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? generoId,
    String? fechaNacimiento,
    String? fechaExpedicionDocumento,
    String? grupoEspecialId,
    String? telefonoMovil,
    String? activo,
    String? tipoIdentificacionId,
  }) =>
      BeneficiarioEntity(
        beneficiarioId: beneficiarioId ?? this.beneficiarioId,
        nombre1: nombre1 ?? this.nombre1,
        nombre2: nombre2 ?? this.nombre2,
        apellido1: apellido1 ?? this.apellido1,
        apellido2: apellido2 ?? this.apellido2,
        generoId: generoId ?? this.generoId,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        fechaExpedicionDocumento:
            fechaExpedicionDocumento ?? this.fechaExpedicionDocumento,
        grupoEspecialId: grupoEspecialId ?? this.grupoEspecialId,
        telefonoMovil: telefonoMovil ?? this.telefonoMovil,
        activo: activo ?? this.activo,
        tipoIdentificacionId: tipoIdentificacionId ?? this.tipoIdentificacionId,
      );

  factory BeneficiarioEntity.fromJson(Map<String, dynamic> json) =>
      BeneficiarioEntity(
        beneficiarioId: json["BeneficiarioId"],
        nombre1: json["Nombre1"],
        nombre2: json["Nombre2"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        generoId: json["GeneroId"],
        fechaNacimiento: json["FechaNacimiento"],
        fechaExpedicionDocumento: json["FechaExpedicionDocumento"],
        grupoEspecialId: json["GrupoEspecialId"],
        telefonoMovil: json["TelefonoMovil"],
        activo: json["Activo"],
        tipoIdentificacionId: json["TipoIdentificacionId"],
      );

  Map<String, dynamic> toJson() => {
        "BeneficiarioId": beneficiarioId,
        "Nombre1": nombre1,
        "Nombre2": nombre2,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "GeneroId": generoId,
        "FechaNacimiento": fechaNacimiento,
        "FechaExpedicionDocumento": fechaExpedicionDocumento,
        "GrupoEspecialId": grupoEspecialId,
        "TelefonoMovil": telefonoMovil,
        "Activo": activo,
        "TipoIdentificacionId": tipoIdentificacionId,
      };
}
