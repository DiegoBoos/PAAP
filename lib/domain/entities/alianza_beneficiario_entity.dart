class AlianzaBeneficiarioEntity {
  AlianzaBeneficiarioEntity({
    required this.alianzaId,
    required this.beneficiarioId,
    required this.municipioId,
    required this.veredaId,
    required this.areaFinca,
    required this.areaProyecto,
    required this.tipoTenenciaId,
    required this.experiencia,
    required this.asociado,
    required this.conocePerfil,
    required this.fueBeneficiado,
    required this.cualBeneficio,
    required this.activo,
    required this.miembrosHogar,
    required this.miembrosEcoActivos,
    required this.residenciaId,
    required this.accesoExplotacionTierra,
    required this.gastosMensuales,
    required this.mesesAsociado,
    required this.nombreOrganizacion,
    required this.activoInmobiliario,
    required this.activoFinanciero,
    required this.activoProductivo,
    required this.activoCorriente,
    required this.nota,
    required this.nombreFinca,
    required this.tipoDiscapacidadId,
    required this.nivelEscolarId,
    required this.cotizanteBeps,
    required this.estadoCivilId,
    required this.conyugeNombre1,
    required this.conyugeFechaNacimiento,
    required this.conyugeIngresosMensuales,
    required this.calificacionSisben,
    required this.ingresosMensuales,
    required this.conyugeNombre2,
    required this.conyugeApellido1,
    required this.conyugeApellido2,
    required this.conyugeGeneroId,
    required this.conyugeFechaExpedicionDocumento,
    required this.conyugeGrupoEspecialId,
    required this.actividadEconomicaId,
    required this.ingresosDiarios,
    required this.diasTrabajo,
    required this.conyugeTipoIdentificacionId,
    required this.conyugeId,
    required this.longitud,
    required this.latitud,
    required this.cedulaCatastral,
    required this.beneficioId,
    //OTROS
    this.documento,
    this.tipoDocumento,
    this.nombre,
    this.edad,
    this.genero,
    this.grupoEspecial,
    this.ubicacion,
    required this.recordStatus,
  });

  String alianzaId;
  String beneficiarioId;
  String municipioId;
  String veredaId;
  String areaFinca;
  String areaProyecto;
  String tipoTenenciaId;
  String experiencia;
  String asociado;
  String conocePerfil;
  String fueBeneficiado;
  String cualBeneficio;
  String activo;
  String miembrosHogar;
  String miembrosEcoActivos;
  String residenciaId;
  String accesoExplotacionTierra;
  String gastosMensuales;
  String mesesAsociado;
  String nombreOrganizacion;
  String activoInmobiliario;
  String activoFinanciero;
  String activoProductivo;
  String activoCorriente;
  String nota;
  String nombreFinca;
  String tipoDiscapacidadId;
  String nivelEscolarId;
  String cotizanteBeps;
  String estadoCivilId;
  String conyugeNombre1;
  String conyugeFechaNacimiento;
  String conyugeIngresosMensuales;
  String calificacionSisben;
  String ingresosMensuales;
  String conyugeNombre2;
  String conyugeApellido1;
  String conyugeApellido2;
  String conyugeGeneroId;
  String conyugeFechaExpedicionDocumento;
  String conyugeGrupoEspecialId;
  String actividadEconomicaId;
  String ingresosDiarios;
  String diasTrabajo;
  String conyugeTipoIdentificacionId;
  String conyugeId;
  String longitud;
  String latitud;
  String cedulaCatastral;
  String beneficioId;
  String? documento;
  String? tipoDocumento;
  String? nombre;
  String? edad;
  String? genero;
  String? grupoEspecial;
  String? ubicacion;
  String recordStatus;

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

  factory AlianzaBeneficiarioEntity.fromJson(Map<String, dynamic> json) =>
      AlianzaBeneficiarioEntity(
        alianzaId: json["AlianzaId"],
        beneficiarioId: json["BeneficiarioId"],
        municipioId: json["MunicipioId"],
        veredaId: json["VeredaId"],
        areaFinca: json["AreaFinca"],
        areaProyecto: json["AreaProyecto"],
        tipoTenenciaId: json["TipoTenenciaId"],
        experiencia: json["Experiencia"],
        asociado: json["Asociado"],
        conocePerfil: json["ConocePerfil"],
        fueBeneficiado: json["FueBeneficiado"],
        cualBeneficio: json["CualBeneficio"],
        activo: json["Activo"],
        miembrosHogar: json["MiembrosHogar"],
        miembrosEcoActivos: json["MiembrosEcoActivos"],
        residenciaId: json["ResidenciaId"],
        accesoExplotacionTierra: json["AccesoExplotacionTierra"],
        gastosMensuales: json["GastosMensuales"],
        mesesAsociado: json["MesesAsociado"],
        nombreOrganizacion: json["NombreOrganizacion"],
        activoInmobiliario: json["ActivoInmobiliario"],
        activoFinanciero: json["ActivoFinanciero"],
        activoProductivo: json["ActivoProductivo"],
        activoCorriente: json["ActivoCorriente"],
        nota: json["Nota"],
        nombreFinca: json["NombreFinca"],
        tipoDiscapacidadId: json["TipoDiscapacidadId"],
        nivelEscolarId: json["NivelEscolarId"],
        cotizanteBeps: json["CotizanteBeps"],
        estadoCivilId: json["EstadoCivilId"],
        conyugeNombre1: json["ConyugeNombre1"],
        conyugeFechaNacimiento: json["ConyugeFechaNacimiento"],
        conyugeIngresosMensuales: json["ConyugeIngresosMensuales"],
        calificacionSisben: json["CalificacionSisben"],
        ingresosMensuales: json["IngresosMensuales"],
        conyugeNombre2: json["ConyugeNombre2"],
        conyugeApellido1: json["ConyugeApellido1"],
        conyugeApellido2: json["ConyugeApellido2"],
        conyugeGeneroId: json["ConyugeGeneroId"],
        conyugeFechaExpedicionDocumento:
            json["ConyugeFechaExpedicionDocumento"],
        conyugeGrupoEspecialId: json["ConyugeGrupoEspecialId"],
        actividadEconomicaId: json["ActividadEconomicaId"],
        ingresosDiarios: json["IngresosDiarios"],
        diasTrabajo: json["DiasTrabajo"],
        conyugeTipoIdentificacionId: json["ConyugeTipoIdentificacionId"],
        conyugeId: json["ConyugeId"],
        longitud: json["Longitud"],
        latitud: json["Latitud"],
        cedulaCatastral: json["CedulaCatastral"],
        beneficioId: json["BeneficioId"],
        recordStatus: json["RecordStatus"],
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
        "CalificacionSisben": calificacionSisben,
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
