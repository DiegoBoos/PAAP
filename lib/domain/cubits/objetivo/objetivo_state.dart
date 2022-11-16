part of 'objetivo_cubit.dart';

abstract class ObjetivoState extends Equatable {
  final List<ObjetivoEntity>? objetivos;
  const ObjetivoState({this.objetivos});

  @override
  List<Object?> get props => [objetivos];
}

class ObjetivosInitial extends ObjetivoState {}

class ObjetivosLoading extends ObjetivoState {}

class ObjetivosLoaded extends ObjetivoState {
  final List<ObjetivoEntity>? objetivosLoaded;

  const ObjetivosLoaded(this.objetivosLoaded)
      : super(objetivos: objetivosLoaded);
}

class ObjetivosError extends ObjetivoState {
  final String message;

  const ObjetivosError(this.message);

  @override
  List<Object?> get props => [message];
}
