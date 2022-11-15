part of 'perfil_preinversion_cofinanciador_rubro_cubit.dart';

abstract class PerfilPreInversionCofinanciadorRubroState extends Equatable {
  final List<PerfilPreInversionCofinanciadorRubroEntity>?
      perfilPreInversionCofinanciadorRubros;

  const PerfilPreInversionCofinanciadorRubroState(
      {this.perfilPreInversionCofinanciadorRubros});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciadorRubros];
}

class PerfilPreInversionCofinanciadorRubrosInitial
    extends PerfilPreInversionCofinanciadorRubroState {}

class PerfilPreInversionCofinanciadorRubrosLoading
    extends PerfilPreInversionCofinanciadorRubroState {}

class PerfilPreInversionCofinanciadorRubrosLoaded
    extends PerfilPreInversionCofinanciadorRubroState {
  final List<PerfilPreInversionCofinanciadorRubroEntity>?
      perfilPreInversionCofinanciadorRubrosLoaded;

  const PerfilPreInversionCofinanciadorRubrosLoaded(
      this.perfilPreInversionCofinanciadorRubrosLoaded)
      : super(
            perfilPreInversionCofinanciadorRubros:
                perfilPreInversionCofinanciadorRubrosLoaded);
}

class PerfilPreInversionCofinanciadorRubrosError
    extends PerfilPreInversionCofinanciadorRubroState {
  final String message;

  const PerfilPreInversionCofinanciadorRubrosError(this.message);
  @override
  List<Object?> get props => [message];
}
