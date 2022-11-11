part of 'criterio_cubit.dart';

abstract class CriterioState extends Equatable {
  final List<CriterioEntity>? criterios;
  const CriterioState({this.criterios});

  @override
  List<Object?> get props => [criterios];
}

class CriteriosInitial extends CriterioState {}

class CriteriosLoading extends CriterioState {}

class CriteriosLoaded extends CriterioState {
  final List<CriterioEntity>? criteriosLoaded;

  const CriteriosLoaded(this.criteriosLoaded)
      : super(criterios: criteriosLoaded);
}

class CriteriosError extends CriterioState {
  final String message;

  const CriteriosError(this.message);

  @override
  List<Object?> get props => [message];
}
