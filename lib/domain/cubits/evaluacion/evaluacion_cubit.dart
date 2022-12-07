import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/evaluacion_entity.dart';
import '../../usecases/evaluacion/evaluacion_db_usecase.dart';
part 'evaluacion_state.dart';

class EvaluacionCubit extends Cubit<EvaluacionState> {
  final EvaluacionUsecaseDB evaluacionDB;

  EvaluacionCubit({required this.evaluacionDB}) : super(EvaluacionInitial());

  Future<void> getEvaluacionDB(String perfilId) async {
    final result = await evaluacionDB.getEvaluacionUsecaseDB(perfilId);
    result.fold((failure) => emit(EvaluacionError(failure.properties.first)),
        (data) => emit(EvaluacionLoaded(data!)));
  }

  void saveEvaluacionDB(EvaluacionEntity evaluacionEntity) async {
    final result = await evaluacionDB.saveEvaluacionUsecaseDB(evaluacionEntity);
    result.fold((failure) => emit(EvaluacionError(failure.properties.first)),
        (data) => emit(EvaluacionSaved(evaluacion: evaluacionEntity)));
  }

  void initState() => emit(EvaluacionInitial());

  void changeResumen(String value) {
    final resumenChanged = state.evaluacion.copyWith(resumen: value);
    emit(EvaluacionLoaded(resumenChanged));
  }

  void changeFortalezas(String value) {
    final fortalezasChanged = state.evaluacion.copyWith(fortalezas: value);
    emit(EvaluacionLoaded(fortalezasChanged));
  }

  void changeDebilidades(String value) {
    final debilidadesChanged = state.evaluacion.copyWith(debilidades: value);
    emit(EvaluacionLoaded(debilidadesChanged));
  }

  void changeRiesgos(String value) {
    final riesgosChanged = state.evaluacion.copyWith(riesgos: value);
    emit(EvaluacionLoaded(riesgosChanged));
  }

  void changeFinalizado(String value) {
    state.evaluacion.copyWith(finalizado: value);
  }
}
