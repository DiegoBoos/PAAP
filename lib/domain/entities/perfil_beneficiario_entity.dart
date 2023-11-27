class PerfilBeneficiarioEntity {
  PerfilBeneficiarioEntity({
    this.perfilId,
    this.beneficiarioId,
    this.municipioId,
    this.veredaId,
    this.areaFinca,
    this.areaProyecto,
    this.tipoTenenciaId,
    this.experiencia,
    this.asociado,
    this.conocePerfil,
    this.fueBeneficiado,
    this.cualBeneficio,
    this.activo,
    this.tipoIdentificacionId,
    this.fechaExpedicionDocumento,
    this.fechaNacimiento,
    this.edad,
    this.nombre1,
    this.nombre2,
    this.apellido1,
    this.apellido2,
    this.generoId,
    this.grupoEspecialId,
    this.telefonoMovil,
    this.recordStatus,
  });

  String? perfilId;
  String? beneficiarioId;
  String? municipioId;
  String? veredaId;
  String? areaFinca;
  String? areaProyecto;
  String? tipoTenenciaId;
  String? experiencia;
  String? asociado;
  String? conocePerfil;
  String? fueBeneficiado;
  String? cualBeneficio;
  String? activo;
  String? tipoIdentificacionId;
  String? fechaExpedicionDocumento;
  String? fechaNacimiento;
  int? edad;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? generoId;
  String? grupoEspecialId;
  String? telefonoMovil;
  String? recordStatus;

  PerfilBeneficiarioEntity copyWith({
    String? perfilId,
    String? beneficiarioId,
    String? municipioId,
    String? veredaId,
    String? areaFinca,
    String? areaProyecto,
    String? tipoTenenciaId,
    String? experiencia,
    String? asociado,
    String? conocePerfil,
    String? fueBeneficiado,
    String? cualBeneficio,
    String? activo,
    String? tipoIdentificacionId,
    String? fechaExpedicionDocumento,
    String? fechaNacimiento,
    int? edad,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? generoId,
    String? grupoEspecialId,
    String? telefonoMovil,
    String? recordStatus,
  }) {
    return PerfilBeneficiarioEntity(
      perfilId: perfilId ?? this.perfilId,
      beneficiarioId: beneficiarioId ?? this.beneficiarioId,
      municipioId: municipioId ?? this.municipioId,
      veredaId: veredaId ?? this.veredaId,
      areaFinca: areaFinca ?? this.areaFinca,
      areaProyecto: areaProyecto ?? this.areaProyecto,
      tipoTenenciaId: tipoTenenciaId ?? this.tipoTenenciaId,
      experiencia: experiencia ?? this.experiencia,
      asociado: asociado ?? this.asociado,
      conocePerfil: conocePerfil ?? this.conocePerfil,
      fueBeneficiado: fueBeneficiado ?? this.fueBeneficiado,
      cualBeneficio: cualBeneficio ?? this.cualBeneficio,
      activo: activo ?? this.activo,
      tipoIdentificacionId: tipoIdentificacionId ?? this.tipoIdentificacionId,
      fechaExpedicionDocumento:
          fechaExpedicionDocumento ?? this.fechaExpedicionDocumento,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      edad: edad ?? this.edad,
      nombre1: nombre1 ?? this.nombre1,
      nombre2: nombre2 ?? this.nombre2,
      apellido1: apellido1 ?? this.apellido1,
      apellido2: apellido2 ?? this.apellido2,
      generoId: generoId ?? this.generoId,
      grupoEspecialId: grupoEspecialId ?? this.grupoEspecialId,
      telefonoMovil: telefonoMovil ?? this.telefonoMovil,
      recordStatus: recordStatus ?? this.recordStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        "PerfilId": perfilId,
        "BeneficiarioId": beneficiarioId,
        "MunicipioId": municipioId,
        "VeredaId": veredaId,
        "AreaFinca": areaFinca,
        "AreaProyecto": areaProyecto,
        "TipoTenenciaId": tipoTenenciaId,
        "Experiencia": experiencia,
        "Asociado": asociado,
        "ConocePerfil": conocePerfil,
        "FueBeneficiado": fueBeneficiado,
        "CualBeneficio": cualBeneficio,
        "Activo": activo,
        "RecordStatus": recordStatus,
      };
}
