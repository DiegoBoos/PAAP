part of 'estado_visita_cubit.dart';

abstract class EstadoVisitaState extends Equatable {
  final List<EstadoVisitaEntity>? estadosVisitas;
  const EstadoVisitaState({this.estadosVisitas});

  @override
  List<Object?> get props => [estadosVisitas];
}

class EstadosVisitasInitial extends EstadoVisitaState {}

class EstadosVisitasLoading extends EstadoVisitaState {}

class EstadosVisitasLoaded extends EstadoVisitaState {
  final List<EstadoVisitaEntity>? estadosVisitasLoaded;

  const EstadosVisitasLoaded(this.estadosVisitasLoaded)
      : super(estadosVisitas: estadosVisitasLoaded);
}

class EstadosVisitasError extends EstadoVisitaState {
  final String message;

  const EstadosVisitasError(this.message);

  @override
  List<Object?> get props => [message];
}
