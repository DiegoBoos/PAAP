part of 'tipo_identificacion_cubit.dart';

abstract class TipoIdentificacionState extends Equatable {
  final List<TipoIdentificacionEntity>? tipoIdentificacion;
  const TipoIdentificacionState({this.tipoIdentificacion});

  @override
  List<Object?> get props => [tipoIdentificacion];
}

class TipoIdentificacionInitial extends TipoIdentificacionState {}

class TipoIdentificacionLoading extends TipoIdentificacionState {}

class TipoIdentificacionLoaded extends TipoIdentificacionState {
  final List<TipoIdentificacionEntity>? tipoIdentificacionLoaded;

  const TipoIdentificacionLoaded(this.tipoIdentificacionLoaded)
      : super(tipoIdentificacion: tipoIdentificacionLoaded);
}

class TipoIdentificacionError extends TipoIdentificacionState {
  final String message;

  const TipoIdentificacionError(this.message);

  @override
  List<Object?> get props => [message];
}
