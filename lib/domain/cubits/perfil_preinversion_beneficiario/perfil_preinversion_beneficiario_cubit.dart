import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_beneficiario_entity.dart';
import '../../usecases/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_db_usecase.dart';

part '../perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_state.dart';

class PerfilPreInversionBeneficiarioCubit
    extends Cubit<PerfilPreInversionBeneficiarioState> {
  final PerfilPreInversionBeneficiarioUsecaseDB
      perfilPreInversionBeneficiarioDB;

  PerfilPreInversionBeneficiarioCubit(
      {required this.perfilPreInversionBeneficiarioDB})
      : super(PerfilPreInversionBeneficiarioInitial());

  void getPerfilPreInversionBeneficiarioDB(String id) async {
    final result = await perfilPreInversionBeneficiarioDB
        .getPerfilPreInversionBeneficiarioUsecaseDB(id);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionBeneficiarioError(failure.properties.first)),
        (data) => emit(PerfilPreInversionBeneficiarioLoaded(data)));
  }

  void initState() => emit(PerfilPreInversionBeneficiarioInitial());

  void changeResidencia(String? value) {
    final residenciaChanged =
        state.perfilPreInversionBeneficiario!.copyWith(residenciaId: value);
    emit(PerfilPreInversionBeneficiarioLoaded(residenciaChanged));
  }

  void changeNivelEscolar(String? value) {
    final nivelEscolarChanged =
        state.perfilPreInversionBeneficiario!.copyWith(nivelEscolarId: value);
    emit(PerfilPreInversionBeneficiarioLoaded(nivelEscolarChanged));
  }

  void changeActividadEconomica(String? value) {
    final actividadEconomicaChanged = state.perfilPreInversionBeneficiario!
        .copyWith(actividadEconomicaId: value);
    emit(PerfilPreInversionBeneficiarioLoaded(actividadEconomicaChanged));
  }

  void changeIngresosDiarios(String? newValue) {
    final ingresosDiariosChanged = state.perfilPreInversionBeneficiario!
        .copyWith(ingresosDiarios: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(ingresosDiariosChanged));
  }

  void changeDiasTrabajados(String? newValue) {
    final dasTrabajadosChanged =
        state.perfilPreInversionBeneficiario!.copyWith(diasTrabajo: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(dasTrabajadosChanged));
  }

  void changeMiembrosHogar(String? newValue) {
    final miembrosHogarChanged =
        state.perfilPreInversionBeneficiario!.copyWith(miembrosHogar: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(miembrosHogarChanged));
  }

  void changeMiembrosEcoActivos(String? newValue) {
    final miembrosEcoActivosChanged = state.perfilPreInversionBeneficiario!
        .copyWith(miembrosEcoActivos: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(miembrosEcoActivosChanged));
  }

  void changeIngresosMensuales(String? newValue) {
    final ingresosMensualesChanged = state.perfilPreInversionBeneficiario!
        .copyWith(ingresosMensuales: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(ingresosMensualesChanged));
  }

  void changeGastosMensuales(String? newValue) {
    final gastosMensualesChanged = state.perfilPreInversionBeneficiario!
        .copyWith(gastosMensuales: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(gastosMensualesChanged));
  }

  void changeActivoInmobiliario(String? newValue) {
    final activoInmobiliarioChanged = state.perfilPreInversionBeneficiario!
        .copyWith(activoInmobiliario: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(activoInmobiliarioChanged));
  }

  void changeActivoFinanciero(String? newValue) {
    final activoFinancieroChanged = state.perfilPreInversionBeneficiario!
        .copyWith(activoFinanciero: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(activoFinancieroChanged));
  }

  void changeActivoProductivo(String? newValue) {
    final activoProductivoChanged = state.perfilPreInversionBeneficiario!
        .copyWith(activoProductivo: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(activoProductivoChanged));
  }

  void changeActivoCorriente(String? newValue) {
    final activoCorrienteChanged = state.perfilPreInversionBeneficiario!
        .copyWith(activoCorriente: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(activoCorrienteChanged));
  }

  void changeActivo(String? newValue) {
    final totalActivoChanged =
        state.perfilPreInversionBeneficiario!.copyWith(activo: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(totalActivoChanged));
  }

  void changeNombreFinca(String? newValue) {
    final nombreFincaChanged =
        state.perfilPreInversionBeneficiario!.copyWith(nombreFinca: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(nombreFincaChanged));
  }

  void changeNombreOrganizacion(String? newValue) {
    final nombreOrganizacionChanged = state.perfilPreInversionBeneficiario!
        .copyWith(nombreOrganizacion: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(nombreOrganizacionChanged));
  }

  void changeMesesAsociado(String? newValue) {
    final mesesAsociacionChanged =
        state.perfilPreInversionBeneficiario!.copyWith(mesesAsociado: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(mesesAsociacionChanged));
  }

  void changeNota(String? newValue) {
    final notaChanged =
        state.perfilPreInversionBeneficiario!.copyWith(nota: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(notaChanged));
  }

  void changeEstadoCivil(String? value) {
    final estadoCivilChanged =
        state.perfilPreInversionBeneficiario!.copyWith(estadoCivilId: value);
    emit(PerfilPreInversionBeneficiarioLoaded(estadoCivilChanged));
  }

  void changeDiscapacidad(String? value) {
    final discapacidadChanged = state.perfilPreInversionBeneficiario!
        .copyWith(tipoDiscapacidadId: value);
    emit(PerfilPreInversionBeneficiarioLoaded(discapacidadChanged));
  }

  void changeConyugeTipoIdentificacion(String? value) {
    final conyugeTipoDocumentoChanged = state.perfilPreInversionBeneficiario!
        .copyWith(conyugeTipoIdentificacionId: value);
    emit(PerfilPreInversionBeneficiarioLoaded(conyugeTipoDocumentoChanged));
  }

  void changeConyugeDocumento(String? newValue) {
    final conyugeDocumentoChanged =
        state.perfilPreInversionBeneficiario!.copyWith(conyugeId: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(conyugeDocumentoChanged));
  }

  void changeConyugeFechaExpedicion(String text) {
    final conyugeFechaExpedicionChanged =
        state.perfilPreInversionBeneficiario!.copyWith(diasTrabajo: text);
    emit(PerfilPreInversionBeneficiarioLoaded(conyugeFechaExpedicionChanged));
  }

  void changeConyugeNombre(String? newValue) {
    final conyugeNombreChanged =
        state.perfilPreInversionBeneficiario!.copyWith(conyugeNombre: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(conyugeNombreChanged));
  }

  void changeConyugeApellido(String? newValue) {
    final conyugeApellidoChanged = state.perfilPreInversionBeneficiario!
        .copyWith(conyugeApellido: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(conyugeApellidoChanged));
  }

  void changeConyugeGenero(String? value) {
    final conyugeGeneroChanged =
        state.perfilPreInversionBeneficiario!.copyWith(conyugeGeneroId: value);
    emit(PerfilPreInversionBeneficiarioLoaded(conyugeGeneroChanged));
  }

  void changeConyugeFechaNacimiento(String text) {
    final conyugeFechaNacimientoChanged = state.perfilPreInversionBeneficiario!
        .copyWith(conyugeFechaNacimiento: text);
    emit(PerfilPreInversionBeneficiarioLoaded(conyugeFechaNacimientoChanged));
  }

  void changeConyugeGrupoEspecial(String? value) {
    final conyugeGrupoEspecialChanged = state.perfilPreInversionBeneficiario!
        .copyWith(conyugeGrupoEspecialId: value);
    emit(PerfilPreInversionBeneficiarioLoaded(conyugeGrupoEspecialChanged));
  }

  void changeCalificacionSisben(String? newValue) {
    final calificacionSisbenChanged = state.perfilPreInversionBeneficiario!
        .copyWith(calificacionSisben: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(calificacionSisbenChanged));
  }

  void changeLatitud(String? newValue) {
    final latitudChanged =
        state.perfilPreInversionBeneficiario!.copyWith(latitud: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(latitudChanged));
  }

  void changeExperiencia(String? newValue) {
    final experienciaChanged =
        state.perfilPreInversionBeneficiario!.copyWith(experiencia: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(experienciaChanged));
  }

  void changeLongitud(String? newValue) {
    final longitudChanged =
        state.perfilPreInversionBeneficiario!.copyWith(longitud: newValue);
    emit(PerfilPreInversionBeneficiarioLoaded(longitudChanged));
  }

  void changeCotizanteBeps(bool? value) {
    final cotizanteBepsChanged = state.perfilPreInversionBeneficiario!
        .copyWith(cotizanteBeps: value.toString());
    emit(PerfilPreInversionBeneficiarioLoaded(cotizanteBepsChanged));
  }
}
