part of 'alianza_experiencia_pecuaria_cubit.dart';

abstract class AlianzaExperienciaPecuariaState extends Equatable {
  final AlianzaExperienciaPecuariaEntity alianzaExperienciaPecuaria;
  const AlianzaExperienciaPecuariaState(
      {required this.alianzaExperienciaPecuaria});

  @override
  List<Object?> get props => [alianzaExperienciaPecuaria];
}

class AlianzaExperienciaPecuariaInitial
    extends AlianzaExperienciaPecuariaState {
  AlianzaExperienciaPecuariaInitial()
      : super(alianzaExperienciaPecuaria: AlianzaExperienciaPecuariaEntity());
}

class AlianzaExperienciaPecuariaLoaded extends AlianzaExperienciaPecuariaState {
  final AlianzaExperienciaPecuariaEntity alianzaExperienciaPecuariaLoaded;

  const AlianzaExperienciaPecuariaLoaded(this.alianzaExperienciaPecuariaLoaded)
      : super(alianzaExperienciaPecuaria: alianzaExperienciaPecuariaLoaded);
}

class AlianzaExperienciaPecuariaChanged
    extends AlianzaExperienciaPecuariaState {
  final AlianzaExperienciaPecuariaEntity alianzaExperienciaPecuariaChanged;

  const AlianzaExperienciaPecuariaChanged(
      this.alianzaExperienciaPecuariaChanged)
      : super(alianzaExperienciaPecuaria: alianzaExperienciaPecuariaChanged);
}

class AlianzaExperienciaPecuariaSaved extends AlianzaExperienciaPecuariaState {
  const AlianzaExperienciaPecuariaSaved(
      {required super.alianzaExperienciaPecuaria});
}

class AlianzaExperienciaPecuariaError extends AlianzaExperienciaPecuariaState {
  final String message;

  AlianzaExperienciaPecuariaError(this.message)
      : super(alianzaExperienciaPecuaria: AlianzaExperienciaPecuariaEntity());

  @override
  List<Object?> get props => [message];
}
