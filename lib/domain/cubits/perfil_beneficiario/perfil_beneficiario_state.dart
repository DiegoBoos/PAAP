part of 'perfil_beneficiario_cubit.dart';

abstract class PerfilBeneficiarioState extends Equatable {
  final PerfilBeneficiarioEntity? perfilBeneficiario;
  const PerfilBeneficiarioState({this.perfilBeneficiario});

  @override
  List<Object?> get props => [perfilBeneficiario];
}

class PerfilBeneficiarioInitial extends PerfilBeneficiarioState {
  PerfilBeneficiarioInitial()
      : super(
            perfilBeneficiario: PerfilBeneficiarioEntity(
          perfilId: '',
          beneficiarioId: '',
          municipioId: '',
          veredaId: '',
          areaFinca: '',
          areaProyecto: '',
          tipoTenenciaId: '',
          experiencia: '',
          asociado: '',
          conocePerfil: '',
          fueBeneficiado: '',
          cualBeneficio: '',
          activo: '',
          recordStatus: '',
        ));
}

class PerfilBeneficiarioLoading extends PerfilBeneficiarioState {}

class PerfilBeneficiarioLoaded extends PerfilBeneficiarioState {
  final PerfilBeneficiarioEntity? perfilBeneficiarioLoaded;

  const PerfilBeneficiarioLoaded(this.perfilBeneficiarioLoaded)
      : super(perfilBeneficiario: perfilBeneficiarioLoaded);
}

class PerfilBeneficiarioSaved extends PerfilBeneficiarioState {}

class PerfilBeneficiarioError extends PerfilBeneficiarioState {
  final String message;

  const PerfilBeneficiarioError(this.message);

  @override
  List<Object?> get props => [message];
}
