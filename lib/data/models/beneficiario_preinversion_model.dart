import 'package:paap/domain/usecases/beneficiario_preinversion/beneficiario_preinversion_exports.dart';

class BeneficiarioPreinversionModel extends BeneficiarioPreinversionEntity {
  BeneficiarioPreinversionModel(
      {required String perfilPreInversionId,
      required String beneficiarioId,
      required String municipioId,
      required String veredaId,
      required String areaFinca,
      required String areaProyecto,
      required String tipoTenenciaId,
      required String experiencia,
      required String asociado,
      required String conocePerfil,
      required String fueBeneficiado,
      required String cualBeneficio,
      required String activo,
      required String miembrosHogar,
      required String miembrosEcoActivos,
      required String residenciaId,
      required String accesoExplotacionTierra,
      required String gastosMensuales,
      required String mesesAsociado,
      required String nombreOrganizacion,
      required String activoInmobiliario,
      required String activoFinanciero,
      required String activoProductivo,
      required String activoCorriente,
      required String nota,
      required String nombreFinca,
      required String nivelEscolarId,
      required String cotizanteBeps,
      required String estadoCivilId,
      required String calificacionSisben,
      required String ingresosMensuales,
      required String tipoDiscapacidadId,
      required String conyugeTipoIdentificacionId,
      required String conyugeId,
      required String conyugeNombre,
      required String conyugeApellido,
      required String conyugeGeneroId,
      required String conyugeFechaExpedicionDocumento,
      required String conyugeGrupoEspecialId,
      required String conyugeFechaNacimiento,
      required String conyugeIngresosMensuales,
      required String actividadEconomicaId,
      required String ingresosDiarios,
      required String diasTrabajo,
      required String longitud,
      required String latitud,
      required String cedulaCatastral})
      : super(
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
            conyugeNombre: conyugeNombre,
            conyugeApellido: conyugeApellido,
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
            cedulaCatastral: cedulaCatastral);

  factory BeneficiarioPreinversionModel.fromJson(Map<String, dynamic> json) =>
      BeneficiarioPreinversionModel(
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
        conyugeNombre: json["ConyugeNombre"],
        conyugeApellido: json["ConyugeApellido"],
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
        "ConyugeNombre": conyugeNombre,
        "ConyugeApellido": conyugeApellido,
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
      };
}
