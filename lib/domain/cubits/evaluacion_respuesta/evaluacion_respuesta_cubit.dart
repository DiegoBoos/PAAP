import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/evaluacion_respuesta_entity.dart';
import '../../usecases/evaluacion_respuesta/evaluacion_respuesta_db_usecase.dart';

part 'evaluacion_respuesta_state.dart';

class EvaluacionRespuestaCubit extends Cubit<EvaluacionRespuestaState> {
  final EvaluacionRespuestaUsecaseDB evaluacionRespuestaDB;

  EvaluacionRespuestaCubit({required this.evaluacionRespuestaDB})
      : super(EvaluacionRespuestaInitial());

  void initState() => emit(EvaluacionRespuestaInitial());

  void getEvaluacionRespuestaDB(String criterioId, String evaluacionId) async {
    final result = await evaluacionRespuestaDB.getEvaluacionRespuestaUsecaseDB(
        criterioId, evaluacionId);
    result.fold(
        (failure) => emit(EvaluacionRespuestaError(failure.properties.first)),
        (data) => emit(EvaluacionRespuestaLoaded(data!)));
  }

  selectEvaluacionRespuestaDB(
    EvaluacionRespuestaEntity evaluacionRespuesta,
  ) {
    emit(EvaluacionRespuestaLoaded(evaluacionRespuesta));
  }

  void saveEvaluacionRespuestaDB(
      EvaluacionRespuestaEntity evaluacionRespuestaEntity,
      String perfilId) async {
    final result = await evaluacionRespuestaDB.saveEvaluacionRespuestaUsecaseDB(
        evaluacionRespuestaEntity, perfilId);
    result.fold(
        (failure) => emit(EvaluacionRespuestaError(failure.properties.first)),
        (data) => emit(EvaluacionRespuestaSaved()));
  }

  void clearEvaluacionRespuestasDB() async {
    final result =
        await evaluacionRespuestaDB.clearEvaluacionesRespuestasUsecaseDB();
    result.fold(
        (failure) => emit(EvaluacionRespuestaError(failure.properties.first)),
        (data) => emit(EvaluacionRespuestaCleared()));
  }

  void changeCriterio(String criterioId) {
    final currentState = state;

    final newEvaluacionRespuesta =
        currentState.evaluacionRespuesta!.copyWith(criterioId: criterioId);
    emit(EvaluacionRespuestaLoaded(newEvaluacionRespuesta));
  }

  void changeOpcion(String opcionId) {
    final currentState = state;

    final newEvaluacionRespuesta =
        currentState.evaluacionRespuesta!.copyWith(opcionId: opcionId);
    emit(EvaluacionRespuestaLoaded(newEvaluacionRespuesta));
  }

  void changeObservacion(String observacion) {
    final currentState = state;

    final newEvaluacionRespuesta =
        currentState.evaluacionRespuesta!.copyWith(observacion: observacion);
    emit(EvaluacionRespuestaLoaded(newEvaluacionRespuesta));
  }
}
