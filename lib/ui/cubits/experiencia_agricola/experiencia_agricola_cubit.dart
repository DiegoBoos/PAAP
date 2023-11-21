import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/experiencia_agricola_entity.dart';
import '../../../domain/usecases/experiencia_agricola/experiencia_agricola_db_usecase.dart';

part '../experiencia_agricola/experiencia_agricola_state.dart';

class ExperienciaAgricolaCubit extends Cubit<ExperienciaAgricolaState> {
  final ExperienciaAgricolaUsecaseDB experienciaAgricolaDB;

  ExperienciaAgricolaCubit({required this.experienciaAgricolaDB})
      : super(ExperienciaAgricolaInitial());

  void initState() => emit(ExperienciaAgricolaInitial());

  void loadExperienciaAgricola(
      String tipoActividadProductivaId, String beneficiarioId) async {
    final result = await experienciaAgricolaDB.getExperienciaAgricolaUsecaseDB(
        tipoActividadProductivaId, beneficiarioId);
    result.fold(
        (failure) => emit(ExperienciaAgricolaError(failure.properties.first)),
        (data) {
      if (data == null) {
        emit(ExperienciaAgricolaError('Error'));
      } else {
        emit(ExperienciaAgricolaLoaded(data));
      }
    });
  }

  void saveExperienciaAgricolaDB(
      ExperienciaAgricolaEntity experienciaAgricolaEntity) async {
    final result = await experienciaAgricolaDB
        .saveExperienciaAgricolaUsecaseDB(experienciaAgricolaEntity);
    result.fold(
        (failure) => emit(ExperienciaAgricolaError(failure.properties.first)),
        (data) => emit(ExperienciaAgricolaSaved()));
  }

  void changeTipoActividadProductiva(String? value) {
    final tipoActividadProductivaId =
        state.experienciaAgricola.copyWith(tipoActividadProductivaId: value);
    emit(ExperienciaAgricolaChanged(tipoActividadProductivaId));
  }

  void changeFrecuencia(String? value) {
    final frecuenciaId =
        state.experienciaAgricola.copyWith(frecuenciaId: value);
    emit(ExperienciaAgricolaChanged(frecuenciaId));
  }

  void changeAreaCultivo(String? newValue) {
    final areaCultivo =
        state.experienciaAgricola.copyWith(areaCultivo: newValue);
    emit(ExperienciaAgricolaChanged(areaCultivo));
  }

  void changeCantidadProducida(String? newValue) {
    final cantidadProducida =
        state.experienciaAgricola.copyWith(cantidadProducida: newValue);
    emit(ExperienciaAgricolaChanged(cantidadProducida));
  }

  void changeCantidadVendida(String? newValue) {
    final cantidadVendida =
        state.experienciaAgricola.copyWith(cantidadVendida: newValue);
    emit(ExperienciaAgricolaChanged(cantidadVendida));
  }

  void changeCantidadAutoconsumo(String? newValue) {
    final cantidadAutoconsumo =
        state.experienciaAgricola.copyWith(cantidadAutoconsumo: newValue);
    emit(ExperienciaAgricolaChanged(cantidadAutoconsumo));
  }

  void changeCostoImplementacion(String? newValue) {
    final costoImplementacion =
        state.experienciaAgricola.copyWith(costoImplementacion: newValue);
    emit(ExperienciaAgricolaChanged(costoImplementacion));
  }

  void changeValorJornal(String? newValue) {
    final valorJornal =
        state.experienciaAgricola.copyWith(valorJornal: newValue);
    emit(ExperienciaAgricolaChanged(valorJornal));
  }

  void changeTotalIngresoNeto(String? newValue) {
    final totalIngresoNeto =
        state.experienciaAgricola.copyWith(totalIngresoNeto: newValue);
    emit(ExperienciaAgricolaChanged(totalIngresoNeto));
  }

  void changeAreaPasto(String? newValue) {
    final areaPasto = state.experienciaAgricola.copyWith(areaPasto: newValue);
    emit(ExperienciaAgricolaChanged(areaPasto));
  }

  void changeAreaSinUso(String? newValue) {
    final areaSinUso = state.experienciaAgricola.copyWith(areaSinUso: newValue);
    emit(ExperienciaAgricolaChanged(areaSinUso));
  }

  void changeAreaReservaConservacion(String? newValue) {
    final areaReservaConservacion =
        state.experienciaAgricola.copyWith(areaReservaConservacion: newValue);
    emit(ExperienciaAgricolaChanged(areaReservaConservacion));
  }

  void changeAreaImplementacion(String? newValue) {
    final areaImplementacion =
        state.experienciaAgricola.copyWith(areaImplementacion: newValue);
    emit(ExperienciaAgricolaChanged(areaImplementacion));
  }

  void changeTotalAreaPredio(String? newValue) {
    final totalAreaPredio =
        state.experienciaAgricola.copyWith(totalAreaPredio: newValue);
    emit(ExperienciaAgricolaChanged(totalAreaPredio));
  }

  void changeBeneficiarioId(String value) {
    final beneficiarioIdChanged =
        state.experienciaAgricola.copyWith(beneficiarioId: value);
    emit(ExperienciaAgricolaChanged(beneficiarioIdChanged));
  }
}
