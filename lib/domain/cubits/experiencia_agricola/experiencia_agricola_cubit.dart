import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/experiencia_agricola_entity.dart';
import '../../usecases/experiencia_agricola/experiencia_agricola_db_usecase.dart';

part '../experiencia_agricola/experiencia_agricola_state.dart';

class ExperienciaAgricolaCubit extends Cubit<ExperienciaAgricolaState> {
  final ExperienciaAgricolaUsecaseDB experienciaAgricolaDB;

  ExperienciaAgricolaCubit({required this.experienciaAgricolaDB})
      : super(ExperienciaAgricolaInitial());

  void initState() => emit(ExperienciaAgricolaInitial());

  void selectExperienciaAgricola(String beneficiarioId) async {
    final result = await experienciaAgricolaDB
        .getExperienciaAgricolaUsecaseDB(beneficiarioId);
    result.fold(
        (failure) => emit(ExperienciaAgricolaError(failure.properties.first)),
        (data) => emit(ExperienciaAgricolaLoaded(data)));
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
        state.experienciaAgricola!.copyWith(tipoActividadProductivaId: value);
    emit(ExperienciaAgricolaLoaded(tipoActividadProductivaId));
  }

  void changeFrecuencia(String? value) {
    final frecuenciaId =
        state.experienciaAgricola!.copyWith(frecuenciaId: value);
    emit(ExperienciaAgricolaLoaded(frecuenciaId));
  }

  void changeAreaCultivo(String? newValue) {
    final areaCultivo =
        state.experienciaAgricola!.copyWith(areaCultivo: newValue);
    emit(ExperienciaAgricolaLoaded(areaCultivo));
  }

  void changeCantidadProducida(String? newValue) {
    final cantidadProducida =
        state.experienciaAgricola!.copyWith(cantidadProducida: newValue);
    emit(ExperienciaAgricolaLoaded(cantidadProducida));
  }

  void changeCantidadVendida(String? newValue) {
    final cantidadVendida =
        state.experienciaAgricola!.copyWith(cantidadVendida: newValue);
    emit(ExperienciaAgricolaLoaded(cantidadVendida));
  }

  void changeCantidadAutoconsumo(String? newValue) {
    final cantidadAutoconsumo =
        state.experienciaAgricola!.copyWith(cantidadAutoconsumo: newValue);
    emit(ExperienciaAgricolaLoaded(cantidadAutoconsumo));
  }

  void changeCostoImplementacion(String? newValue) {
    final costoImplementacion =
        state.experienciaAgricola!.copyWith(costoImplementacion: newValue);
    emit(ExperienciaAgricolaLoaded(costoImplementacion));
  }

  void changeValorJornal(String? newValue) {
    final valorJornal =
        state.experienciaAgricola!.copyWith(valorJornal: newValue);
    emit(ExperienciaAgricolaLoaded(valorJornal));
  }

  void changeTotalIngresoNeto(String? newValue) {
    final totalIngresoNeto =
        state.experienciaAgricola!.copyWith(totalIngresoNeto: newValue);
    emit(ExperienciaAgricolaLoaded(totalIngresoNeto));
  }

  void changeAreaPasto(String? newValue) {
    final areaPasto = state.experienciaAgricola!.copyWith(areaPasto: newValue);
    emit(ExperienciaAgricolaLoaded(areaPasto));
  }

  void changeAreaSinUso(String? newValue) {
    final areaSinUso =
        state.experienciaAgricola!.copyWith(areaSinUso: newValue);
    emit(ExperienciaAgricolaLoaded(areaSinUso));
  }

  void changeAreaReservaConservacion(String? newValue) {
    final areaReservaConservacion =
        state.experienciaAgricola!.copyWith(areaReservaConservacion: newValue);
    emit(ExperienciaAgricolaLoaded(areaReservaConservacion));
  }

  void changeAreaImplementacion(String? newValue) {
    final areaImplementacion =
        state.experienciaAgricola!.copyWith(areaImplementacion: newValue);
    emit(ExperienciaAgricolaLoaded(areaImplementacion));
  }

  void changeTotalAreaPredio(String? newValue) {
    final totalAreaPredio =
        state.experienciaAgricola!.copyWith(totalAreaPredio: newValue);
    emit(ExperienciaAgricolaLoaded(totalAreaPredio));
  }
}
