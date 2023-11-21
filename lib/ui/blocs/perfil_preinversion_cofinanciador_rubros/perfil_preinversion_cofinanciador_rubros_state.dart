part of 'perfil_preinversion_cofinanciador_rubros_bloc.dart';

abstract class PerfilPreInversionCofinanciadorRubrosState extends Equatable {
  final List<PerfilPreInversionCofinanciadorRubroEntity>?
      perfilPreInversionCofinanciadorRubros;

  const PerfilPreInversionCofinanciadorRubrosState(
      {this.perfilPreInversionCofinanciadorRubros});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciadorRubros];
}

class PerfilPreInversionCofinanciadorRubrosInitial
    extends PerfilPreInversionCofinanciadorRubrosState {}

class PerfilPreInversionCofinanciadorRubrosLoading
    extends PerfilPreInversionCofinanciadorRubrosState {}

class PerfilPreInversionCofinanciadorRubrosLoaded
    extends PerfilPreInversionCofinanciadorRubrosState {
  final List<PerfilPreInversionCofinanciadorRubroEntity>?
      perfilPreInversionCofinanciadorRubrosLoaded;

  const PerfilPreInversionCofinanciadorRubrosLoaded(
      this.perfilPreInversionCofinanciadorRubrosLoaded)
      : super(
            perfilPreInversionCofinanciadorRubros:
                perfilPreInversionCofinanciadorRubrosLoaded);
}

class PerfilPreInversionCofinanciadorRubrosError
    extends PerfilPreInversionCofinanciadorRubrosState {
  final String message;

  const PerfilPreInversionCofinanciadorRubrosError(this.message);
  @override
  List<Object?> get props => [message];
}
