import '../../domain/entities/perfil_preinversion_beneficiario_entity.dart';

class PerfilPreInversionBeneficiarioModel
    extends PerfilPreInversionBeneficiarioEntity {
  PerfilPreInversionBeneficiarioModel({
    required String perfilPreInversionId,
    required String beneficiarioId,
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
    String? beneficioId,
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
    String? nivelEscolarId,
    String? cotizanteBeps,
    String? estadoCivilId,
    String? calificacionSisben,
    String? ingresosMensuales,
    String? tipoDiscapacidadId,
    String? conyugeTipoIdentificacionId,
    String? conyugeId,
    String? conyugeNombre1,
    String? conyugeNombre2,
    String? conyugeApellido1,
    String? conyugeApellido2,
    String? conyugeGeneroId,
    String? conyugeFechaExpedicionDocumento,
    String? conyugeGrupoEspecialId,
    String? conyugeFechaNacimiento,
    String? conyugeIngresosMensuales,
    String? actividadEconomicaId,
    String? ingresosDiarios,
    String? diasTrabajo,
    String? longitud,
    String? latitud,
    String? cedulaCatastral,
    String? documento,
    String? tipoDocumento,
    String? nombre,
    String? edad,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          beneficiarioId: beneficiarioId,
          municipioId: municipioId,
          veredaId: veredaId,
          areaFinca: areaFinca,
          areaProyecto: areaProyecto,
          tipoTenenciaId: tipoTenenciaId,
          experiencia: experiencia,
          asociado: asociado,
          conocePerfil: conocePerfil,
          fueBeneficiado: fueBeneficiado,
          cualBeneficio: cualBeneficio,
          beneficioId: beneficioId,
          activo: activo,
          miembrosHogar: miembrosHogar,
          miembrosEcoActivos: miembrosEcoActivos,
          residenciaId: residenciaId,
          accesoExplotacionTierra: accesoExplotacionTierra,
          gastosMensuales: gastosMensuales,
          mesesAsociado: mesesAsociado,
          nombreOrganizacion: nombreOrganizacion,
          activoInmobiliario: activoInmobiliario,
          activoFinanciero: activoFinanciero,
          activoProductivo: activoProductivo,
          activoCorriente: activoCorriente,
          nota: nota,
          nombreFinca: nombreFinca,
          nivelEscolarId: nivelEscolarId,
          cotizanteBeps: cotizanteBeps,
          estadoCivilId: estadoCivilId,
          calificacionSisben: calificacionSisben,
          ingresosMensuales: ingresosMensuales,
          tipoDiscapacidadId: tipoDiscapacidadId,
          conyugeTipoIdentificacionId: conyugeTipoIdentificacionId,
          conyugeId: conyugeId,
          conyugeNombre1: conyugeNombre1,
          conyugeNombre2: conyugeNombre2,
          conyugeApellido1: conyugeApellido1,
          conyugeApellido2: conyugeApellido2,
          conyugeGeneroId: conyugeGeneroId,
          conyugeFechaExpedicionDocumento: conyugeFechaExpedicionDocumento,
          conyugeGrupoEspecialId: conyugeGrupoEspecialId,
          conyugeFechaNacimiento: conyugeFechaNacimiento,
          conyugeIngresosMensuales: conyugeIngresosMensuales,
          actividadEconomicaId: actividadEconomicaId,
          ingresosDiarios: ingresosDiarios,
          diasTrabajo: diasTrabajo,
          longitud: longitud,
          latitud: latitud,
          cedulaCatastral: cedulaCatastral,
          nombre: nombre,
          edad: edad,
          recordStatus: recordStatus,
        );

  factory PerfilPreInversionBeneficiarioModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionBeneficiarioModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
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
        beneficioId: json["BeneficioId"],
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
        nivelEscolarId: json["NivelEscolarId"],
        cotizanteBeps: json["CotizanteBEPS"],
        estadoCivilId: json["EstadoCivilId"],
        calificacionSisben: json["CalificacionSISBEN"],
        ingresosMensuales: json["IngresosMensuales"],
        tipoDiscapacidadId: json["TipoDiscapacidadId"],
        conyugeTipoIdentificacionId: json["ConyugeTipoIdentificacionId"],
        conyugeId: json["ConyugeId"],
        conyugeNombre1: json["ConyugeNombre1"],
        conyugeNombre2: json["ConyugeNombre2"],
        conyugeApellido1: json["ConyugeApellido1"],
        conyugeApellido2: json["ConyugeApellido2"],
        conyugeGeneroId: json["ConyugeGeneroId"],
        conyugeFechaExpedicionDocumento:
            json["ConyugeFechaExpedicionDocumento"],
        conyugeGrupoEspecialId: json["ConyugeGrupoEspecialId"],
        conyugeFechaNacimiento: json["ConyugeFechaNacimiento"],
        conyugeIngresosMensuales: json["ConyugeIngresosMensuales"],
        actividadEconomicaId: json["ActividadEconomicaId"],
        ingresosDiarios: json["IngresosDiarios"],
        diasTrabajo: json["DiasTrabajo"],
        longitud: json["Longitud"],
        latitud: json["Latitud"],
        cedulaCatastral: json["CedulaCatastral"],
        documento: json["Documento"],
        tipoDocumento: json["TipoDocumento"],
        nombre: json["Nombre"],
        edad: json["Edad"].toString(),
        recordStatus: json["RecordStatus"],
      );
}
