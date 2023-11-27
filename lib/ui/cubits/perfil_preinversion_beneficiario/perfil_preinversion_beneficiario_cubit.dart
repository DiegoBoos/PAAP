import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';
import '../../../domain/usecases/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_db_usecase.dart';

part '../perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_state.dart';

class PerfilPreInversionBeneficiarioCubit
    extends Cubit<PerfilPreInversionBeneficiarioState> {
  final PerfilPreInversionBeneficiarioUsecaseDB
      perfilPreInversionBeneficiarioDB;

  PerfilPreInversionBeneficiarioCubit(
      {required this.perfilPreInversionBeneficiarioDB})
      : super(PerfilPreInversionBeneficiarioInitial());

  void loadPerfilPreInversionBeneficiario(
      String perfilPreInversionId, String beneficiarioId) async {
    final result = await perfilPreInversionBeneficiarioDB
        .getPerfilPreInversionBeneficiarioUsecaseDB(
            perfilPreInversionId, beneficiarioId);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionBeneficiarioError(failure.properties.first)),
        (data) {
      if (data != null) {
        emit(PerfilPreInversionBeneficiarioLoaded(data));
      }
    });
  }

  void initState() => emit(PerfilPreInversionBeneficiarioInitial());

  void setPerfilPreInversionBeneficiario(
      PerfilPreInversionBeneficiarioEntity perfilPreInversionBeneficiario) {
    emit(PerfilPreInversionBeneficiarioChanged(perfilPreInversionBeneficiario));
  }

  void savePerfilPreInversionBeneficiarioDB() async {
    final result = await perfilPreInversionBeneficiarioDB
        .savePerfilPreInversionBeneficiarioUsecaseDB(
            state.perfilPreInversionBeneficiario);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionBeneficiarioError(failure.properties.first)),
        (data) => emit(PerfilPreInversionBeneficiarioSaved(
            perfilPreInversionBeneficiario:
                state.perfilPreInversionBeneficiario)));
  }

  void changeMunicipioId(String value) {
    final municipioChanged =
        state.perfilPreInversionBeneficiario.copyWith(municipioId: value);
    emit(PerfilPreInversionBeneficiarioChanged(municipioChanged));
  }

  void changeVeredaId(String value) {
    final veredaChanged =
        state.perfilPreInversionBeneficiario.copyWith(veredaId: value);
    emit(PerfilPreInversionBeneficiarioChanged(veredaChanged));
  }

  void changeTipoTenencia(String? value) {
    final tipoTenenciaChanged =
        state.perfilPreInversionBeneficiario.copyWith(tipoTenenciaId: value);
    emit(PerfilPreInversionBeneficiarioChanged(tipoTenenciaChanged));
  }

  void changeAreaFinca(String? newValue) {
    final areaFincaChanged =
        state.perfilPreInversionBeneficiario.copyWith(areaFinca: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(areaFincaChanged));
  }

  void changeAreaProyecto(String? newValue) {
    final areaProyectoChanged =
        state.perfilPreInversionBeneficiario.copyWith(areaProyecto: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(areaProyectoChanged));
  }

  void changeAsociado(String? value) {
    final asociadoChanged = state.perfilPreInversionBeneficiario
        .copyWith(asociado: value.toString());
    emit(PerfilPreInversionBeneficiarioChanged(asociadoChanged));
  }

  void changeConocePerfil(String? value) {
    final conocePerfilChanged = state.perfilPreInversionBeneficiario
        .copyWith(conocePerfil: value.toString());
    emit(PerfilPreInversionBeneficiarioChanged(conocePerfilChanged));
  }

  void changeFueBeneficiado(String? value) {
    final fueBeneficiadoChanged = state.perfilPreInversionBeneficiario
        .copyWith(fueBeneficiado: value.toString());
    emit(PerfilPreInversionBeneficiarioChanged(fueBeneficiadoChanged));
  }

  void changeCualBeneficio(String? newValue) {
    final cualBeneficioChanged =
        state.perfilPreInversionBeneficiario.copyWith(cualBeneficio: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(cualBeneficioChanged));
  }

  void changeBeneficioId(String? newValue) {
    final beneficioIdChanged =
        state.perfilPreInversionBeneficiario.copyWith(beneficioId: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(beneficioIdChanged));
  }

  void changeResidencia(String? value) {
    final residenciaChanged =
        state.perfilPreInversionBeneficiario.copyWith(residenciaId: value);
    emit(PerfilPreInversionBeneficiarioChanged(residenciaChanged));
  }

  void changeNivelEscolar(String? value) {
    final nivelEscolarChanged =
        state.perfilPreInversionBeneficiario.copyWith(nivelEscolarId: value);
    emit(PerfilPreInversionBeneficiarioChanged(nivelEscolarChanged));
  }

  void changeActividadEconomica(String? value) {
    final actividadEconomicaChanged = state.perfilPreInversionBeneficiario
        .copyWith(actividadEconomicaId: value);
    emit(PerfilPreInversionBeneficiarioChanged(actividadEconomicaChanged));
  }

  void changeIngresosDiarios(String? newValue) {
    final ingresosDiariosChanged = state.perfilPreInversionBeneficiario
        .copyWith(ingresosDiarios: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(ingresosDiariosChanged));
  }

  void changeDiasTrabajados(String? newValue) {
    final dasTrabajadosChanged =
        state.perfilPreInversionBeneficiario.copyWith(diasTrabajo: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(dasTrabajadosChanged));
  }

  void changeMiembrosHogar(String? newValue) {
    final miembrosHogarChanged =
        state.perfilPreInversionBeneficiario.copyWith(miembrosHogar: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(miembrosHogarChanged));
  }

  void changeMiembrosEcoActivos(String? newValue) {
    final miembrosEcoActivosChanged = state.perfilPreInversionBeneficiario
        .copyWith(miembrosEcoActivos: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(miembrosEcoActivosChanged));
  }

  void changeIngresosMensuales(String? newValue) {
    final ingresosMensualesChanged = state.perfilPreInversionBeneficiario
        .copyWith(ingresosMensuales: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(ingresosMensualesChanged));
  }

  void changeGastosMensuales(String? newValue) {
    final gastosMensualesChanged = state.perfilPreInversionBeneficiario
        .copyWith(gastosMensuales: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(gastosMensualesChanged));
  }

  void changeActivoInmobiliario(String? newValue) {
    final activoInmobiliarioChanged = state.perfilPreInversionBeneficiario
        .copyWith(activoInmobiliario: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(activoInmobiliarioChanged));
  }

  void changeActivoFinanciero(String? newValue) {
    final activoFinancieroChanged = state.perfilPreInversionBeneficiario
        .copyWith(activoFinanciero: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(activoFinancieroChanged));
  }

  void changeActivoProductivo(String? newValue) {
    final activoProductivoChanged = state.perfilPreInversionBeneficiario
        .copyWith(activoProductivo: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(activoProductivoChanged));
  }

  void changeActivoCorriente(String? newValue) {
    final activoCorrienteChanged = state.perfilPreInversionBeneficiario
        .copyWith(activoCorriente: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(activoCorrienteChanged));
  }

  void changeActivo(String? newValue) {
    final totalActivoChanged =
        state.perfilPreInversionBeneficiario.copyWith(activo: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(totalActivoChanged));
  }

  void changeNombreFinca(String? newValue) {
    final nombreFincaChanged =
        state.perfilPreInversionBeneficiario.copyWith(nombreFinca: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(nombreFincaChanged));
  }

  void changeNombreOrganizacion(String? newValue) {
    final nombreOrganizacionChanged = state.perfilPreInversionBeneficiario
        .copyWith(nombreOrganizacion: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(nombreOrganizacionChanged));
  }

  void changeMesesAsociado(String? newValue) {
    final mesesAsociacionChanged =
        state.perfilPreInversionBeneficiario.copyWith(mesesAsociado: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(mesesAsociacionChanged));
  }

  void changeNota(String? newValue) {
    final notaChanged =
        state.perfilPreInversionBeneficiario.copyWith(nota: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(notaChanged));
  }

  void changeEstadoCivil(String? value) {
    final estadoCivilChanged =
        state.perfilPreInversionBeneficiario.copyWith(estadoCivilId: value);
    emit(PerfilPreInversionBeneficiarioChanged(estadoCivilChanged));
  }

  void changeDiscapacidad(String? value) {
    final discapacidadChanged = state.perfilPreInversionBeneficiario
        .copyWith(tipoDiscapacidadId: value);
    emit(PerfilPreInversionBeneficiarioChanged(discapacidadChanged));
  }

  void changeConyugeTipoIdentificacion(String? value) {
    final conyugeTipoDocumentoChanged = state.perfilPreInversionBeneficiario
        .copyWith(conyugeTipoIdentificacionId: value);
    emit(PerfilPreInversionBeneficiarioChanged(conyugeTipoDocumentoChanged));
  }

  void changeConyugeDocumento(String? newValue) {
    final conyugeDocumentoChanged =
        state.perfilPreInversionBeneficiario.copyWith(conyugeId: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(conyugeDocumentoChanged));
  }

  void changeConyugeFechaExpedicion(String text) {
    final conyugeFechaExpedicionChanged = state.perfilPreInversionBeneficiario
        .copyWith(conyugeFechaExpedicionDocumento: text);
    emit(PerfilPreInversionBeneficiarioChanged(conyugeFechaExpedicionChanged));
  }

  void changeConyugeNombre1(String? newValue) {
    final conyugeNombre1Changed =
        state.perfilPreInversionBeneficiario.copyWith(conyugeNombre1: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(conyugeNombre1Changed));
  }

  void changeConyugeNombre2(String? newValue) {
    final conyugeNombre2Changed =
        state.perfilPreInversionBeneficiario.copyWith(conyugeNombre2: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(conyugeNombre2Changed));
  }

  void changeConyugeApellido1(String? newValue) {
    final conyugeApellido1Changed = state.perfilPreInversionBeneficiario
        .copyWith(conyugeApellido1: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(conyugeApellido1Changed));
  }

  void changeConyugeApellido2(String? newValue) {
    final conyugeApellido2Changed = state.perfilPreInversionBeneficiario
        .copyWith(conyugeApellido2: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(conyugeApellido2Changed));
  }

  void changeConyugeGenero(String? value) {
    final conyugeGeneroChanged =
        state.perfilPreInversionBeneficiario.copyWith(conyugeGeneroId: value);
    emit(PerfilPreInversionBeneficiarioChanged(conyugeGeneroChanged));
  }

  void changeConyugeFechaNacimiento(String text) {
    final conyugeFechaNacimientoChanged = state.perfilPreInversionBeneficiario
        .copyWith(conyugeFechaNacimiento: text);
    emit(PerfilPreInversionBeneficiarioChanged(conyugeFechaNacimientoChanged));
  }

  void changeConyugeGrupoEspecial(String? value) {
    final conyugeGrupoEspecialChanged = state.perfilPreInversionBeneficiario
        .copyWith(conyugeGrupoEspecialId: value);
    emit(PerfilPreInversionBeneficiarioChanged(conyugeGrupoEspecialChanged));
  }

  void changeConyugeIngresosMensuales(String? newValue) {
    final conyugeIngresosMensualesChanged = state.perfilPreInversionBeneficiario
        .copyWith(conyugeIngresosMensuales: newValue);
    emit(
        PerfilPreInversionBeneficiarioChanged(conyugeIngresosMensualesChanged));
  }

  void changeCalificacionSisben(String? newValue) {
    final calificacionSisbenChanged = state.perfilPreInversionBeneficiario
        .copyWith(calificacionSisben: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(calificacionSisbenChanged));
  }

  void changeLatitud(String? newValue) {
    final latitudChanged =
        state.perfilPreInversionBeneficiario.copyWith(latitud: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(latitudChanged));
  }

  void changeExperiencia(String? newValue) {
    final experienciaChanged =
        state.perfilPreInversionBeneficiario.copyWith(experiencia: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(experienciaChanged));
  }

  void changeLongitud(String? newValue) {
    final longitudChanged =
        state.perfilPreInversionBeneficiario.copyWith(longitud: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(longitudChanged));
  }

  void changeCedulaCatastral(String? newValue) {
    final cedulaCatastralChanged = state.perfilPreInversionBeneficiario
        .copyWith(cedulaCatastral: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(cedulaCatastralChanged));
  }

  void changeCotizanteBeps(bool? value) {
    final cotizanteBepsChanged = state.perfilPreInversionBeneficiario
        .copyWith(cotizanteBeps: value.toString());
    emit(PerfilPreInversionBeneficiarioChanged(cotizanteBepsChanged));
  }

  void changeAccesoExplotacionTierra(bool? value) {
    final accesoExplotacionTierraChanged = state.perfilPreInversionBeneficiario
        .copyWith(accesoExplotacionTierra: value.toString());
    emit(PerfilPreInversionBeneficiarioChanged(accesoExplotacionTierraChanged));
  }

  void changePerfilPreInversionId(String value) {
    final perfilPreInversionIdChanged = state.perfilPreInversionBeneficiario
        .copyWith(perfilPreInversionId: value);
    emit(PerfilPreInversionBeneficiarioChanged(perfilPreInversionIdChanged));
  }

  void changeBeneficiarioId(String? newValue) {
    final beneficiarioIdChanged =
        state.perfilPreInversionBeneficiario.copyWith(beneficiarioId: newValue);
    emit(PerfilPreInversionBeneficiarioChanged(beneficiarioIdChanged));
  }

  void initConyuge() {
    final initConyuge = state.perfilPreInversionBeneficiario.copyWith(
        conyugeTipoIdentificacionId: '',
        conyugeId: '',
        conyugeFechaExpedicionDocumento: '',
        conyugeNombre1: '',
        conyugeNombre2: '',
        conyugeApellido1: '',
        conyugeApellido2: '',
        conyugeGeneroId: '',
        conyugeFechaNacimiento: '',
        conyugeIngresosMensuales: '',
        conyugeGrupoEspecialId: '');
    emit(PerfilPreInversionBeneficiarioChanged(initConyuge));
  }
}
