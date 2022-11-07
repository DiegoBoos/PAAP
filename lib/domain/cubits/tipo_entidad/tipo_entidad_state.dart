part of 'tipo_entidad_cubit.dart';

abstract class TipoEntidadState extends Equatable {
  final List<TipoEntidadEntity>? tipoEntidad;
  const TipoEntidadState({this.tipoEntidad});

  @override
  List<Object?> get props => [tipoEntidad];
}

class TipoEntidadInitial extends TipoEntidadState {}

class TipoEntidadLoading extends TipoEntidadState {}

class TipoEntidadLoaded extends TipoEntidadState {
  final List<TipoEntidadEntity>? tipoEntidadLoaded;

  const TipoEntidadLoaded(this.tipoEntidadLoaded)
      : super(tipoEntidad: tipoEntidadLoaded);
}

class TipoEntidadError extends TipoEntidadState {
  final String message;

  const TipoEntidadError(this.message);

  @override
  List<Object?> get props => [message];
}
