part of 'frecuencia_cubit.dart';

abstract class FrecuenciaState extends Equatable {
  final List<FrecuenciaEntity>? frecuencia;
  const FrecuenciaState({this.frecuencia});

  @override
  List<Object?> get props => [frecuencia];
}

class FrecuenciaInitial extends FrecuenciaState {}

class FrecuenciaLoading extends FrecuenciaState {}

class FrecuenciaLoaded extends FrecuenciaState {
  final List<FrecuenciaEntity>? frecuenciaLoaded;

  const FrecuenciaLoaded(this.frecuenciaLoaded)
      : super(frecuencia: frecuenciaLoaded);
}

class FrecuenciaError extends FrecuenciaState {
  final String message;

  const FrecuenciaError(this.message);

  @override
  List<Object?> get props => [message];
}
