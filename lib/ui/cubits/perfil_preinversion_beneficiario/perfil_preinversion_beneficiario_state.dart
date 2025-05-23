part of 'perfil_preinversion_beneficiario_cubit.dart';

abstract class PerfilPreInversionBeneficiarioState extends Equatable {
  final PerfilPreInversionBeneficiarioEntity perfilPreInversionBeneficiario;
  const PerfilPreInversionBeneficiarioState(
      {required this.perfilPreInversionBeneficiario});

  @override
  List<Object?> get props => [perfilPreInversionBeneficiario];
}

class PerfilPreInversionBeneficiarioInitial
    extends PerfilPreInversionBeneficiarioState {
  PerfilPreInversionBeneficiarioInitial()
      : super(
            perfilPreInversionBeneficiario:
                PerfilPreInversionBeneficiarioEntity());
}

class PerfilPreInversionBeneficiarioLoaded
    extends PerfilPreInversionBeneficiarioState {
  final PerfilPreInversionBeneficiarioEntity
      perfilPreInversionBeneficiarioLoaded;

  const PerfilPreInversionBeneficiarioLoaded(
      this.perfilPreInversionBeneficiarioLoaded)
      : super(
            perfilPreInversionBeneficiario:
                perfilPreInversionBeneficiarioLoaded);
}

class PerfilPreInversionBeneficiarioChanged
    extends PerfilPreInversionBeneficiarioState {
  final PerfilPreInversionBeneficiarioEntity
      perfilPreInversionBeneficiarioChanged;

  const PerfilPreInversionBeneficiarioChanged(
      this.perfilPreInversionBeneficiarioChanged)
      : super(
            perfilPreInversionBeneficiario:
                perfilPreInversionBeneficiarioChanged);
}

class PerfilPreInversionBeneficiarioSaved
    extends PerfilPreInversionBeneficiarioState {
  const PerfilPreInversionBeneficiarioSaved(
      {required super.perfilPreInversionBeneficiario});
}

class PerfilPreInversionBeneficiarioError
    extends PerfilPreInversionBeneficiarioState {
  final String message;

  PerfilPreInversionBeneficiarioError(this.message)
      : super(
            perfilPreInversionBeneficiario:
                PerfilPreInversionBeneficiarioEntity());
  @override
  List<Object?> get props => [message];
}
