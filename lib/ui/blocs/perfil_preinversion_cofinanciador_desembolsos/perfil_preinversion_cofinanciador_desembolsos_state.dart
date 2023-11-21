part of 'perfil_preinversion_cofinanciador_desembolsos_bloc.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsosState
    extends Equatable {
  final List<PerfilPreInversionCofinanciadorDesembolsoEntity>?
      perfilPreInversionCofinanciadorDesembolsos;

  const PerfilPreInversionCofinanciadorDesembolsosState(
      {this.perfilPreInversionCofinanciadorDesembolsos});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciadorDesembolsos];
}

class PerfilPreInversionCofinanciadorDesembolsosInitial
    extends PerfilPreInversionCofinanciadorDesembolsosState {}

class PerfilPreInversionCofinanciadorDesembolsosLoading
    extends PerfilPreInversionCofinanciadorDesembolsosState {}

class PerfilPreInversionCofinanciadorDesembolsosLoaded
    extends PerfilPreInversionCofinanciadorDesembolsosState {
  final List<PerfilPreInversionCofinanciadorDesembolsoEntity>?
      perfilPreInversionCofinanciadorDesembolsosLoaded;

  const PerfilPreInversionCofinanciadorDesembolsosLoaded(
      this.perfilPreInversionCofinanciadorDesembolsosLoaded)
      : super(
            perfilPreInversionCofinanciadorDesembolsos:
                perfilPreInversionCofinanciadorDesembolsosLoaded);
}

class PerfilPreInversionCofinanciadorDesembolsosError
    extends PerfilPreInversionCofinanciadorDesembolsosState {
  final String message;

  const PerfilPreInversionCofinanciadorDesembolsosError(this.message);
  @override
  List<Object?> get props => [message];
}
