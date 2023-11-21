part of 'tipo_discapacidad_cubit.dart';

abstract class TipoDiscapacidadState extends Equatable {
  final List<TipoDiscapacidadEntity>? tiposDiscapacidades;
  const TipoDiscapacidadState({this.tiposDiscapacidades});

  @override
  List<Object?> get props => [tiposDiscapacidades];
}

class TiposDiscapacidadesInitial extends TipoDiscapacidadState {}

class TiposDiscapacidadesLoading extends TipoDiscapacidadState {}

class TiposDiscapacidadesLoaded extends TipoDiscapacidadState {
  final List<TipoDiscapacidadEntity>? tiposDiscapacidadesLoaded;

  const TiposDiscapacidadesLoaded(this.tiposDiscapacidadesLoaded)
      : super(tiposDiscapacidades: tiposDiscapacidadesLoaded);
}

class TiposDiscapacidadesError extends TipoDiscapacidadState {
  final String message;

  const TiposDiscapacidadesError(this.message);

  @override
  List<Object?> get props => [message];
}
