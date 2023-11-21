part of 'tipo_visita_cubit.dart';

abstract class TipoVisitaState extends Equatable {
  final List<TipoVisitaEntity>? tiposVisitas;
  const TipoVisitaState({this.tiposVisitas});

  @override
  List<Object?> get props => [tiposVisitas];
}

class TiposVisitasInitial extends TipoVisitaState {}

class TiposVisitasLoading extends TipoVisitaState {}

class TiposVisitasLoaded extends TipoVisitaState {
  final List<TipoVisitaEntity>? tiposVisitasLoaded;

  const TiposVisitasLoaded(this.tiposVisitasLoaded)
      : super(tiposVisitas: tiposVisitasLoaded);
}

class TiposVisitasError extends TipoVisitaState {
  final String message;

  const TiposVisitasError(this.message);

  @override
  List<Object?> get props => [message];
}
