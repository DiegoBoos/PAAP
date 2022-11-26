part of 'perfil_beneficiario_cubit.dart';

abstract class PerfilBeneficiarioState extends Equatable {
  final PerfilBeneficiarioEntity perfilBeneficiario;
  const PerfilBeneficiarioState({required this.perfilBeneficiario});

  @override
  List<Object?> get props => [perfilBeneficiario];
}

class PerfilBeneficiarioInitial extends PerfilBeneficiarioState {
  PerfilBeneficiarioInitial() : super(perfilBeneficiario: initObject());
}

class PerfilBeneficiarioLoading extends PerfilBeneficiarioState {
  PerfilBeneficiarioLoading() : super(perfilBeneficiario: initObject());
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
  PerfilBeneficiarioSaved() : super(perfilBeneficiario: initObject());
}

class PerfilBeneficiarioError extends PerfilBeneficiarioState {
  final String message;

  PerfilBeneficiarioError(this.message)
      : super(perfilBeneficiario: initObject());

  @override
  List<Object?> get props => [message];
}

PerfilBeneficiarioEntity initObject() {
  return PerfilBeneficiarioEntity(
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
  );
}
