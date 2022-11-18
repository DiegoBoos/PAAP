part of 'perfil_preinversion_cofinanciador_desembolso_cubit.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsotate extends Equatable {
  final PerfilPreInversionCofinanciadorDesembolsoEntity?
      perfilPreInversionCofinanciadorDesembolso;

  const PerfilPreInversionCofinanciadorDesembolsotate(
      {this.perfilPreInversionCofinanciadorDesembolso});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciadorDesembolso];
}

class PerfilPreInversionCofinanciadorDesembolsoInitial
    extends PerfilPreInversionCofinanciadorDesembolsotate {}

class PerfilPreInversionCofinanciadorDesembolsoLoading
    extends PerfilPreInversionCofinanciadorDesembolsotate {}

class PerfilPreInversionCofinanciadorDesembolsoLoaded
    extends PerfilPreInversionCofinanciadorDesembolsotate {
  final PerfilPreInversionCofinanciadorDesembolsoEntity?
      perfilPreInversionCofinanciadorDesembolsoLoaded;

  const PerfilPreInversionCofinanciadorDesembolsoLoaded(
      this.perfilPreInversionCofinanciadorDesembolsoLoaded)
      : super(
            perfilPreInversionCofinanciadorDesembolso:
                perfilPreInversionCofinanciadorDesembolsoLoaded);
}

class PerfilPreInversionCofinanciadorDesembolsoError
    extends PerfilPreInversionCofinanciadorDesembolsotate {
  final String message;

  const PerfilPreInversionCofinanciadorDesembolsoError(this.message);
  @override
  List<Object?> get props => [message];
}
