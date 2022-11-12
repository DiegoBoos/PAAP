part of 'evaluacion_respuesta_cubit.dart';

abstract class EvaluacionRespuestaState extends Equatable {
  const EvaluacionRespuestaState();

  @override
  List<Object?> get props => [];
}

class EvaluacionRespuestaInitial extends EvaluacionRespuestaState {}

class EvaluacionRespuestaLoading extends EvaluacionRespuestaState {}

class EvaluacionRespuestaSaved extends EvaluacionRespuestaState {}

class EvaluacionRespuestaCleared extends EvaluacionRespuestaState {}

class EvaluacionRespuestaError extends EvaluacionRespuestaState {
  final String message;

  const EvaluacionRespuestaError(this.message);

  @override
  List<Object?> get props => [message];
}
