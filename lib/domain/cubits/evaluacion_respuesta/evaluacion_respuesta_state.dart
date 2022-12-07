part of 'evaluacion_respuesta_cubit.dart';

abstract class EvaluacionRespuestaState extends Equatable {
  final EvaluacionRespuestaEntity evaluacionRespuesta;
  const EvaluacionRespuestaState({required this.evaluacionRespuesta});

  @override
  List<Object?> get props => [evaluacionRespuesta];
}

class EvaluacionRespuestaInitial extends EvaluacionRespuestaState {
  EvaluacionRespuestaInitial() : super(evaluacionRespuesta: initObject());
}

class EvaluacionRespuestaLoading extends EvaluacionRespuestaState {
  EvaluacionRespuestaLoading() : super(evaluacionRespuesta: initObject());
}

class EvaluacionRespuestaLoaded extends EvaluacionRespuestaState {
  final EvaluacionRespuestaEntity evaluacionRespuestaLoaded;

  const EvaluacionRespuestaLoaded(this.evaluacionRespuestaLoaded)
      : super(evaluacionRespuesta: evaluacionRespuestaLoaded);
}

class EvaluacionRespuestaSaved extends EvaluacionRespuestaState {
  const EvaluacionRespuestaSaved({required super.evaluacionRespuesta});
}

class EvaluacionRespuestaError extends EvaluacionRespuestaState {
  final String message;

  EvaluacionRespuestaError(this.message)
      : super(evaluacionRespuesta: initObject());

  @override
  List<Object?> get props => [message];
}

EvaluacionRespuestaEntity initObject() {
  return EvaluacionRespuestaEntity(
      criterioId: '',
      evaluacionId: '',
      observacion: '',
      opcionId: '',
      recordStatus: '',
      remoteEvaluacionId: '');
}
