part of 'perfil_preinversion_cofinanciador_rubro_cubit.dart';

abstract class PerfilPreInversionCofinanciadorRubroState extends Equatable {
  final PerfilPreInversionCofinanciadorRubroEntity
      perfilPreInversionCofinanciadorRubro;

  const PerfilPreInversionCofinanciadorRubroState(
      {required this.perfilPreInversionCofinanciadorRubro});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciadorRubro];
}

class PerfilPreInversionCofinanciadorRubroInitial
    extends PerfilPreInversionCofinanciadorRubroState {
  PerfilPreInversionCofinanciadorRubroInitial()
      : super(
            perfilPreInversionCofinanciadorRubro:
                PerfilPreInversionCofinanciadorRubroEntity());
}

class PerfilPreInversionCofinanciadorRubroLoaded
    extends PerfilPreInversionCofinanciadorRubroState {
  final PerfilPreInversionCofinanciadorRubroEntity
      perfilPreInversionCofinanciadorRubroLoaded;

  const PerfilPreInversionCofinanciadorRubroLoaded(
      this.perfilPreInversionCofinanciadorRubroLoaded)
      : super(
            perfilPreInversionCofinanciadorRubro:
                perfilPreInversionCofinanciadorRubroLoaded);
}

class PerfilPreInversionCofinanciadorRubroChanged
    extends PerfilPreInversionCofinanciadorRubroState {
  final PerfilPreInversionCofinanciadorRubroEntity
      perfilPreInversionCofinanciadorRubroChanged;

  const PerfilPreInversionCofinanciadorRubroChanged(
      this.perfilPreInversionCofinanciadorRubroChanged)
      : super(
            perfilPreInversionCofinanciadorRubro:
                perfilPreInversionCofinanciadorRubroChanged);
}

class PerfilPreInversionCofinanciadorRubroSaved
    extends PerfilPreInversionCofinanciadorRubroState {
  const PerfilPreInversionCofinanciadorRubroSaved(
      {required super.perfilPreInversionCofinanciadorRubro});
}

class PerfilPreInversionCofinanciadorRubroError
    extends PerfilPreInversionCofinanciadorRubroState {
  final String message;

  PerfilPreInversionCofinanciadorRubroError(this.message)
      : super(
            perfilPreInversionCofinanciadorRubro:
                PerfilPreInversionCofinanciadorRubroEntity());
  @override
  List<Object?> get props => [message];
}
