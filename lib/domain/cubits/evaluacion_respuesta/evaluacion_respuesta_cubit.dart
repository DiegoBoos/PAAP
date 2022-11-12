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
        (data) => emit(EvaluacionRespuestaSaved()));
  }

  void saveEvaluacionRespuestaDB(
      EvaluacionRespuestaEntity evaluacionEntity) async {
    final result = await evaluacionRespuestaDB
        .saveEvaluacionRespuestaUsecaseDB(evaluacionEntity);
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
}
