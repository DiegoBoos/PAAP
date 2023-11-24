class AlianzaBeneficiarioEntity {
  AlianzaBeneficiarioEntity({
    this.alianzaId,
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
    this.miembrosHogar,
    this.miembrosEcoActivos,
    this.residenciaId,
    this.accesoExplotacionTierra,
    this.gastosMensuales,
    this.mesesAsociado,
    this.nombreOrganizacion,
    this.activoInmobiliario,
    this.activoFinanciero,
    this.activoProductivo,
    this.activoCorriente,
    this.nota,
    this.nombreFinca,
    this.tipoDiscapacidadId,
    this.nivelEscolarId,
    this.cotizanteBeps,
    this.estadoCivilId,
    this.conyugeNombre1,
    this.conyugeFechaNacimiento,
    this.conyugeIngresosMensuales,
    this.calificacionSisben,
    this.ingresosMensuales,
    this.conyugeNombre2,
    this.conyugeApellido1,
    this.conyugeApellido2,
    this.conyugeGeneroId,
    this.conyugeFechaExpedicionDocumento,
    this.conyugeGrupoEspecialId,
    this.actividadEconomicaId,
    this.ingresosDiarios,
    this.diasTrabajo,
    this.conyugeTipoIdentificacionId,
    this.conyugeId,
    this.longitud,
    this.latitud,
    this.cedulaCatastral,
    this.beneficioId,
    this.recordStatus,
    //OTROS
    this.nombre,
    this.edad,
  });

  String? alianzaId;
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
  String? miembrosHogar;
  String? miembrosEcoActivos;
  String? residenciaId;
  String? accesoExplotacionTierra;
  String? gastosMensuales;
  String? mesesAsociado;
  String? nombreOrganizacion;
  String? activoInmobiliario;
  String? activoFinanciero;
  String? activoProductivo;
  String? activoCorriente;
  String? nota;
  String? nombreFinca;
  String? tipoDiscapacidadId;
  String? nivelEscolarId;
  String? cotizanteBeps;
  String? estadoCivilId;
  String? conyugeNombre1;
  String? conyugeFechaNacimiento;
  String? conyugeIngresosMensuales;
  String? calificacionSisben;
  String? ingresosMensuales;
  String? conyugeNombre2;
  String? conyugeApellido1;
  String? conyugeApellido2;
  String? conyugeGeneroId;
  String? conyugeFechaExpedicionDocumento;
  String? conyugeGrupoEspecialId;
  String? actividadEconomicaId;
  String? ingresosDiarios;
  String? diasTrabajo;
  String? conyugeTipoIdentificacionId;
  String? conyugeId;
  String? longitud;
  String? latitud;
  String? cedulaCatastral;
  String? beneficioId;
  String? recordStatus;
  String? nombre;
  String? edad;

  AlianzaBeneficiarioEntity copyWith({
    String? alianzaId,
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
    String? miembrosHogar,
    String? miembrosEcoActivos,
    String? residenciaId,
    String? accesoExplotacionTierra,
    String? gastosMensuales,
    String? mesesAsociado,
    String? nombreOrganizacion,
    String? activoInmobiliario,
    String? activoFinanciero,
    String? activoProductivo,
    String? activoCorriente,
    String? nota,
    String? nombreFinca,
    String? tipoDiscapacidadId,
    String? nivelEscolarId,
    String? cotizanteBeps,
    String? estadoCivilId,
    String? conyugeNombre1,
    String? conyugeFechaNacimiento,
    String? conyugeIngresosMensuales,
    String? calificacionSisben,
    String? ingresosMensuales,
    String? conyugeNombre2,
    String? conyugeApellido1,
    String? conyugeApellido2,
    String? conyugeGeneroId,
    String? conyugeFechaExpedicionDocumento,
    String? conyugeGrupoEspecialId,
    String? actividadEconomicaId,
    String? ingresosDiarios,
    String? diasTrabajo,
    String? conyugeTipoIdentificacionId,
    String? conyugeId,
    String? longitud,
    String? latitud,
    String? cedulaCatastral,
    String? beneficioId,
    String? recordStatus,
  }) =>
      AlianzaBeneficiarioEntity(
        alianzaId: alianzaId ?? this.alianzaId,
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
        miembrosHogar: miembrosHogar ?? this.miembrosHogar,
        miembrosEcoActivos: miembrosEcoActivos ?? this.miembrosEcoActivos,
        residenciaId: residenciaId ?? this.residenciaId,
        accesoExplotacionTierra:
            accesoExplotacionTierra ?? this.accesoExplotacionTierra,
        gastosMensuales: gastosMensuales ?? this.gastosMensuales,
        mesesAsociado: mesesAsociado ?? this.mesesAsociado,
        nombreOrganizacion: nombreOrganizacion ?? this.nombreOrganizacion,
        activoInmobiliario: activoInmobiliario ?? this.activoInmobiliario,
        activoFinanciero: activoFinanciero ?? this.activoFinanciero,
        activoProductivo: activoProductivo ?? this.activoProductivo,
        activoCorriente: activoCorriente ?? this.activoCorriente,
        nota: nota ?? this.nota,
        nombreFinca: nombreFinca ?? this.nombreFinca,
        tipoDiscapacidadId: tipoDiscapacidadId ?? this.tipoDiscapacidadId,
        nivelEscolarId: nivelEscolarId ?? this.nivelEscolarId,
        cotizanteBeps: cotizanteBeps ?? this.cotizanteBeps,
        estadoCivilId: estadoCivilId ?? this.estadoCivilId,
        conyugeNombre1: conyugeNombre1 ?? this.conyugeNombre1,
        conyugeFechaNacimiento:
            conyugeFechaNacimiento ?? this.conyugeFechaNacimiento,
        conyugeIngresosMensuales:
            conyugeIngresosMensuales ?? this.conyugeIngresosMensuales,
        calificacionSisben: calificacionSisben ?? this.calificacionSisben,
        ingresosMensuales: ingresosMensuales ?? this.ingresosMensuales,
        conyugeNombre2: conyugeNombre2 ?? this.conyugeNombre2,
        conyugeApellido1: conyugeApellido1 ?? this.conyugeApellido1,
        conyugeApellido2: conyugeApellido2 ?? this.conyugeApellido2,
        conyugeGeneroId: conyugeGeneroId ?? this.conyugeGeneroId,
        conyugeFechaExpedicionDocumento: conyugeFechaExpedicionDocumento ??
            this.conyugeFechaExpedicionDocumento,
        conyugeGrupoEspecialId:
            conyugeGrupoEspecialId ?? this.conyugeGrupoEspecialId,
        actividadEconomicaId: actividadEconomicaId ?? this.actividadEconomicaId,
        ingresosDiarios: ingresosDiarios ?? this.ingresosDiarios,
        diasTrabajo: diasTrabajo ?? this.diasTrabajo,
        conyugeTipoIdentificacionId:
            conyugeTipoIdentificacionId ?? this.conyugeTipoIdentificacionId,
        conyugeId: conyugeId ?? this.conyugeId,
        longitud: longitud ?? this.longitud,
        latitud: latitud ?? this.latitud,
        cedulaCatastral: cedulaCatastral ?? this.cedulaCatastral,
        beneficioId: beneficioId ?? this.beneficioId,
        recordStatus: recordStatus ?? this.recordStatus,
      );

  Map<String, dynamic> toJson() => {
        "AlianzaId": alianzaId,
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
        "MiembrosHogar": miembrosHogar,
        "MiembrosEcoActivos": miembrosEcoActivos,
        "ResidenciaId": residenciaId,
        "AccesoExplotacionTierra": accesoExplotacionTierra,
        "GastosMensuales": gastosMensuales,
        "MesesAsociado": mesesAsociado,
        "NombreOrganizacion": nombreOrganizacion,
        "ActivoInmobiliario": activoInmobiliario,
        "ActivoFinanciero": activoFinanciero,
        "ActivoProductivo": activoProductivo,
        "ActivoCorriente": activoCorriente,
        "Nota": nota,
        "NombreFinca": nombreFinca,
        "TipoDiscapacidadId": tipoDiscapacidadId,
        "NivelEscolarId": nivelEscolarId,
        "CotizanteBeps": cotizanteBeps,
        "EstadoCivilId": estadoCivilId,
        "ConyugeNombre1": conyugeNombre1,
        "ConyugeFechaNacimiento": conyugeFechaNacimiento,
        "ConyugeIngresosMensuales": conyugeIngresosMensuales,
        "CalificacionSISBEN": calificacionSisben,
        "IngresosMensuales": ingresosMensuales,
        "ConyugeNombre2": conyugeNombre2,
        "ConyugeApellido1": conyugeApellido1,
        "ConyugeApellido2": conyugeApellido2,
        "ConyugeGeneroId": conyugeGeneroId,
        "ConyugeFechaExpedicionDocumento": conyugeFechaExpedicionDocumento,
        "ConyugeGrupoEspecialId": conyugeGrupoEspecialId,
        "ActividadEconomicaId": actividadEconomicaId,
        "IngresosDiarios": ingresosDiarios,
        "DiasTrabajo": diasTrabajo,
        "ConyugeTipoIdentificacionId": conyugeTipoIdentificacionId,
        "ConyugeId": conyugeId,
        "Longitud": longitud,
        "Latitud": latitud,
        "CedulaCatastral": cedulaCatastral,
        "BeneficioId": beneficioId,
        "RecordStatus": recordStatus,
      };
}
