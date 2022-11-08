part of 'residencia_cubit.dart';

abstract class ResidenciaState extends Equatable {
  final List<ResidenciaEntity>? residencias;
  const ResidenciaState({this.residencias});

  @override
  List<Object?> get props => [residencias];
}

class ResidenciasInitial extends ResidenciaState {}

class ResidenciasLoading extends ResidenciaState {}

class ResidenciasLoaded extends ResidenciaState {
  final List<ResidenciaEntity>? residenciasLoaded;

  const ResidenciasLoaded(this.residenciasLoaded)
      : super(residencias: residenciasLoaded);
}

class ResidenciasError extends ResidenciaState {
  final String message;

  const ResidenciasError(this.message);

  @override
  List<Object?> get props => [message];
}
