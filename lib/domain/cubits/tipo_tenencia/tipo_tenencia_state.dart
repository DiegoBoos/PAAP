part of 'tipo_tenencia_cubit.dart';

abstract class TipoTenenciaState extends Equatable {
  final List<TipoTenenciaEntity>? tipoTenencia;
  const TipoTenenciaState({this.tipoTenencia});

  @override
  List<Object?> get props => [tipoTenencia];
}

class TipoTenenciaInitial extends TipoTenenciaState {}

class TipoTenenciaLoading extends TipoTenenciaState {}

class TipoTenenciaLoaded extends TipoTenenciaState {
  final List<TipoTenenciaEntity>? tipoTenenciaLoaded;

  const TipoTenenciaLoaded(this.tipoTenenciaLoaded)
      : super(tipoTenencia: tipoTenenciaLoaded);
}

class TipoTenenciaError extends TipoTenenciaState {
  final String message;

  const TipoTenenciaError(this.message);

  @override
  List<Object?> get props => [message];
}
