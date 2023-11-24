class BeneficiarioEntity {
  BeneficiarioEntity({
    this.beneficiarioId,
    this.tipoIdentificacionId,
    this.tipoDocumento,
    this.fechaExpedicionDocumento,
    this.fechaNacimiento,
    this.edad,
    this.nombre1,
    this.nombre2,
    this.apellido1,
    this.apellido2,
    this.generoId,
    this.genero,
    this.grupoEspecialId,
    this.grupoEspecial,
    this.telefonoMovil,
    this.activo,
    this.recordStatus,
  });

  String? beneficiarioId;
  String? tipoIdentificacionId;
  String? tipoDocumento;
  String? fechaExpedicionDocumento;
  String? fechaNacimiento;
  int? edad;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? generoId;
  String? genero;
  String? grupoEspecialId;
  String? grupoEspecial;
  String? telefonoMovil;
  String? activo;
  String? recordStatus;

  BeneficiarioEntity copyWith({
    String? beneficiarioId,
    String? tipoIdentificacionId,
    String? tipoDocumento,
    String? fechaExpedicionDocumento,
    String? fechaNacimiento,
    int? edad,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? generoId,
    String? genero,
    String? grupoEspecialId,
    String? grupoEspecial,
    String? telefonoMovil,
    String? activo,
    String? recordStatus,
  }) =>
      BeneficiarioEntity(
        beneficiarioId: beneficiarioId ?? this.beneficiarioId,
        tipoIdentificacionId: tipoIdentificacionId ?? this.tipoIdentificacionId,
        tipoDocumento: tipoDocumento ?? this.tipoDocumento,
        fechaExpedicionDocumento:
            fechaExpedicionDocumento ?? this.fechaExpedicionDocumento,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        edad: edad ?? this.edad,
        nombre1: nombre1 ?? this.nombre1,
        nombre2: nombre2 ?? this.nombre2,
        apellido1: apellido1 ?? this.apellido1,
        apellido2: apellido2 ?? this.apellido2,
        generoId: generoId ?? this.generoId,
        genero: genero ?? this.genero,
        grupoEspecialId: grupoEspecialId ?? this.grupoEspecialId,
        grupoEspecial: grupoEspecial ?? this.grupoEspecial,
        telefonoMovil: telefonoMovil ?? this.telefonoMovil,
        activo: activo ?? this.activo,
        recordStatus: recordStatus ?? this.recordStatus,
      );

  Map<String, dynamic> toJson() => {
        "BeneficiarioId": beneficiarioId,
        "TipoIdentificacionId": tipoIdentificacionId,
        "FechaExpedicionDocumento": fechaExpedicionDocumento,
        "FechaNacimiento": fechaNacimiento,
        "Nombre1": nombre1,
        "Nombre2": nombre2,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "GeneroId": generoId,
        "GrupoEspecialId": grupoEspecialId,
        "TelefonoMovil": telefonoMovil,
        "Activo": activo,
        "RecordStatus": recordStatus,
      };
}
