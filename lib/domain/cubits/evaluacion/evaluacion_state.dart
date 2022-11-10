part of 'evaluacion_cubit.dart';

abstract class EvaluacionState extends Equatable {
  const EvaluacionState();

  @override
  List<Object?> get props => [];
}

class EvaluacionInitial extends EvaluacionState {}

class EvaluacionLoading extends EvaluacionState {}

class EvaluacionSaved extends EvaluacionState {}

class EvaluacionCleared extends EvaluacionState {}

class EvaluacionError extends EvaluacionState {
  final String message;

  const EvaluacionError(this.message);

  @override
  List<Object?> get props => [message];
}
