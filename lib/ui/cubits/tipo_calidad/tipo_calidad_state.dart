part of 'tipo_calidad_cubit.dart';

abstract class TipoCalidadState extends Equatable {
  final List<TipoCalidadEntity>? tiposCalidades;
  const TipoCalidadState({this.tiposCalidades});

  @override
  List<Object?> get props => [tiposCalidades];
}

class TiposCalidadesInitial extends TipoCalidadState {}

class TiposCalidadesLoading extends TipoCalidadState {}

class TiposCalidadesLoaded extends TipoCalidadState {
  final List<TipoCalidadEntity>? tiposCalidadesLoaded;

  const TiposCalidadesLoaded(this.tiposCalidadesLoaded)
      : super(tiposCalidades: tiposCalidadesLoaded);
}

class TiposCalidadesError extends TipoCalidadState {
  final String message;

  const TiposCalidadesError(this.message);

  @override
  List<Object?> get props => [message];
}
