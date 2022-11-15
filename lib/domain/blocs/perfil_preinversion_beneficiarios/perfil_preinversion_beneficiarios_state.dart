part of 'perfil_preinversion_beneficiarios_bloc.dart';

abstract class PerfilPreInversionBeneficiariostate extends Equatable {
  const PerfilPreInversionBeneficiariostate();

  @override
  List<Object> get props => [];
}

class PerfilPreInversionBeneficiariosInitial
    extends PerfilPreInversionBeneficiariostate {}

class PerfilPreInversionBeneficiariosLoading
    extends PerfilPreInversionBeneficiariostate {}

class PerfilPreInversionBeneficiariosLoaded
    extends PerfilPreInversionBeneficiariostate {
  final List<PerfilPreInversionBeneficiarioEntity>?
      perfilPreInversionBeneficiariosLoaded;

  const PerfilPreInversionBeneficiariosLoaded(
      {this.perfilPreInversionBeneficiariosLoaded});
}

class PerfilPreInversionBeneficiariosError
    extends PerfilPreInversionBeneficiariostate {
  final String message;

  const PerfilPreInversionBeneficiariosError(this.message);
}
