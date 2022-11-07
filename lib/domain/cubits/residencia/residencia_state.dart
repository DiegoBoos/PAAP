part of 'residencia_cubit.dart';

abstract class ResidenciaState extends Equatable {
  final List<ResidenciaEntity>? residencia;
  const ResidenciaState({this.residencia});

  @override
  List<Object?> get props => [residencia];
}

class ResidenciaInitial extends ResidenciaState {}

class ResidenciaLoading extends ResidenciaState {}

class ResidenciaLoaded extends ResidenciaState {
  final List<ResidenciaEntity>? residenciaLoaded;

  const ResidenciaLoaded(this.residenciaLoaded)
      : super(residencia: residenciaLoaded);
}

class ResidenciaError extends ResidenciaState {
  final String message;

  const ResidenciaError(this.message);

  @override
  List<Object?> get props => [message];
}
