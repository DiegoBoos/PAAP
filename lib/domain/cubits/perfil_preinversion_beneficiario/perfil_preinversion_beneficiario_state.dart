part of 'perfil_preinversion_beneficiario_cubit.dart';

abstract class PerfilPreInversionBeneficiarioState extends Equatable {
  final PerfilPreInversionBeneficiarioEntity perfilPreInversionBeneficiario;
  const PerfilPreInversionBeneficiarioState(
      {required this.perfilPreInversionBeneficiario});

  @override
  List<Object?> get props => [perfilPreInversionBeneficiario];
}

class PerfilPreInversionBeneficiarioInitial
    extends PerfilPreInversionBeneficiarioState {
  PerfilPreInversionBeneficiarioInitial()
      : super(perfilPreInversionBeneficiario: initObject());
}

class PerfilPreInversionBeneficiarioLoading
    extends PerfilPreInversionBeneficiarioState {
  const PerfilPreInversionBeneficiarioLoading(
      {required super.perfilPreInversionBeneficiario});
}

class PerfilPreInversionBeneficiarioLoaded
    extends PerfilPreInversionBeneficiarioState {
  final PerfilPreInversionBeneficiarioEntity
      perfilPreInversionBeneficiarioLoaded;

  const PerfilPreInversionBeneficiarioLoaded(
      this.perfilPreInversionBeneficiarioLoaded)
      : super(
            perfilPreInversionBeneficiario:
                perfilPreInversionBeneficiarioLoaded);
}

class PerfilPreInversionBeneficiarioChanged
    extends PerfilPreInversionBeneficiarioState {
  final PerfilPreInversionBeneficiarioEntity
      perfilPreInversionBeneficiarioChanged;

  const PerfilPreInversionBeneficiarioChanged(
      this.perfilPreInversionBeneficiarioChanged)
      : super(
            perfilPreInversionBeneficiario:
                perfilPreInversionBeneficiarioChanged);
}

class PerfilPreInversionBeneficiarioSaved
    extends PerfilPreInversionBeneficiarioState {
  const PerfilPreInversionBeneficiarioSaved(
      {required super.perfilPreInversionBeneficiario});
}

class PerfilPreInversionBeneficiarioError
    extends PerfilPreInversionBeneficiarioState {
  final String message;

  PerfilPreInversionBeneficiarioError(this.message)
      : super(perfilPreInversionBeneficiario: initObject());
  @override
  List<Object?> get props => [message];
}

PerfilPreInversionBeneficiarioEntity initObject() {
  return PerfilPreInversionBeneficiarioEntity(
      perfilPreInversionId: '',
      beneficiarioId: '',
      municipioId: '',
      veredaId: '',
      areaFinca: '',
      areaProyecto: '',
      tipoTenenciaId: '',
      experiencia: '',
      asociado: '',
      conocePerfil: '',
      fueBeneficiado: '',
      cualBeneficio: '',
      activo: '',
      miembrosHogar: '',
      miembrosEcoActivos: '',
      residenciaId: '',
      accesoExplotacionTierra: '',
      gastosMensuales: '',
      mesesAsociado: '',
      nombreOrganizacion: '',
      activoInmobiliario: '',
      activoFinanciero: '',
      activoProductivo: '',
      activoCorriente: '',
      nota: '',
      nombreFinca: '',
      nivelEscolarId: '',
      cotizanteBeps: '',
      estadoCivilId: '',
      calificacionSisben: '',
      ingresosMensuales: '',
      tipoDiscapacidadId: '',
      conyugeTipoIdentificacionId: '',
      conyugeId: '',
      conyugeNombre1: '',
      conyugeNombre2: '',
      conyugeApellido1: '',
      conyugeApellido2: '',
      conyugeGeneroId: '',
      conyugeFechaExpedicionDocumento: '',
      conyugeGrupoEspecialId: '',
      conyugeFechaNacimiento: '',
      conyugeIngresosMensuales: '',
      actividadEconomicaId: '',
      ingresosDiarios: '',
      diasTrabajo: '',
      longitud: '',
      latitud: '',
      cedulaCatastral: '',
      recordStatus: '');
}
