part of 'perfil_preinversion_cofinanciador_desembolso_cubit.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsoState
    extends Equatable {
  final PerfilPreInversionCofinanciadorDesembolsoEntity
      perfilPreInversionCofinanciadorDesembolso;

  const PerfilPreInversionCofinanciadorDesembolsoState(
      {required this.perfilPreInversionCofinanciadorDesembolso});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciadorDesembolso];
}

class PerfilPreInversionCofinanciadorDesembolsoInitial
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  PerfilPreInversionCofinanciadorDesembolsoInitial()
      : super(
            perfilPreInversionCofinanciadorDesembolso:
                PerfilPreInversionCofinanciadorDesembolsoEntity());
}

class PerfilPreInversionCofinanciadorDesembolsoLoaded
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  final PerfilPreInversionCofinanciadorDesembolsoEntity
      perfilPreInversionCofinanciadorDesembolsoLoaded;

  const PerfilPreInversionCofinanciadorDesembolsoLoaded(
      this.perfilPreInversionCofinanciadorDesembolsoLoaded)
      : super(
            perfilPreInversionCofinanciadorDesembolso:
                perfilPreInversionCofinanciadorDesembolsoLoaded);
}

class PerfilPreInversionCofinanciadorDesembolsoChanged
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  final PerfilPreInversionCofinanciadorDesembolsoEntity
      perfilPreInversionCofinanciadorDesembolsoChanged;

  const PerfilPreInversionCofinanciadorDesembolsoChanged(
      this.perfilPreInversionCofinanciadorDesembolsoChanged)
      : super(
            perfilPreInversionCofinanciadorDesembolso:
                perfilPreInversionCofinanciadorDesembolsoChanged);
}

class PerfilPreInversionCofinanciadorDesembolsoSaved
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  const PerfilPreInversionCofinanciadorDesembolsoSaved(
      {required super.perfilPreInversionCofinanciadorDesembolso});
}

class PerfilPreInversionCofinanciadorDesembolsoError
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  final String message;

  PerfilPreInversionCofinanciadorDesembolsoError(this.message)
      : super(
            perfilPreInversionCofinanciadorDesembolso:
                PerfilPreInversionCofinanciadorDesembolsoEntity());
  @override
  List<Object?> get props => [message];
}
