part of 'tipo_calidad_cubit.dart';

abstract class TipoCalidadState extends Equatable {
  final List<TipoCalidadEntity>? tipoCalidad;
  const TipoCalidadState({this.tipoCalidad});

  @override
  List<Object?> get props => [tipoCalidad];
}

class TipoCalidadInitial extends TipoCalidadState {}

class TipoCalidadLoading extends TipoCalidadState {}

class TipoCalidadLoaded extends TipoCalidadState {
  final List<TipoCalidadEntity>? tipoCalidadLoaded;

  const TipoCalidadLoaded(this.tipoCalidadLoaded)
      : super(tipoCalidad: tipoCalidadLoaded);
}

class TipoCalidadError extends TipoCalidadState {
  final String message;

  const TipoCalidadError(this.message);

  @override
  List<Object?> get props => [message];
}
