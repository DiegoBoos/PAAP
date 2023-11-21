part of 'tipo_proyecto_cubit.dart';

abstract class TipoProyectoState extends Equatable {
  final List<TipoProyectoEntity>? tiposProyectos;
  const TipoProyectoState({this.tiposProyectos});

  @override
  List<Object?> get props => [tiposProyectos];
}

class TiposProyectosInitial extends TipoProyectoState {}

class TiposProyectosLoading extends TipoProyectoState {}

class TiposProyectosLoaded extends TipoProyectoState {
  final List<TipoProyectoEntity>? tiposProyectosLoaded;

  const TiposProyectosLoaded(this.tiposProyectosLoaded)
      : super(tiposProyectos: tiposProyectosLoaded);
}

class TiposProyectosError extends TipoProyectoState {
  final String message;

  const TiposProyectosError(this.message);

  @override
  List<Object?> get props => [message];
}
