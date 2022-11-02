part of 'departamento_cubit.dart';

abstract class DepartamentoState extends Equatable {
  final List<DepartamentoEntity>? departamento;
  const DepartamentoState({this.departamento});

  @override
  List<Object?> get props => [departamento];
}

class DepartamentoInitial extends DepartamentoState {}

class DepartamentoLoading extends DepartamentoState {}

class DepartamentoLoaded extends DepartamentoState {
  final List<DepartamentoEntity>? departamentoLoaded;

  const DepartamentoLoaded(this.departamentoLoaded)
      : super(departamento: departamentoLoaded);
}

class DepartamentoError extends DepartamentoState {
  final String message;

  const DepartamentoError(this.message);

  @override
  List<Object?> get props => [message];
}
