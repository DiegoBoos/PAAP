part of 'perfil_preinversion_cofinanciador_cubit.dart';

abstract class PerfilPreInversionCofinanciadorState extends Equatable {
  final PerfilPreInversionCofinanciadorEntity? perfilPreInversionCofinanciador;
  const PerfilPreInversionCofinanciadorState(
      {this.perfilPreInversionCofinanciador});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciador];
}

class PerfilPreInversionCofinanciadorInitial
    extends PerfilPreInversionCofinanciadorState {
  PerfilPreInversionCofinanciadorInitial()
      : super(
            perfilPreInversionCofinanciador:
                PerfilPreInversionCofinanciadorEntity(
          perfilPreInversionId: '0',
          cofinanciadorId: '',
          monto: '',
          participacion: '',
          recordStatus: '',
        ));
}

class PerfilPreInversionCofinanciadorLoading
    extends PerfilPreInversionCofinanciadorState {}

class PerfilPreInversionCofinanciadorLoaded
    extends PerfilPreInversionCofinanciadorState {
  final PerfilPreInversionCofinanciadorEntity?
      perfilPreInversionCofinanciadorLoaded;

  const PerfilPreInversionCofinanciadorLoaded(
      this.perfilPreInversionCofinanciadorLoaded)
      : super(
            perfilPreInversionCofinanciador:
                perfilPreInversionCofinanciadorLoaded);
}

class PerfilPreInversionCofinanciadorSaved
    extends PerfilPreInversionCofinanciadorState {}

class PerfilPreInversionCofinanciadorError
    extends PerfilPreInversionCofinanciadorState {
  final String message;

  const PerfilPreInversionCofinanciadorError(this.message);

  @override
  List<Object?> get props => [message];
}
