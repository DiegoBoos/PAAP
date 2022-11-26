part of 'actividad_cubit.dart';

abstract class ActividadState extends Equatable {
  final List<ActividadEntity>? actividades;
  const ActividadState({this.actividades});

  @override
  List<Object?> get props => [actividades];
}

class ActividadesInitial extends ActividadState {}

class ActividadesLoading extends ActividadState {}

class ActividadesLoaded extends ActividadState {
  final List<ActividadEntity>? actividadesLoaded;

  const ActividadesLoaded(this.actividadesLoaded)
      : super(actividades: actividadesLoaded);
}

class ActividadesError extends ActividadState {
  final String message;

  const ActividadesError(this.message);

  @override
  List<Object?> get props => [message];
}
