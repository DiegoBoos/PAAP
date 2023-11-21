part of 'experiencia_pecuaria_cubit.dart';

abstract class ExperienciaPecuariaState extends Equatable {
  final ExperienciaPecuariaEntity experienciaPecuaria;
  const ExperienciaPecuariaState({required this.experienciaPecuaria});

  @override
  List<Object?> get props => [experienciaPecuaria];
}

class ExperienciaPecuariaInitial extends ExperienciaPecuariaState {
  ExperienciaPecuariaInitial() : super(experienciaPecuaria: initObject());
}

class ExperienciaPecuariaLoading extends ExperienciaPecuariaState {
  ExperienciaPecuariaLoading() : super(experienciaPecuaria: initObject());
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
  ExperienciaPecuariaSaved() : super(experienciaPecuaria: initObject());
}

class ExperienciaPecuariaError extends ExperienciaPecuariaState {
  final String message;

  ExperienciaPecuariaError(this.message)
      : super(experienciaPecuaria: initObject());

  @override
  List<Object?> get props => [message];
}

ExperienciaPecuariaEntity initObject() {
  return ExperienciaPecuariaEntity(
    beneficiarioId: '',
    cantidadAnimales: '',
    cantidadCria: '',
    cantidadLevante: '',
    cantidadCeba: '',
    cantidadLeche: '',
    valorJornal: '',
    costosInsumos: '',
    ingresos: '',
    recordStatus: '',
  );
}
