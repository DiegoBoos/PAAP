part of 'tipo_entidad_cubit.dart';

abstract class TipoEntidadState extends Equatable {
  final List<TipoEntidadEntity>? tiposEntidades;
  const TipoEntidadState({this.tiposEntidades});

  @override
  List<Object?> get props => [tiposEntidades];
}

class TiposEntidadesInitial extends TipoEntidadState {}

class TiposEntidadesLoading extends TipoEntidadState {}

class TiposEntidadesLoaded extends TipoEntidadState {
  final List<TipoEntidadEntity>? tiposEntidadesLoaded;

  const TiposEntidadesLoaded(this.tiposEntidadesLoaded)
      : super(tiposEntidades: tiposEntidadesLoaded);
}

class TiposEntidadesError extends TipoEntidadState {
  final String message;

  const TiposEntidadesError(this.message);

  @override
  List<Object?> get props => [message];
}
