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
      : super(perfilPreInversionCofinanciadorDesembolso: initObject());
}

class PerfilPreInversionCofinanciadorDesembolsoLoading
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  const PerfilPreInversionCofinanciadorDesembolsoLoading(
      {required super.perfilPreInversionCofinanciadorDesembolso});
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
  PerfilPreInversionCofinanciadorDesembolsoSaved()
      : super(perfilPreInversionCofinanciadorDesembolso: initObject());
}

class PerfilPreInversionCofinanciadorDesembolsoError
    extends PerfilPreInversionCofinanciadorDesembolsoState {
  final String message;

  PerfilPreInversionCofinanciadorDesembolsoError(this.message)
      : super(perfilPreInversionCofinanciadorDesembolso: initObject());
  @override
  List<Object?> get props => [message];
}

PerfilPreInversionCofinanciadorDesembolsoEntity initObject() =>
    PerfilPreInversionCofinanciadorDesembolsoEntity(
        perfilPreInversionId: '',
        cofinanciadorId: '',
        desembolsoId: '',
        fecha: '',
        recordStatus: '');
