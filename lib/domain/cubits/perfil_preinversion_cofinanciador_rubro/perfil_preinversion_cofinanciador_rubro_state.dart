part of 'perfil_preinversion_cofinanciador_rubro_cubit.dart';

abstract class PerfilPreInversionCofinanciadorRubroState extends Equatable {
  final PerfilPreInversionCofinanciadorRubroEntity?
      perfilPreInversionCofinanciadorRubro;

  const PerfilPreInversionCofinanciadorRubroState(
      {this.perfilPreInversionCofinanciadorRubro});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciadorRubro];
}

class PerfilPreInversionCofinanciadorRubroInitial
    extends PerfilPreInversionCofinanciadorRubroState {}

class PerfilPreInversionCofinanciadorRubroLoading
    extends PerfilPreInversionCofinanciadorRubroState {}

class PerfilPreInversionCofinanciadorRubroLoaded
    extends PerfilPreInversionCofinanciadorRubroState {
  final PerfilPreInversionCofinanciadorRubroEntity?
      perfilPreInversionCofinanciadorRubroLoaded;

  const PerfilPreInversionCofinanciadorRubroLoaded(
      this.perfilPreInversionCofinanciadorRubroLoaded)
      : super(
            perfilPreInversionCofinanciadorRubro:
                perfilPreInversionCofinanciadorRubroLoaded);
}

class PerfilPreInversionCofinanciadorRubroSaved
    extends PerfilPreInversionCofinanciadorRubroState {}

class PerfilPreInversionCofinanciadorRubroError
    extends PerfilPreInversionCofinanciadorRubroState {
  final String message;

  const PerfilPreInversionCofinanciadorRubroError(this.message);
  @override
  List<Object?> get props => [message];
}
