part of 'evaluacion_cubit.dart';

abstract class EvaluacionState extends Equatable {
  final EvaluacionEntity? evaluacion;
  const EvaluacionState({this.evaluacion});

  @override
  List<Object?> get props => [evaluacion];
}

class EvaluacionInitial extends EvaluacionState {}

class EvaluacionLoading extends EvaluacionState {}

class EvaluacionLoaded extends EvaluacionState {
  final EvaluacionEntity? evaluacionLoaded;

  const EvaluacionLoaded(this.evaluacionLoaded)
      : super(evaluacion: evaluacionLoaded);
}

class EvaluacionSaved extends EvaluacionState {}

class EvaluacionCleared extends EvaluacionState {}

class EvaluacionError extends EvaluacionState {
  final String message;

  const EvaluacionError(this.message);

  @override
  List<Object?> get props => [message];
}
