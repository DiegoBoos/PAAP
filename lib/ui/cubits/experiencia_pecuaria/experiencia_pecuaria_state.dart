part of 'experiencia_pecuaria_cubit.dart';

abstract class ExperienciaPecuariaState extends Equatable {
  final ExperienciaPecuariaEntity experienciaPecuaria;
  const ExperienciaPecuariaState({required this.experienciaPecuaria});

  @override
  List<Object?> get props => [experienciaPecuaria];
}

class ExperienciaPecuariaInitial extends ExperienciaPecuariaState {
  ExperienciaPecuariaInitial()
      : super(experienciaPecuaria: ExperienciaPecuariaEntity());
}

class ExperienciaPecuariaLoaded extends ExperienciaPecuariaState {
  final ExperienciaPecuariaEntity experienciaPecuariaLoaded;

  const ExperienciaPecuariaLoaded(this.experienciaPecuariaLoaded)
      : super(experienciaPecuaria: experienciaPecuariaLoaded);
}

class ExperienciaPecuariaChanged extends ExperienciaPecuariaState {
  final ExperienciaPecuariaEntity experienciaPecuariaChanged;

  const ExperienciaPecuariaChanged(this.experienciaPecuariaChanged)
      : super(experienciaPecuaria: experienciaPecuariaChanged);
}

class ExperienciaPecuariaSaved extends ExperienciaPecuariaState {
  const ExperienciaPecuariaSaved({required super.experienciaPecuaria});
}

class ExperienciaPecuariaError extends ExperienciaPecuariaState {
  final String message;

  ExperienciaPecuariaError(this.message)
      : super(experienciaPecuaria: ExperienciaPecuariaEntity());

  @override
  List<Object?> get props => [message];
}
