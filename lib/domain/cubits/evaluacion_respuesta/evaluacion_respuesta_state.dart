part of 'evaluacion_respuesta_cubit.dart';

abstract class EvaluacionRespuestaState extends Equatable {
  final List<EvaluacionRespuestaEntity> evaluacionesRespuestas;
  const EvaluacionRespuestaState({required this.evaluacionesRespuestas});

  @override
  List<Object?> get props => [evaluacionesRespuestas];
}

class EvaluacionesRespuestasInitial extends EvaluacionRespuestaState {
  EvaluacionesRespuestasInitial() : super(evaluacionesRespuestas: []);
}

class EvaluacionesRespuestasLoading extends EvaluacionRespuestaState {
  const EvaluacionesRespuestasLoading({required super.evaluacionesRespuestas});
}

class EvaluacionesRespuestasLoaded extends EvaluacionRespuestaState {
  final List<EvaluacionRespuestaEntity> evaluacionesRespuestasLoaded;

  const EvaluacionesRespuestasLoaded(this.evaluacionesRespuestasLoaded)
      : super(evaluacionesRespuestas: evaluacionesRespuestasLoaded);
}

class EvaluacionesRespuestasChanged extends EvaluacionRespuestaState {
  final List<EvaluacionRespuestaEntity> evaluacionesRespuestasChanged;

  const EvaluacionesRespuestasChanged(this.evaluacionesRespuestasChanged)
      : super(evaluacionesRespuestas: evaluacionesRespuestasChanged);
}

class EvaluacionesRespuestasSaved extends EvaluacionRespuestaState {
  EvaluacionesRespuestasSaved() : super(evaluacionesRespuestas: []);
}

class EvaluacionesRespuestasCleared extends EvaluacionRespuestaState {
  EvaluacionesRespuestasCleared() : super(evaluacionesRespuestas: []);
}

class EvaluacionesRespuestasError extends EvaluacionRespuestaState {
  final String message;

  EvaluacionesRespuestasError(this.message) : super(evaluacionesRespuestas: []);

  @override
  List<Object?> get props => [message];
}
