part of 'tipo_tenencia_cubit.dart';

abstract class TipoTenenciaState extends Equatable {
  final List<TipoTenenciaEntity>? tiposTenencias;
  const TipoTenenciaState({this.tiposTenencias});

  @override
  List<Object?> get props => [tiposTenencias];
}

class TiposTenenciasInitial extends TipoTenenciaState {}

class TiposTenenciasLoading extends TipoTenenciaState {}

class TiposTenenciasLoaded extends TipoTenenciaState {
  final List<TipoTenenciaEntity>? tiposTenenciasLoaded;

  const TiposTenenciasLoaded(this.tiposTenenciasLoaded)
      : super(tiposTenencias: tiposTenenciasLoaded);
}

class TiposTenenciasError extends TipoTenenciaState {
  final String message;

  const TiposTenenciasError(this.message);

  @override
  List<Object?> get props => [message];
}
