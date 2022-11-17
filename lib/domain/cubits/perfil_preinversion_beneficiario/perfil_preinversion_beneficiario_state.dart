part of 'perfil_preinversion_beneficiario_cubit.dart';

abstract class PerfilPreInversionBeneficiarioState extends Equatable {
  final PerfilPreInversionBeneficiarioEntity? perfilPreInversionBeneficiario;
  const PerfilPreInversionBeneficiarioState(
      {this.perfilPreInversionBeneficiario});

  @override
  List<Object?> get props => [perfilPreInversionBeneficiario];
}

class PerfilPreInversionBeneficiarioInitial
    extends PerfilPreInversionBeneficiarioState {
  PerfilPreInversionBeneficiarioInitial()
      : super(
            perfilPreInversionBeneficiario:
                PerfilPreInversionBeneficiarioEntity(
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
                    conyugeNombre: '',
                    conyugeApellido: '',
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
                    cedulaCatastral: ''));
}

class PerfilPreInversionBeneficiarioLoading
    extends PerfilPreInversionBeneficiarioState {}

class PerfilPreInversionBeneficiarioLoaded
    extends PerfilPreInversionBeneficiarioState {
  final PerfilPreInversionBeneficiarioEntity?
      perfilPreInversionBeneficiarioLoaded;

  const PerfilPreInversionBeneficiarioLoaded(
      this.perfilPreInversionBeneficiarioLoaded)
      : super(
            perfilPreInversionBeneficiario:
                perfilPreInversionBeneficiarioLoaded);
}

class PerfilPreInversionBeneficiarioError
    extends PerfilPreInversionBeneficiarioState {
  final String message;

  const PerfilPreInversionBeneficiarioError(this.message);

  @override
  List<Object?> get props => [message];
}
