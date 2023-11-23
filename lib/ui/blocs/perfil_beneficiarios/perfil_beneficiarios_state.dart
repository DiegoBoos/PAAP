part of 'perfil_beneficiarios_bloc.dart';

abstract class PerfilBeneficiariosState extends Equatable {
  final List<PerfilBeneficiarioEntity>? perfilBeneficiarios;

  const PerfilBeneficiariosState({this.perfilBeneficiarios});

  @override
  List<Object> get props => [];
}

class PerfilBeneficiariosInitial extends PerfilBeneficiariosState {
  PerfilBeneficiariosInitial() : super(perfilBeneficiarios: []);
}

class PerfilBeneficiariosLoading extends PerfilBeneficiariosState {}

class PerfilBeneficiariosLoaded extends PerfilBeneficiariosState {
  final List<PerfilBeneficiarioEntity> perfilBeneficiariosLoaded;

  const PerfilBeneficiariosLoaded(this.perfilBeneficiariosLoaded)
      : super(perfilBeneficiarios: perfilBeneficiariosLoaded);
}

class PerfilBeneficiariosError extends PerfilBeneficiariosState {
  final String message;

  PerfilBeneficiariosError(this.message) : super(perfilBeneficiarios: []);
}
