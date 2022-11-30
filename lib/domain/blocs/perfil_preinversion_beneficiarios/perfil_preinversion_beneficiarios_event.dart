part of 'perfil_preinversion_beneficiarios_bloc.dart';

abstract class PerfilPreInversionBeneficiariosEvent extends Equatable {
  const PerfilPreInversionBeneficiariosEvent();

  @override
  List<Object> get props => [];
}

class InitState extends PerfilPreInversionBeneficiariosEvent {}

class GetPerfilPreInversionBeneficiarios
    extends PerfilPreInversionBeneficiariosEvent {
  final String perfilPreInversionId;

  const GetPerfilPreInversionBeneficiarios(this.perfilPreInversionId);
}
