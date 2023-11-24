part of 'alianza_beneficiario_cubit.dart';

abstract class AlianzaBeneficiarioState extends Equatable {
  final AlianzaBeneficiarioEntity alianzaBeneficiario;
  const AlianzaBeneficiarioState({required this.alianzaBeneficiario});

  @override
  List<Object?> get props => [alianzaBeneficiario];
}

class AlianzaBeneficiarioInitial extends AlianzaBeneficiarioState {
  AlianzaBeneficiarioInitial()
      : super(alianzaBeneficiario: AlianzaBeneficiarioEntity());
}

class AlianzaBeneficiarioLoaded extends AlianzaBeneficiarioState {
  final AlianzaBeneficiarioEntity alianzaBeneficiarioLoaded;

  const AlianzaBeneficiarioLoaded(this.alianzaBeneficiarioLoaded)
      : super(alianzaBeneficiario: alianzaBeneficiarioLoaded);
}

class AlianzaBeneficiarioChanged extends AlianzaBeneficiarioState {
  final AlianzaBeneficiarioEntity alianzaBeneficiarioChanged;

  const AlianzaBeneficiarioChanged(this.alianzaBeneficiarioChanged)
      : super(alianzaBeneficiario: alianzaBeneficiarioChanged);
}

class AlianzaBeneficiarioSaved extends AlianzaBeneficiarioState {
  const AlianzaBeneficiarioSaved({required super.alianzaBeneficiario});
}

class AlianzaBeneficiarioError extends AlianzaBeneficiarioState {
  final String message;

  AlianzaBeneficiarioError(this.message)
      : super(alianzaBeneficiario: AlianzaBeneficiarioEntity());
  @override
  List<Object?> get props => [message];
}
