part of 'alianza_beneficiario_cubit.dart';

abstract class AlianzaBeneficiarioState extends Equatable {
  final AlianzaBeneficiarioEntity alianzaBeneficiario;
  const AlianzaBeneficiarioState({required this.alianzaBeneficiario});

  @override
  List<Object?> get props => [alianzaBeneficiario];
}

class AlianzaBeneficiarioInitial extends AlianzaBeneficiarioState {
  AlianzaBeneficiarioInitial() : super(alianzaBeneficiario: initObject());
}

class AlianzaBeneficiarioLoaded extends AlianzaBeneficiarioState {
  final AlianzaBeneficiarioEntity alianzaBeneficiarioLoaded;

  const AlianzaBeneficiarioLoaded(this.alianzaBeneficiarioLoaded)
      : super(alianzaBeneficiario: alianzaBeneficiarioLoaded);
}

class AlianzaBeneficiarioChanged extends AlianzaBeneficiarioState {
  final AlianzaBeneficiarioEntity alianzaBeneficiarioChanged;

  const AlianzaBeneficiarioChanged(this.alianzaBeneficiarioChanged)
      : super(alianzaBeneficiario: alianzaBeneficiarioChanged);
}

class AlianzaBeneficiarioSaved extends AlianzaBeneficiarioState {
  const AlianzaBeneficiarioSaved({required super.alianzaBeneficiario});
}

class AlianzaBeneficiarioError extends AlianzaBeneficiarioState {
  final String message;

  AlianzaBeneficiarioError(this.message)
      : super(alianzaBeneficiario: initObject());
  @override
  List<Object?> get props => [message];
}

AlianzaBeneficiarioEntity initObject() {
  return AlianzaBeneficiarioEntity(
      alianzaId: '',
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
