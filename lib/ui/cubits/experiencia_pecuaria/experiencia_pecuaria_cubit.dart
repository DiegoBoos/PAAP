import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/experiencia_pecuaria_entity.dart';
import '../../../domain/usecases/experiencia_pecuaria/experiencia_pecuaria_db_usecase.dart';

part '../experiencia_pecuaria/experiencia_pecuaria_state.dart';

class ExperienciaPecuariaCubit extends Cubit<ExperienciaPecuariaState> {
  final ExperienciaPecuariaUsecaseDB experienciaPecuariaDB;

  ExperienciaPecuariaCubit({required this.experienciaPecuariaDB})
      : super(ExperienciaPecuariaInitial());

  void initState() => emit(ExperienciaPecuariaInitial());

  void loadExperienciaPecuaria(
      String tipoActividadProductivaId, String beneficiarioId) async {
    final result = await experienciaPecuariaDB.getExperienciaPecuariaUsecaseDB(
        tipoActividadProductivaId, beneficiarioId);
    result.fold(
        (failure) => emit(ExperienciaPecuariaError(failure.properties.first)),
        (data) {
      if (data == null) {
        emit(ExperienciaPecuariaError('Error'));
      } else {
        emit(ExperienciaPecuariaLoaded(data));
      }
    });
  }

  void saveExperienciaPecuariaDB() async {
    final result = await experienciaPecuariaDB
        .saveExperienciaPecuariaUsecaseDB(state.experienciaPecuaria);
    result.fold(
        (failure) => emit(ExperienciaPecuariaError(failure.properties.first)),
        (data) => emit(ExperienciaPecuariaSaved()));
  }

  void changeTipoActividadProductiva(String? value) {
    final tipoActividadProductivaChanged =
        state.experienciaPecuaria.copyWith(tipoActividadProductivaId: value);
    emit(ExperienciaPecuariaChanged(tipoActividadProductivaChanged));
  }

  void changeFrecuencia(String? newValue) {
    final frecuenciaChanged =
        state.experienciaPecuaria.copyWith(frecuenciaId: newValue);
    emit(ExperienciaPecuariaChanged(frecuenciaChanged));
  }

  void changeCantidadAnimales(String? newValue) {
    final cantidadAnimalesChanged =
        state.experienciaPecuaria.copyWith(cantidadAnimales: newValue);
    emit(ExperienciaPecuariaChanged(cantidadAnimalesChanged));
  }

  void changeCantidadCria(String? newValue) {
    final cantidadCriaChanged =
        state.experienciaPecuaria.copyWith(cantidadCria: newValue);
    emit(ExperienciaPecuariaChanged(cantidadCriaChanged));
  }

  void changeCantidadLevante(String? newValue) {
    final cantidadLevanteChanged =
        state.experienciaPecuaria.copyWith(cantidadLevante: newValue);
    emit(ExperienciaPecuariaChanged(cantidadLevanteChanged));
  }

  void changeCantidadCeba(String? newValue) {
    final cantidadCebaChanged =
        state.experienciaPecuaria.copyWith(cantidadCeba: newValue);
    emit(ExperienciaPecuariaChanged(cantidadCebaChanged));
  }

  void changeCantidadLeche(String? newValue) {
    final cantidadLecheChanged =
        state.experienciaPecuaria.copyWith(cantidadLeche: newValue);
    emit(ExperienciaPecuariaChanged(cantidadLecheChanged));
  }

  void changeValorJornal(String? newValue) {
    final valorJornalChanged =
        state.experienciaPecuaria.copyWith(valorJornal: newValue);
    emit(ExperienciaPecuariaChanged(valorJornalChanged));
  }

  void changeCostosInsumos(String? newValue) {
    final costosInsumosChanged =
        state.experienciaPecuaria.copyWith(costosInsumos: newValue);
    emit(ExperienciaPecuariaChanged(costosInsumosChanged));
  }

  void changeIngresos(String? newValue) {
    final ingresosChanged =
        state.experienciaPecuaria.copyWith(ingresos: newValue);
    emit(ExperienciaPecuariaChanged(ingresosChanged));
  }

  void changeBeneficiarioId(String value) {
    final beneficiarioIdChanged =
        state.experienciaPecuaria.copyWith(beneficiarioId: value);
    emit(ExperienciaPecuariaChanged(beneficiarioIdChanged));
  }
}
