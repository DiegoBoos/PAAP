part of 'rubro_cubit.dart';

abstract class RubroState extends Equatable {
  final List<RubroEntity>? rubros;
  const RubroState({this.rubros});

  @override
  List<Object?> get props => [rubros];
}

class RubrosInitial extends RubroState {}

class RubrosLoading extends RubroState {}

class RubrosLoaded extends RubroState {
  final List<RubroEntity>? rubrosLoaded;

  const RubrosLoaded(this.rubrosLoaded) : super(rubros: rubrosLoaded);
}

class RubrosError extends RubroState {
  final String message;

  const RubrosError(this.message);

  @override
  List<Object?> get props => [message];
}
