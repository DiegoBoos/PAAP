part of 'evaluacion_respuesta_cubit.dart';

abstract class EvaluacionRespuestaState extends Equatable {
  final EvaluacionRespuestaEntity? evaluacionRespuesta;
  const EvaluacionRespuestaState({this.evaluacionRespuesta});

  @override
  List<Object?> get props => [evaluacionRespuesta];
}

class EvaluacionRespuestaInitial extends EvaluacionRespuestaState {
  EvaluacionRespuestaInitial()
      : super(
            evaluacionRespuesta: EvaluacionRespuestaEntity(
                criterioId: '',
                evaluacionId: '',
                observacion: '',
                opcionId: '',
                recordStatus: ''));
}

class EvaluacionRespuestaLoading extends EvaluacionRespuestaState {}

class EvaluacionRespuestaLoaded extends EvaluacionRespuestaState {
  final EvaluacionRespuestaEntity evaluacionRespuestaLoaded;

  const EvaluacionRespuestaLoaded(this.evaluacionRespuestaLoaded)
      : super(evaluacionRespuesta: evaluacionRespuestaLoaded);
}

class EvaluacionRespuestaSaved extends EvaluacionRespuestaState {}

class EvaluacionRespuestaCleared extends EvaluacionRespuestaState {}

class EvaluacionRespuestaError extends EvaluacionRespuestaState {
  final String message;

  const EvaluacionRespuestaError(this.message);

  @override
  List<Object?> get props => [message];
}
