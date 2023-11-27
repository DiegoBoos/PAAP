part of 'perfil_beneficiarios_bloc.dart';

abstract class PerfilBeneficiariosEvent extends Equatable {
  const PerfilBeneficiariosEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilBeneficiarios extends PerfilBeneficiariosEvent {
  final String perfilId;

  const GetPerfilBeneficiarios(this.perfilId);
}
