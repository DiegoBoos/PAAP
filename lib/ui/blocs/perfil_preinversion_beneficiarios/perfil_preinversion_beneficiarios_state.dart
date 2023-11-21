part of 'perfil_preinversion_beneficiarios_bloc.dart';

abstract class PerfilPreInversionBeneficiariosState extends Equatable {
  final List<PerfilPreInversionBeneficiarioEntity>?
      perfilPreInversionBeneficiarios;

  const PerfilPreInversionBeneficiariosState(
      {this.perfilPreInversionBeneficiarios});

  @override
  List<Object> get props => [];
}

class PerfilPreInversionBeneficiariosInitial
    extends PerfilPreInversionBeneficiariosState {
  PerfilPreInversionBeneficiariosInitial()
      : super(perfilPreInversionBeneficiarios: []);
}

class PerfilPreInversionBeneficiariosLoading
    extends PerfilPreInversionBeneficiariosState {}

class PerfilPreInversionBeneficiariosLoaded
    extends PerfilPreInversionBeneficiariosState {
  final List<PerfilPreInversionBeneficiarioEntity>
      perfilPreInversionBeneficiariosLoaded;

  const PerfilPreInversionBeneficiariosLoaded(
      this.perfilPreInversionBeneficiariosLoaded)
      : super(
            perfilPreInversionBeneficiarios:
                perfilPreInversionBeneficiariosLoaded);
}

class PerfilPreInversionBeneficiariosError
    extends PerfilPreInversionBeneficiariosState {
  final String message;

  PerfilPreInversionBeneficiariosError(this.message)
      : super(perfilPreInversionBeneficiarios: []);
}
