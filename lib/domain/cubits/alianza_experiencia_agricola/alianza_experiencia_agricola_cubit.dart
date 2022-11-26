import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/alianza_experiencia_agricola_entity.dart';
import '../../usecases/alianza_experiencia_agricola/alianza_experiencia_agricola_db_usecase.dart';

part '../alianza_experiencia_agricola/alianza_experiencia_agricola_state.dart';

class AlianzaExperienciaAgricolaCubit
    extends Cubit<AlianzaExperienciaAgricolaState> {
  final AlianzaExperienciaAgricolaUsecaseDB alianzaExperienciaAgricolaDB;

  AlianzaExperienciaAgricolaCubit({required this.alianzaExperienciaAgricolaDB})
      : super(AlianzaExperienciaAgricolaInitial());

  void initState() => emit(AlianzaExperienciaAgricolaInitial());

  void selectAlianzaExperienciaAgricola(
      String tipoActividadProductivaId, String beneficiarioId) async {
    final result = await alianzaExperienciaAgricolaDB
        .getAlianzaExperienciaAgricolaUsecaseDB(
            tipoActividadProductivaId, beneficiarioId);
    result.fold(
        (failure) =>
            emit(AlianzaExperienciaAgricolaError(failure.properties.first)),
        (data) {
      if (data == null) {
        emit(AlianzaExperienciaAgricolaError('Error'));
      } else {
        emit(AlianzaExperienciaAgricolaLoaded(data));
      }
    });
  }

  void saveAlianzaExperienciaAgricolaDB(
      AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricolaEntity) async {
    final result = await alianzaExperienciaAgricolaDB
        .saveAlianzaExperienciaAgricolaUsecaseDB(
            alianzaExperienciaAgricolaEntity);
    result.fold(
        (failure) =>
            emit(AlianzaExperienciaAgricolaError(failure.properties.first)),
        (data) => emit(AlianzaExperienciaAgricolaSaved()));
  }

  void changeTipoActividadProductiva(String? value) {
    final tipoActividadProductivaId = state.alianzaExperienciaAgricola
        .copyWith(tipoActividadProductivaId: value);
    emit(AlianzaExperienciaAgricolaChanged(tipoActividadProductivaId));
  }

  void changeFrecuencia(String? value) {
    final frecuenciaId =
        state.alianzaExperienciaAgricola.copyWith(frecuenciaId: value);
    emit(AlianzaExperienciaAgricolaChanged(frecuenciaId));
  }

  void changeAreaCultivo(String? newValue) {
    final areaCultivo =
        state.alianzaExperienciaAgricola.copyWith(areaCultivo: newValue);
    emit(AlianzaExperienciaAgricolaChanged(areaCultivo));
  }

  void changeCantidadProducida(String? newValue) {
    final cantidadProducida =
        state.alianzaExperienciaAgricola.copyWith(cantidadProducida: newValue);
    emit(AlianzaExperienciaAgricolaChanged(cantidadProducida));
  }

  void changeCantidadVendida(String? newValue) {
    final cantidadVendida =
        state.alianzaExperienciaAgricola.copyWith(cantidadVendida: newValue);
    emit(AlianzaExperienciaAgricolaChanged(cantidadVendida));
  }

  void changeCantidadAutoconsumo(String? newValue) {
    final cantidadAutoconsumo = state.alianzaExperienciaAgricola
        .copyWith(cantidadAutoconsumo: newValue);
    emit(AlianzaExperienciaAgricolaChanged(cantidadAutoconsumo));
  }

  void changeCostoImplementacion(String? newValue) {
    final costoImplementacion = state.alianzaExperienciaAgricola
        .copyWith(costoImplementacion: newValue);
    emit(AlianzaExperienciaAgricolaChanged(costoImplementacion));
  }

  void changeValorJornal(String? newValue) {
    final valorJornal =
        state.alianzaExperienciaAgricola.copyWith(valorJornal: newValue);
    emit(AlianzaExperienciaAgricolaChanged(valorJornal));
  }

  void changeTotalIngresoNeto(String? newValue) {
    final totalIngresoNeto =
        state.alianzaExperienciaAgricola.copyWith(totalIngresoNeto: newValue);
    emit(AlianzaExperienciaAgricolaChanged(totalIngresoNeto));
  }

  void changeAreaPasto(String? newValue) {
    final areaPasto =
        state.alianzaExperienciaAgricola.copyWith(areaPasto: newValue);
    emit(AlianzaExperienciaAgricolaChanged(areaPasto));
  }

  void changeAreaSinUso(String? newValue) {
    final areaSinUso =
        state.alianzaExperienciaAgricola.copyWith(areaSinUso: newValue);
    emit(AlianzaExperienciaAgricolaChanged(areaSinUso));
  }

  void changeAreaReservaConservacion(String? newValue) {
    final areaReservaConservacion = state.alianzaExperienciaAgricola
        .copyWith(areaReservaConservacion: newValue);
    emit(AlianzaExperienciaAgricolaChanged(areaReservaConservacion));
  }

  void changeAreaImplementacion(String? newValue) {
    final areaImplementacion =
        state.alianzaExperienciaAgricola.copyWith(areaImplementacion: newValue);
    emit(AlianzaExperienciaAgricolaChanged(areaImplementacion));
  }

  void changeTotalAreaPredio(String? newValue) {
    final totalAreaPredio =
        state.alianzaExperienciaAgricola.copyWith(totalAreaPredio: newValue);
    emit(AlianzaExperienciaAgricolaChanged(totalAreaPredio));
  }

  void changeBeneficiarioId(String value) {
    final beneficiarioIdChanged =
        state.alianzaExperienciaAgricola.copyWith(beneficiarioId: value);
    emit(AlianzaExperienciaAgricolaChanged(beneficiarioIdChanged));
  }
}
