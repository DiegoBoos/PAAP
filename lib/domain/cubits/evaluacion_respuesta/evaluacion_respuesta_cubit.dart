import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/evaluacion_respuesta_entity.dart';
import '../../usecases/evaluacion_respuesta/evaluacion_respuesta_db_usecase.dart';

part 'evaluacion_respuesta_state.dart';

class EvaluacionRespuestaCubit extends Cubit<EvaluacionRespuestaState> {
  final EvaluacionRespuestaUsecaseDB evaluacionRespuestaDB;

  EvaluacionRespuestaCubit({required this.evaluacionRespuestaDB})
      : super(EvaluacionRespuestaInitial());

  void getEvaluacionRespuestaDB(String criterioId, String evaluacionId) async {
    final result = await evaluacionRespuestaDB.getEvaluacionRespuestaUsecaseDB(
        criterioId, evaluacionId);
    result.fold(
        (failure) => emit(EvaluacionRespuestaError(failure.properties.first)),
        (data) => emit(EvaluacionRespuestaLoaded(data!)));
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

  void initState() => emit(EvaluacionRespuestaInitial());

  void changeCriterio(String criterioId) {
    final criterioChanged =
        state.evaluacionRespuesta!.copyWith(criterioId: criterioId);
    emit(EvaluacionRespuestaLoaded(criterioChanged));
  }

  void changeOpcion(String opcionId) {
    final opcionChanged =
        state.evaluacionRespuesta!.copyWith(opcionId: opcionId);
    emit(EvaluacionRespuestaLoaded(opcionChanged));
  }

  void changeObservacion(String observacion) {
    final observacionChanged =
        state.evaluacionRespuesta!.copyWith(observacion: observacion);
    emit(EvaluacionRespuestaLoaded(observacionChanged));
  }
}
