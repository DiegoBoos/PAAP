part of 'tipo_identificacion_cubit.dart';

abstract class TipoIdentificacionState extends Equatable {
  final List<TipoIdentificacionEntity>? tiposIdentificaciones;
  const TipoIdentificacionState({this.tiposIdentificaciones});

  @override
  List<Object?> get props => [tiposIdentificaciones];
}

class TiposIdentificacionesInitial extends TipoIdentificacionState {}

class TiposIdentificacionesLoading extends TipoIdentificacionState {}

class TiposIdentificacionesLoaded extends TipoIdentificacionState {
  final List<TipoIdentificacionEntity>? tiposIdentificacionesLoaded;

  const TiposIdentificacionesLoaded(this.tiposIdentificacionesLoaded)
      : super(tiposIdentificaciones: tiposIdentificacionesLoaded);
}

class TiposIdentificacionesError extends TipoIdentificacionState {
  final String message;

  const TiposIdentificacionesError(this.message);

  @override
  List<Object?> get props => [message];
}
