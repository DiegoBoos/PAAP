import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/evaluacion_respuesta_entity.dart';
import '../../usecases/evaluacion_respuesta/evaluacion_respuesta_db_usecase.dart';

part 'evaluacion_respuesta_state.dart';

class EvaluacionRespuestaCubit extends Cubit<EvaluacionRespuestaState> {
  final EvaluacionRespuestaUsecaseDB evaluacionRespuestaDB;

  EvaluacionRespuestaCubit({required this.evaluacionRespuestaDB})
      : super(EvaluacionesRespuestasInitial());

  void initState() => emit(EvaluacionesRespuestasInitial());

  Future<List<EvaluacionRespuestaEntity>?> getEvaluacionesRespuestasDB(
      String criterioId, String evaluacionId) async {
    final result = await evaluacionRespuestaDB
        .getEvaluacionesRespuestasUsecaseDB(criterioId, evaluacionId);
    return result.fold((failure) => [], (data) => data);
  }

  selectEvaluacionesRespuestasDB(
    List<EvaluacionRespuestaEntity> evaluacionesRespuestas,
  ) {
    emit(EvaluacionesRespuestasLoaded(evaluacionesRespuestas));
  }

  void saveEvaluacionesRespuestasDB(
      List<EvaluacionRespuestaEntity> evaluacionesRespuestas,
      String perfilId) async {
    final result = await evaluacionRespuestaDB
        .saveEvaluacionesRespuestasUsecaseDB(evaluacionesRespuestas);
    result.fold(
        (failure) =>
            emit(EvaluacionesRespuestasError(failure.properties.first)),
        (data) => emit(EvaluacionesRespuestasSaved()));
  }

  void clearEvaluacionRespuestasDB() async {
    final result =
        await evaluacionRespuestaDB.clearEvaluacionesRespuestasUsecaseDB();
    result.fold(
        (failure) =>
            emit(EvaluacionesRespuestasError(failure.properties.first)),
        (data) => emit(EvaluacionesRespuestasCleared()));
  }

  void updateList(List<EvaluacionRespuestaEntity>? evaluacionesRespuestas) {
    emit(EvaluacionesRespuestasChanged(evaluacionesRespuestas!));
  }
}
