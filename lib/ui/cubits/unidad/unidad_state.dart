part of 'unidad_cubit.dart';

abstract class UnidadState extends Equatable {
  final List<UnidadEntity>? unidades;
  const UnidadState({this.unidades});

  @override
  List<Object?> get props => [unidades];
}

class UnidadesInitial extends UnidadState {}

class UnidadesLoading extends UnidadState {}

class UnidadesLoaded extends UnidadState {
  final List<UnidadEntity>? unidadesLoaded;

  const UnidadesLoaded(this.unidadesLoaded) : super(unidades: unidadesLoaded);
}

class UnidadesError extends UnidadState {
  final String message;

  const UnidadesError(this.message);

  @override
  List<Object?> get props => [message];
}
