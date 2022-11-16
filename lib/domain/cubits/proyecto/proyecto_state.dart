part of 'proyecto_cubit.dart';

abstract class ProyectoState extends Equatable {
  final List<ProyectoEntity>? proyectos;
  const ProyectoState({this.proyectos});

  @override
  List<Object?> get props => [proyectos];
}

class ProyectosInitial extends ProyectoState {}

class ProyectosLoading extends ProyectoState {}

class ProyectosLoaded extends ProyectoState {
  final List<ProyectoEntity>? proyectosLoaded;

  const ProyectosLoaded(this.proyectosLoaded)
      : super(proyectos: proyectosLoaded);
}

class ProyectosError extends ProyectoState {
  final String message;

  const ProyectosError(this.message);

  @override
  List<Object?> get props => [message];
}
