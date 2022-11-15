part of 'perfil_preinversion_beneficiario_cubit.dart';

abstract class PerfilPreInversionBeneficiarioState extends Equatable {
  final PerfilPreInversionBeneficiarioEntity? perfilPreInversionBeneficiario;
  const PerfilPreInversionBeneficiarioState(
      {this.perfilPreInversionBeneficiario});

  @override
  List<Object?> get props => [perfilPreInversionBeneficiario];
}

class PerfilPreInversionBeneficiarioInitial
    extends PerfilPreInversionBeneficiarioState {}

class PerfilPreInversionBeneficiarioLoading
    extends PerfilPreInversionBeneficiarioState {}

class PerfilPreInversionBeneficiarioLoaded
    extends PerfilPreInversionBeneficiarioState {
  final PerfilPreInversionBeneficiarioEntity?
      perfilPreInversionBeneficiarioLoaded;

  const PerfilPreInversionBeneficiarioLoaded(
      this.perfilPreInversionBeneficiarioLoaded)
      : super(
            perfilPreInversionBeneficiario:
                perfilPreInversionBeneficiarioLoaded);
}

class PerfilPreInversionBeneficiarioError
    extends PerfilPreInversionBeneficiarioState {
  final String message;

  const PerfilPreInversionBeneficiarioError(this.message);

  @override
  List<Object?> get props => [message];
}
