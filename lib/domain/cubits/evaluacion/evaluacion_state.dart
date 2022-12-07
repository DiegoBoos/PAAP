part of 'evaluacion_cubit.dart';

abstract class EvaluacionState extends Equatable {
  final EvaluacionEntity evaluacion;
  const EvaluacionState({required this.evaluacion});

  @override
  List<Object?> get props => [evaluacion];
}

class EvaluacionInitial extends EvaluacionState {
  EvaluacionInitial() : super(evaluacion: initObject());
}

class EvaluacionLoaded extends EvaluacionState {
  final EvaluacionEntity evaluacionLoaded;

  const EvaluacionLoaded(this.evaluacionLoaded)
      : super(evaluacion: evaluacionLoaded);
}

class EvaluacionSaved extends EvaluacionState {
  const EvaluacionSaved({required super.evaluacion});
}

class EvaluacionError extends EvaluacionState {
  final String message;

  EvaluacionError(this.message) : super(evaluacion: initObject());

  @override
  List<Object?> get props => [message];
}

EvaluacionEntity initObject() {
  return EvaluacionEntity(
      evaluacionId: '',
      perfilId: '',
      resumen: '',
      fortalezas: '',
      debilidades: '',
      riesgos: '',
      finalizado: '',
      usuarioIdCoordinador: '',
      fechaEvaluacion: '',
      preAprobado: '',
      recordStatus: '',
      remoteEvaluacionId: '');
}
