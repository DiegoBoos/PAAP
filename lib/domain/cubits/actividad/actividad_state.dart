part of 'actividad_cubit.dart';

abstract class ActividadState extends Equatable {
  final ActividadEntity? actividad;
  const ActividadState({this.actividad});

  @override
  List<Object?> get props => [actividad];
}

class ActividadInitial extends ActividadState {}

class ActividadLoading extends ActividadState {}

class ActividadLoaded extends ActividadState {
  final ActividadEntity? actividadLoaded;

  const ActividadLoaded(this.actividadLoaded)
      : super(actividad: actividadLoaded);
}

class ActividadError extends ActividadState {
  final String message;

  const ActividadError(this.message);

  @override
  List<Object?> get props => [message];
}
