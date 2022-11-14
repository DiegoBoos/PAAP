import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/evaluacion_entity.dart';
import '../../usecases/evaluacion/evaluacion_db_usecase.dart';
part 'evaluacion_state.dart';

class EvaluacionCubit extends Cubit<EvaluacionState> {
  final EvaluacionUsecaseDB evaluacionDB;

  EvaluacionCubit({required this.evaluacionDB}) : super(EvaluacionInitial());

  void getEvaluacionDB(String perfilId) async {
    final result = await evaluacionDB.getEvaluacionUsecaseDB(perfilId);
    result.fold((failure) => emit(EvaluacionError(failure.properties.first)),
        (data) => emit(EvaluacionLoaded(data)));
  }

  void saveEvaluacionDB(EvaluacionEntity evaluacionEntity) async {
    final result = await evaluacionDB.saveEvaluacionUsecaseDB(evaluacionEntity);
    result.fold((failure) => emit(EvaluacionError(failure.properties.first)),
        (data) => emit(EvaluacionSaved()));
  }

  void clearEvaluacionsDB() async {
    final result = await evaluacionDB.clearEvaluacionesUsecaseDB();
    result.fold((failure) => emit(EvaluacionError(failure.properties.first)),
        (data) => emit(EvaluacionCleared()));
  }

  void resetState() => emit(EvaluacionInitial());

  void changeResumen(String value) {
    state.evaluacion!.copyWith(resumen: value);
  }

  void changeFortalezas(String value) {
    state.evaluacion!.copyWith(fortalezas: value);
  }

  void changeDebilidades(String value) {
    state.evaluacion!.copyWith(debilidades: value);
  }

  void changeRiesgos(String value) {
    state.evaluacion!.copyWith(riesgos: value);
  }
}
