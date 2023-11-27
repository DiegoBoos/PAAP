part of 'perfil_beneficiario_cubit.dart';

abstract class PerfilBeneficiarioState extends Equatable {
  final PerfilBeneficiarioEntity perfilBeneficiario;
  const PerfilBeneficiarioState({required this.perfilBeneficiario});

  @override
  List<Object?> get props => [perfilBeneficiario];
}

class PerfilBeneficiarioInitial extends PerfilBeneficiarioState {
  PerfilBeneficiarioInitial()
      : super(perfilBeneficiario: PerfilBeneficiarioEntity());
}

class PerfilBeneficiarioLoaded extends PerfilBeneficiarioState {
  final PerfilBeneficiarioEntity perfilBeneficiarioLoaded;

  const PerfilBeneficiarioLoaded(this.perfilBeneficiarioLoaded)
      : super(perfilBeneficiario: perfilBeneficiarioLoaded);
}

class PerfilBeneficiarioChanged extends PerfilBeneficiarioState {
  final PerfilBeneficiarioEntity perfilBeneficiarioChanged;

  const PerfilBeneficiarioChanged(this.perfilBeneficiarioChanged)
      : super(perfilBeneficiario: perfilBeneficiarioChanged);
}

class PerfilBeneficiarioSaved extends PerfilBeneficiarioState {
  const PerfilBeneficiarioSaved({required super.perfilBeneficiario});
}

class PerfilBeneficiarioError extends PerfilBeneficiarioState {
  final String message;

  PerfilBeneficiarioError(this.message)
      : super(perfilBeneficiario: PerfilBeneficiarioEntity());

  @override
  List<Object?> get props => [message];
}
