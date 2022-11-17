import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/experiencia_pecuaria_entity.dart';
import '../../usecases/experiencia_pecuaria/experiencia_pecuaria_db_usecase.dart';

part '../experiencia_pecuaria/experiencia_pecuaria_state.dart';

class ExperienciaPecuariaCubit extends Cubit<ExperienciaPecuariaState> {
  final ExperienciaPecuariaUsecaseDB experienciaPecuariaDB;

  ExperienciaPecuariaCubit({required this.experienciaPecuariaDB})
      : super(ExperienciaPecuariaInitial());

  void getExperienciaPecuariaDB(String id) async {
    final result =
        await experienciaPecuariaDB.getExperienciaPecuariaUsecaseDB(id);
    result.fold(
        (failure) => emit(ExperienciaPecuariaError(failure.properties.first)),
        (data) => emit(ExperienciaPecuariaLoaded(data)));
  }

  void initState() => emit(ExperienciaPecuariaInitial());

  void changeTipoActividadProductiva(String? value) {
    final tipoActividadProductivaChanged =
        state.experienciaPecuaria!.copyWith(tipoActividadProductivaId: value);
    emit(ExperienciaPecuariaLoaded(tipoActividadProductivaChanged));
  }

  void changeFrecuencia(String? newValue) {
    final frecuenciaChanged =
        state.experienciaPecuaria!.copyWith(frecuenciaId: newValue);
    emit(ExperienciaPecuariaLoaded(frecuenciaChanged));
  }

  void changeCantidadAnimales(String? newValue) {
    final cantidadAnimalesChanged =
        state.experienciaPecuaria!.copyWith(cantidadAnimales: newValue);
    emit(ExperienciaPecuariaLoaded(cantidadAnimalesChanged));
  }

  void changeCantidadCria(String? newValue) {
    final cantidadCriaChanged =
        state.experienciaPecuaria!.copyWith(cantidadCria: newValue);
    emit(ExperienciaPecuariaLoaded(cantidadCriaChanged));
  }

  void changeCantidadLevante(String? newValue) {
    final cantidadLevanteChanged =
        state.experienciaPecuaria!.copyWith(cantidadLevante: newValue);
    emit(ExperienciaPecuariaLoaded(cantidadLevanteChanged));
  }

  void changeCantidadCeba(String? newValue) {
    final cantidadCebaChanged =
        state.experienciaPecuaria!.copyWith(cantidadCeba: newValue);
    emit(ExperienciaPecuariaLoaded(cantidadCebaChanged));
  }

  void changeCantidadLeche(String? newValue) {
    final cantidadLecheChanged =
        state.experienciaPecuaria!.copyWith(cantidadLeche: newValue);
    emit(ExperienciaPecuariaLoaded(cantidadLecheChanged));
  }

  void changeValorJornal(String? newValue) {
    final valorJornalChanged =
        state.experienciaPecuaria!.copyWith(valorJornal: newValue);
    emit(ExperienciaPecuariaLoaded(valorJornalChanged));
  }

  void changeCostosInsumos(String? newValue) {
    final costosInsumosChanged =
        state.experienciaPecuaria!.copyWith(costosInsumos: newValue);
    emit(ExperienciaPecuariaLoaded(costosInsumosChanged));
  }

  void changeIngresos(String? newValue) {
    final ingresosChanged =
        state.experienciaPecuaria!.copyWith(ingresos: newValue);
    emit(ExperienciaPecuariaLoaded(ingresosChanged));
  }
}
