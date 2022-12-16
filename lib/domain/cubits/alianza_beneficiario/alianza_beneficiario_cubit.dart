import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/alianza_beneficiario_entity.dart';
import '../../usecases/alianza_beneficiario/alianza_beneficiario_db_usecase.dart';

part '../alianza_beneficiario/alianza_beneficiario_state.dart';

class AlianzaBeneficiarioCubit extends Cubit<AlianzaBeneficiarioState> {
  final AlianzaBeneficiarioUsecaseDB alianzaBeneficiarioDB;

  AlianzaBeneficiarioCubit({required this.alianzaBeneficiarioDB})
      : super(AlianzaBeneficiarioInitial());

  void loadAlianzaBeneficiario(String alianzaId, String beneficiarioId) async {
    final result = await alianzaBeneficiarioDB.getAlianzaBeneficiarioUsecaseDB(
        alianzaId, beneficiarioId);
    result.fold(
        (failure) => emit(AlianzaBeneficiarioError(failure.properties.first)),
        (data) {
      if (data != null) {
        emit(AlianzaBeneficiarioLoaded(data));
      }
    });
  }

  void initState() => emit(AlianzaBeneficiarioInitial());

  void selectAlianzaBeneficiario(
      AlianzaBeneficiarioEntity alianzaBeneficiario) {
    emit(AlianzaBeneficiarioLoaded(alianzaBeneficiario));
  }

  void saveAlianzaBeneficiarioDB(
      AlianzaBeneficiarioEntity alianzaBeneficiarioEntity) async {
    final result = await alianzaBeneficiarioDB
        .saveAlianzaBeneficiarioUsecaseDB(alianzaBeneficiarioEntity);
    result.fold(
        (failure) => emit(AlianzaBeneficiarioError(failure.properties.first)),
        (data) => emit(AlianzaBeneficiarioSaved(
            alianzaBeneficiario: alianzaBeneficiarioEntity)));
  }

  void changeMunicipioId(String value) {
    final municipioChanged =
        state.alianzaBeneficiario.copyWith(municipioId: value);
    emit(AlianzaBeneficiarioChanged(municipioChanged));
  }

  void changeVeredaId(String value) {
    final veredaChanged = state.alianzaBeneficiario.copyWith(veredaId: value);
    emit(AlianzaBeneficiarioChanged(veredaChanged));
  }

  void changeTipoTenencia(String? value) {
    final tipoTenenciaChanged =
        state.alianzaBeneficiario.copyWith(tipoTenenciaId: value);
    emit(AlianzaBeneficiarioChanged(tipoTenenciaChanged));
  }

  void changeAreaFinca(String? newValue) {
    final areaFincaChanged =
        state.alianzaBeneficiario.copyWith(areaFinca: newValue);
    emit(AlianzaBeneficiarioChanged(areaFincaChanged));
  }

  void changeAreaProyecto(String? newValue) {
    final areaProyectoChanged =
        state.alianzaBeneficiario.copyWith(areaProyecto: newValue);
    emit(AlianzaBeneficiarioChanged(areaProyectoChanged));
  }

  void changeAsociado(String? value) {
    final asociadoChanged =
        state.alianzaBeneficiario.copyWith(asociado: value.toString());
    emit(AlianzaBeneficiarioChanged(asociadoChanged));
  }

  void changeConocePerfil(String? value) {
    final conocePerfilChanged =
        state.alianzaBeneficiario.copyWith(conocePerfil: value.toString());
    emit(AlianzaBeneficiarioChanged(conocePerfilChanged));
  }

  void changeFueBeneficiado(String? value) {
    final fueBeneficiadoChanged =
        state.alianzaBeneficiario.copyWith(fueBeneficiado: value.toString());
    emit(AlianzaBeneficiarioChanged(fueBeneficiadoChanged));
  }

  void changeCualBeneficio(String? newValue) {
    final cualBeneficioChanged =
        state.alianzaBeneficiario.copyWith(cualBeneficio: newValue);
    emit(AlianzaBeneficiarioChanged(cualBeneficioChanged));
  }

  void changeBeneficioId(String? newValue) {
    final beneficioIdChanged =
        state.alianzaBeneficiario.copyWith(beneficioId: newValue);
    emit(AlianzaBeneficiarioChanged(beneficioIdChanged));
  }

  void changeResidencia(String? value) {
    final residenciaChanged =
        state.alianzaBeneficiario.copyWith(residenciaId: value);
    emit(AlianzaBeneficiarioChanged(residenciaChanged));
  }

  void changeNivelEscolar(String? value) {
    final nivelEscolarChanged =
        state.alianzaBeneficiario.copyWith(nivelEscolarId: value);
    emit(AlianzaBeneficiarioChanged(nivelEscolarChanged));
  }

  void changeActividadEconomica(String? value) {
    final actividadEconomicaChanged =
        state.alianzaBeneficiario.copyWith(actividadEconomicaId: value);
    emit(AlianzaBeneficiarioChanged(actividadEconomicaChanged));
  }

  void changeIngresosDiarios(String? newValue) {
    final ingresosDiariosChanged =
        state.alianzaBeneficiario.copyWith(ingresosDiarios: newValue);
    emit(AlianzaBeneficiarioChanged(ingresosDiariosChanged));
  }

  void changeDiasTrabajados(String? newValue) {
    final dasTrabajadosChanged =
        state.alianzaBeneficiario.copyWith(diasTrabajo: newValue);
    emit(AlianzaBeneficiarioChanged(dasTrabajadosChanged));
  }

  void changeMiembrosHogar(String? newValue) {
    final miembrosHogarChanged =
        state.alianzaBeneficiario.copyWith(miembrosHogar: newValue);
    emit(AlianzaBeneficiarioChanged(miembrosHogarChanged));
  }

  void changeMiembrosEcoActivos(String? newValue) {
    final miembrosEcoActivosChanged =
        state.alianzaBeneficiario.copyWith(miembrosEcoActivos: newValue);
    emit(AlianzaBeneficiarioChanged(miembrosEcoActivosChanged));
  }

  void changeIngresosMensuales(String? newValue) {
    final ingresosMensualesChanged =
        state.alianzaBeneficiario.copyWith(ingresosMensuales: newValue);
    emit(AlianzaBeneficiarioChanged(ingresosMensualesChanged));
  }

  void changeGastosMensuales(String? newValue) {
    final gastosMensualesChanged =
        state.alianzaBeneficiario.copyWith(gastosMensuales: newValue);
    emit(AlianzaBeneficiarioChanged(gastosMensualesChanged));
  }

  void changeActivoInmobiliario(String? newValue) {
    final activoInmobiliarioChanged =
        state.alianzaBeneficiario.copyWith(activoInmobiliario: newValue);
    emit(AlianzaBeneficiarioChanged(activoInmobiliarioChanged));
  }

  void changeActivoFinanciero(String? newValue) {
    final activoFinancieroChanged =
        state.alianzaBeneficiario.copyWith(activoFinanciero: newValue);
    emit(AlianzaBeneficiarioChanged(activoFinancieroChanged));
  }

  void changeActivoProductivo(String? newValue) {
    final activoProductivoChanged =
        state.alianzaBeneficiario.copyWith(activoProductivo: newValue);
    emit(AlianzaBeneficiarioChanged(activoProductivoChanged));
  }

  void changeActivoCorriente(String? newValue) {
    final activoCorrienteChanged =
        state.alianzaBeneficiario.copyWith(activoCorriente: newValue);
    emit(AlianzaBeneficiarioChanged(activoCorrienteChanged));
  }

  void changeActivo(String? newValue) {
    final activoChanged = state.alianzaBeneficiario.copyWith(activo: newValue);
    emit(AlianzaBeneficiarioChanged(activoChanged));
  }

  void changeNombreFinca(String? newValue) {
    final nombreFincaChanged =
        state.alianzaBeneficiario.copyWith(nombreFinca: newValue);
    emit(AlianzaBeneficiarioChanged(nombreFincaChanged));
  }

  void changeNombreOrganizacion(String? newValue) {
    final nombreOrganizacionChanged =
        state.alianzaBeneficiario.copyWith(nombreOrganizacion: newValue);
    emit(AlianzaBeneficiarioChanged(nombreOrganizacionChanged));
  }

  void changeMesesAsociado(String? newValue) {
    final mesesAsociacionChanged =
        state.alianzaBeneficiario.copyWith(mesesAsociado: newValue);
    emit(AlianzaBeneficiarioChanged(mesesAsociacionChanged));
  }

  void changeNota(String? newValue) {
    final notaChanged = state.alianzaBeneficiario.copyWith(nota: newValue);
    emit(AlianzaBeneficiarioChanged(notaChanged));
  }

  void changeEstadoCivil(String? value) {
    final estadoCivilChanged =
        state.alianzaBeneficiario.copyWith(estadoCivilId: value);
    emit(AlianzaBeneficiarioChanged(estadoCivilChanged));
  }

  void changeDiscapacidad(String? value) {
    final discapacidadChanged =
        state.alianzaBeneficiario.copyWith(tipoDiscapacidadId: value);
    emit(AlianzaBeneficiarioChanged(discapacidadChanged));
  }

  void changeConyugeTipoIdentificacion(String? value) {
    final conyugeTipoDocumentoChanged =
        state.alianzaBeneficiario.copyWith(conyugeTipoIdentificacionId: value);
    emit(AlianzaBeneficiarioChanged(conyugeTipoDocumentoChanged));
  }

  void changeConyugeDocumento(String? newValue) {
    final conyugeDocumentoChanged =
        state.alianzaBeneficiario.copyWith(conyugeId: newValue);
    emit(AlianzaBeneficiarioChanged(conyugeDocumentoChanged));
  }

  void changeConyugeFechaExpedicion(String text) {
    final conyugeFechaExpedicionChanged = state.alianzaBeneficiario
        .copyWith(conyugeFechaExpedicionDocumento: text);
    emit(AlianzaBeneficiarioChanged(conyugeFechaExpedicionChanged));
  }

  void changeConyugeNombre1(String? newValue) {
    final conyugeNombre1Changed =
        state.alianzaBeneficiario.copyWith(conyugeNombre1: newValue);
    emit(AlianzaBeneficiarioChanged(conyugeNombre1Changed));
  }

  void changeConyugeNombre2(String? newValue) {
    final conyugeNombre2Changed =
        state.alianzaBeneficiario.copyWith(conyugeNombre2: newValue);
    emit(AlianzaBeneficiarioChanged(conyugeNombre2Changed));
  }

  void changeConyugeApellido1(String? newValue) {
    final conyugeApellido1Changed =
        state.alianzaBeneficiario.copyWith(conyugeApellido1: newValue);
    emit(AlianzaBeneficiarioChanged(conyugeApellido1Changed));
  }

  void changeConyugeApellido2(String? newValue) {
    final conyugeApellido2Changed =
        state.alianzaBeneficiario.copyWith(conyugeApellido2: newValue);
    emit(AlianzaBeneficiarioChanged(conyugeApellido2Changed));
  }

  void changeConyugeGenero(String? value) {
    final conyugeGeneroChanged =
        state.alianzaBeneficiario.copyWith(conyugeGeneroId: value);
    emit(AlianzaBeneficiarioChanged(conyugeGeneroChanged));
  }

  void changeConyugeFechaNacimiento(String text) {
    final conyugeFechaNacimientoChanged =
        state.alianzaBeneficiario.copyWith(conyugeFechaNacimiento: text);
    emit(AlianzaBeneficiarioChanged(conyugeFechaNacimientoChanged));
  }

  void changeConyugeGrupoEspecial(String? value) {
    final conyugeGrupoEspecialChanged =
        state.alianzaBeneficiario.copyWith(conyugeGrupoEspecialId: value);
    emit(AlianzaBeneficiarioChanged(conyugeGrupoEspecialChanged));
  }

  void changeConyugeIngresosMensuales(String? newValue) {
    final conyugeIngresosMensualesChanged =
        state.alianzaBeneficiario.copyWith(conyugeIngresosMensuales: newValue);
    emit(AlianzaBeneficiarioChanged(conyugeIngresosMensualesChanged));
  }

  void changeCalificacionSisben(String? newValue) {
    final calificacionSisbenChanged =
        state.alianzaBeneficiario.copyWith(calificacionSisben: newValue);
    emit(AlianzaBeneficiarioChanged(calificacionSisbenChanged));
  }

  void changeLatitud(String? newValue) {
    final latitudChanged =
        state.alianzaBeneficiario.copyWith(latitud: newValue);
    emit(AlianzaBeneficiarioChanged(latitudChanged));
  }

  void changeExperiencia(String? newValue) {
    final experienciaChanged =
        state.alianzaBeneficiario.copyWith(experiencia: newValue);
    emit(AlianzaBeneficiarioChanged(experienciaChanged));
  }

  void changeLongitud(String? newValue) {
    final longitudChanged =
        state.alianzaBeneficiario.copyWith(longitud: newValue);
    emit(AlianzaBeneficiarioChanged(longitudChanged));
  }

  void changeCedulaCatastral(String? newValue) {
    final cedulaCatastralChanged =
        state.alianzaBeneficiario.copyWith(cedulaCatastral: newValue);
    emit(AlianzaBeneficiarioChanged(cedulaCatastralChanged));
  }

  void changeCotizanteBeps(bool? value) {
    final cotizanteBepsChanged =
        state.alianzaBeneficiario.copyWith(cotizanteBeps: value.toString());
    emit(AlianzaBeneficiarioChanged(cotizanteBepsChanged));
  }

  void changeAccesoExplotacionTierra(bool? value) {
    final accesoExplotacionTierraChanged = state.alianzaBeneficiario
        .copyWith(accesoExplotacionTierra: value.toString());
    emit(AlianzaBeneficiarioChanged(accesoExplotacionTierraChanged));
  }

  void changeAlianzaId(String value) {
    final alianzaIdChanged =
        state.alianzaBeneficiario.copyWith(alianzaId: value);
    emit(AlianzaBeneficiarioChanged(alianzaIdChanged));
  }

  void changeBeneficiarioId(String? newValue) {
    final beneficiarioIdChanged =
        state.alianzaBeneficiario.copyWith(beneficiarioId: newValue);
    emit(AlianzaBeneficiarioChanged(beneficiarioIdChanged));
  }

  void initConyuge() {
    final initConyuge = state.alianzaBeneficiario.copyWith(
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
    emit(AlianzaBeneficiarioChanged(initConyuge));
  }
}
