part of 'evaluacion_cubit.dart';

abstract class EvaluacionState extends Equatable {
  final EvaluacionEntity evaluacion;
  const EvaluacionState({required this.evaluacion});

  @override
  List<Object?> get props => [evaluacion];
}

class EvaluacionInitial extends EvaluacionState {
  EvaluacionInitial() : super(evaluacion: EvaluacionEntity());
}

class EvaluacionLoaded extends EvaluacionState {
  final EvaluacionEntity evaluacionLoaded;

  const EvaluacionLoaded(this.evaluacionLoaded)
      : super(evaluacion: evaluacionLoaded);
}

class EvaluacionChanged extends EvaluacionState {
  final EvaluacionEntity evaluacionChanged;

  const EvaluacionChanged(this.evaluacionChanged)
      : super(evaluacion: evaluacionChanged);
}

class EvaluacionSaved extends EvaluacionState {
  const EvaluacionSaved({required super.evaluacion});
}

class EvaluacionError extends EvaluacionState {
  final String message;

  EvaluacionError(this.message) : super(evaluacion: EvaluacionEntity());

  @override
  List<Object?> get props => [message];
}
