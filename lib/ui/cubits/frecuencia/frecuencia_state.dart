part of 'frecuencia_cubit.dart';

abstract class FrecuenciaState extends Equatable {
  final List<FrecuenciaEntity>? frecuencias;
  const FrecuenciaState({this.frecuencias});

  @override
  List<Object?> get props => [frecuencias];
}

class FrecuenciasInitial extends FrecuenciaState {}

class FrecuenciasLoading extends FrecuenciaState {}

class FrecuenciasLoaded extends FrecuenciaState {
  final List<FrecuenciaEntity>? frecuenciasLoaded;

  const FrecuenciasLoaded(this.frecuenciasLoaded)
      : super(frecuencias: frecuenciasLoaded);
}

class FrecuenciasError extends FrecuenciaState {
  final String message;

  const FrecuenciasError(this.message);

  @override
  List<Object?> get props => [message];
}
