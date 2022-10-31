part of 'unidad_cubit.dart';

abstract class UnidadState extends Equatable {
  final List<UnidadEntity>? unidad;
  const UnidadState({this.unidad});

  @override
  List<Object?> get props => [unidad];
}

class UnidadInitial extends UnidadState {}

class UnidadLoading extends UnidadState {}

class UnidadLoaded extends UnidadState {
  final List<UnidadEntity>? unidadLoaded;

  const UnidadLoaded(this.unidadLoaded) : super(unidad: unidadLoaded);
}

class UnidadError extends UnidadState {
  final String message;

  const UnidadError(this.message);

  @override
  List<Object?> get props => [message];
}
