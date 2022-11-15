part of 'perfil_preinversion_cofinanciador_desembolso_cubit.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsoState
    extends Equatable {
  final List<PerfilPreInversionCofinanciadorDesembolsoEntity>?
      perfilPreInversionCofinanciadorDesembolsos;

  const PerfilPreInversionCofinanciadorDesembolsoState(
      {this.perfilPreInversionCofinanciadorDesembolsos});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciadorDesembolsos];
}

class PerfilPreInversionCofinanciadorDesembolsosInitial
    extends PerfilPreInversionCofinanciadorDesembolsoState {}

class PerfilPreInversionCofinanciadorDesembolsosLoading
    extends PerfilPreInversionCofinanciadorDesembolsoState {}

class PerfilPreInversionCofinanciadorDesembolsosLoaded
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  final List<PerfilPreInversionCofinanciadorDesembolsoEntity>?
      perfilPreInversionCofinanciadorDesembolsosLoaded;

  const PerfilPreInversionCofinanciadorDesembolsosLoaded(
      this.perfilPreInversionCofinanciadorDesembolsosLoaded)
      : super(
            perfilPreInversionCofinanciadorDesembolsos:
                perfilPreInversionCofinanciadorDesembolsosLoaded);
}

class PerfilPreInversionCofinanciadorDesembolsosError
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  final String message;

  const PerfilPreInversionCofinanciadorDesembolsosError(this.message);
  @override
  List<Object?> get props => [message];
}
