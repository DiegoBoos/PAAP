part of 'evaluacion_respuesta_cubit.dart';

abstract class EvaluacionRespuestaState extends Equatable {
  final EvaluacionRespuestaEntity evaluacionRespuesta;
  const EvaluacionRespuestaState({required this.evaluacionRespuesta});

  @override
  List<Object?> get props => [evaluacionRespuesta];
}

class EvaluacionRespuestaInitial extends EvaluacionRespuestaState {
  EvaluacionRespuestaInitial()
      : super(evaluacionRespuesta: EvaluacionRespuestaEntity());
}

class EvaluacionRespuestaLoading extends EvaluacionRespuestaState {
  EvaluacionRespuestaLoading()
      : super(evaluacionRespuesta: EvaluacionRespuestaEntity());
}

class EvaluacionRespuestaLoaded extends EvaluacionRespuestaState {
  final EvaluacionRespuestaEntity evaluacionRespuestaLoaded;

  const EvaluacionRespuestaLoaded(this.evaluacionRespuestaLoaded)
      : super(evaluacionRespuesta: evaluacionRespuestaLoaded);
}

class EvaluacionRespuestaChanged extends EvaluacionRespuestaState {
  final EvaluacionRespuestaEntity evaluacionRespuestaChanged;

  const EvaluacionRespuestaChanged(this.evaluacionRespuestaChanged)
      : super(evaluacionRespuesta: evaluacionRespuestaChanged);
}

class EvaluacionRespuestaSaved extends EvaluacionRespuestaState {
  const EvaluacionRespuestaSaved({required super.evaluacionRespuesta});
}

class EvaluacionRespuestaError extends EvaluacionRespuestaState {
  final String message;

  EvaluacionRespuestaError(this.message)
      : super(evaluacionRespuesta: EvaluacionRespuestaEntity());

  @override
  List<Object?> get props => [message];
}
