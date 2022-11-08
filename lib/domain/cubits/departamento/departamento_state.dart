part of 'departamento_cubit.dart';

abstract class DepartamentoState extends Equatable {
  final List<DepartamentoEntity>? departamentos;
  const DepartamentoState({this.departamentos});

  @override
  List<Object?> get props => [departamentos];
}

class DepartamentosInitial extends DepartamentoState {}

class DepartamentosLoading extends DepartamentoState {}

class DepartamentosLoaded extends DepartamentoState {
  final List<DepartamentoEntity>? departamentosLoaded;

  const DepartamentosLoaded(this.departamentosLoaded)
      : super(departamentos: departamentosLoaded);
}

class DepartamentosError extends DepartamentoState {
  final String message;

  const DepartamentosError(this.message);

  @override
  List<Object?> get props => [message];
}
