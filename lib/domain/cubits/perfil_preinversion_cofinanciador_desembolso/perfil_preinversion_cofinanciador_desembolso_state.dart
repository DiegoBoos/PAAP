part of 'perfil_preinversion_cofinanciador_desembolso_cubit.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsoState
    extends Equatable {
  final PerfilPreInversionCofinanciadorDesembolsoEntity?
      perfilPreInversionCofinanciadorDesembolso;

  const PerfilPreInversionCofinanciadorDesembolsoState(
      {this.perfilPreInversionCofinanciadorDesembolso});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciadorDesembolso];
}

class PerfilPreInversionCofinanciadorDesembolsoInitial
    extends PerfilPreInversionCofinanciadorDesembolsoState {}

class PerfilPreInversionCofinanciadorDesembolsoLoading
    extends PerfilPreInversionCofinanciadorDesembolsoState {}

class PerfilPreInversionCofinanciadorDesembolsoLoaded
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  final PerfilPreInversionCofinanciadorDesembolsoEntity?
      perfilPreInversionCofinanciadorDesembolsoLoaded;

  const PerfilPreInversionCofinanciadorDesembolsoLoaded(
      this.perfilPreInversionCofinanciadorDesembolsoLoaded)
      : super(
            perfilPreInversionCofinanciadorDesembolso:
                perfilPreInversionCofinanciadorDesembolsoLoaded);
}

class PerfilPreInversionCofinanciadorDesembolsoSaved
    extends PerfilPreInversionCofinanciadorDesembolsoState {}

class PerfilPreInversionCofinanciadorDesembolsoError
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  final String message;

  const PerfilPreInversionCofinanciadorDesembolsoError(this.message);
  @override
  List<Object?> get props => [message];
}
