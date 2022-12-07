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

  Future<EvaluacionRespuestaEntity?> getEvaluacionRespuestaDB(
      String criterioId, String evaluacionId) async {
    final result = await evaluacionRespuestaDB.getEvaluacionRespuestaUsecaseDB(
        criterioId, evaluacionId);
    return result.fold((failure) => null, (data) => data);
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
        (data) => emit(EvaluacionRespuestaSaved(
            evaluacionRespuesta: evaluacionRespuestaEntity)));
  }

  void changeCriterio(String criterioId) {
    final changeCriterio =
        state.evaluacionRespuesta.copyWith(criterioId: criterioId);
    emit(EvaluacionRespuestaLoaded(changeCriterio));
  }

  void changeOpcion(String opcionId) {
    final changeOpcion = state.evaluacionRespuesta.copyWith(opcionId: opcionId);
    emit(EvaluacionRespuestaLoaded(changeOpcion));
  }

  void changeObservacion(String observacion) {
    final changeObservacion =
        state.evaluacionRespuesta.copyWith(observacion: observacion);
    emit(EvaluacionRespuestaLoaded(changeObservacion));
  }

  void changeEvaluacion(String evaluacionId) {
    final changeEvaluacion =
        state.evaluacionRespuesta.copyWith(evaluacionId: evaluacionId);
    emit(EvaluacionRespuestaLoaded(changeEvaluacion));
  }
}
