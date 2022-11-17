import 'package:paap/domain/usecases/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_exports.dart';

class PerfilPreInversionBeneficiarioModel
    extends PerfilPreInversionBeneficiarioEntity {
  PerfilPreInversionBeneficiarioModel({
    required String perfilPreInversionId,
    required String beneficiarioId,
    required String municipioId,
    required String veredaId,
    String? areaFinca,
    String? areaProyecto,
    required String tipoTenenciaId,
    String? experiencia,
    String? asociado,
    String? conocePerfil,
    String? fueBeneficiado,
    String? cualBeneficio,
    String? activo,
    String? miembrosHogar,
    String? miembrosEcoActivos,
    required String residenciaId,
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
    required String nivelEscolarId,
    String? cotizanteBeps,
    required String estadoCivilId,
    String? calificacionSisben,
    String? ingresosMensuales,
    required String tipoDiscapacidadId,
    required String conyugeTipoIdentificacionId,
    required String conyugeId,
    String? conyugeNombre1,
    String? conyugeNombre2,
    String? conyugeApellido1,
    String? conyugeApellido2,
    required String conyugeGeneroId,
    String? conyugeFechaExpedicionDocumento,
    required String conyugeGrupoEspecialId,
    String? conyugeFechaNacimiento,
    String? conyugeIngresosMensuales,
    required String actividadEconomicaId,
    String? ingresosDiarios,
    String? diasTrabajo,
    String? longitud,
    String? latitud,
    String? cedulaCatastral,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          beneficiarioId: beneficiarioId,
          municipioId: municipioId,
          veredaId: veredaId,
          areaFinca: areaFinca ?? '',
          areaProyecto: areaProyecto ?? '',
          tipoTenenciaId: tipoTenenciaId,
          experiencia: experiencia ?? '',
          asociado: asociado ?? '',
          conocePerfil: conocePerfil ?? '',
          fueBeneficiado: fueBeneficiado ?? '',
          cualBeneficio: cualBeneficio ?? '',
          activo: activo ?? '',
          miembrosHogar: miembrosHogar ?? '',
          miembrosEcoActivos: miembrosEcoActivos ?? '',
          residenciaId: residenciaId,
          accesoExplotacionTierra: accesoExplotacionTierra ?? '',
          gastosMensuales: gastosMensuales ?? '',
          mesesAsociado: mesesAsociado ?? '',
          nombreOrganizacion: nombreOrganizacion ?? '',
          activoInmobiliario: activoInmobiliario ?? '',
          activoFinanciero: activoFinanciero ?? '',
          activoProductivo: activoProductivo ?? '',
          activoCorriente: activoCorriente ?? '',
          nota: nota ?? '',
          nombreFinca: nombreFinca ?? '',
          nivelEscolarId: nivelEscolarId,
          cotizanteBeps: cotizanteBeps ?? '',
          estadoCivilId: estadoCivilId,
          calificacionSisben: calificacionSisben ?? '',
          ingresosMensuales: ingresosMensuales ?? '',
          tipoDiscapacidadId: tipoDiscapacidadId,
          conyugeTipoIdentificacionId: conyugeTipoIdentificacionId,
          conyugeId: conyugeId,
          conyugeNombre1: conyugeNombre1 ?? '',
          conyugeNombre2: conyugeNombre2 ?? '',
          conyugeApellido1: conyugeApellido1 ?? '',
          conyugeApellido2: conyugeApellido2 ?? '',
          conyugeGeneroId: conyugeGeneroId,
          conyugeFechaExpedicionDocumento:
              conyugeFechaExpedicionDocumento ?? '',
          conyugeGrupoEspecialId: conyugeGrupoEspecialId,
          conyugeFechaNacimiento: conyugeFechaNacimiento ?? '',
          conyugeIngresosMensuales: conyugeIngresosMensuales ?? '',
          actividadEconomicaId: actividadEconomicaId,
          ingresosDiarios: ingresosDiarios ?? '',
          diasTrabajo: diasTrabajo ?? '',
          longitud: longitud ?? '',
          latitud: latitud ?? '',
          cedulaCatastral: cedulaCatastral ?? '',
          recordStatus: recordStatus ?? '',
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
        recordStatus: json["RecordStatus"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
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
        "NivelEscolarId": nivelEscolarId,
        "CotizanteBEPS": cotizanteBeps,
        "EstadoCivilId": estadoCivilId,
        "CalificacionSISBEN": calificacionSisben,
        "IngresosMensuales": ingresosMensuales,
        "TipoDiscapacidadId": tipoDiscapacidadId,
        "ConyugeTipoIdentificacionId": conyugeTipoIdentificacionId,
        "ConyugeId": conyugeId,
        "ConyugeNombre1": conyugeNombre1,
        "ConyugeNombre2": conyugeNombre2,
        "ConyugeApellido1": conyugeApellido1,
        "ConyugeApellido2": conyugeApellido2,
        "ConyugeGeneroId": conyugeGeneroId,
        "ConyugeFechaExpedicionDocumento": conyugeFechaExpedicionDocumento,
        "ConyugeGrupoEspecialId": conyugeGrupoEspecialId,
        "ConyugeFechaNacimiento": conyugeFechaNacimiento,
        "ConyugeIngresosMensuales": conyugeIngresosMensuales,
        "ActividadEconomicaId": actividadEconomicaId,
        "IngresosDiarios": ingresosDiarios,
        "DiasTrabajo": diasTrabajo,
        "Longitud": longitud,
        "Latitud": latitud,
        "CedulaCatastral": cedulaCatastral,
        "RecordStatus": recordStatus,
      };
}
