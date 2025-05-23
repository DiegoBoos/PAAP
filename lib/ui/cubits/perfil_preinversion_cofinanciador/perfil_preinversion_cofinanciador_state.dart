part of 'perfil_preinversion_cofinanciador_cubit.dart';

abstract class PerfilPreInversionCofinanciadorState extends Equatable {
  final PerfilPreInversionCofinanciadorEntity perfilPreInversionCofinanciador;
  const PerfilPreInversionCofinanciadorState(
      {required this.perfilPreInversionCofinanciador});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciador];
}

class PerfilPreInversionCofinanciadorInitial
    extends PerfilPreInversionCofinanciadorState {
  PerfilPreInversionCofinanciadorInitial()
      : super(
            perfilPreInversionCofinanciador:
                PerfilPreInversionCofinanciadorEntity());
}

class PerfilPreInversionCofinanciadorLoaded
    extends PerfilPreInversionCofinanciadorState {
  final PerfilPreInversionCofinanciadorEntity
      perfilPreInversionCofinanciadorLoaded;

  const PerfilPreInversionCofinanciadorLoaded(
      this.perfilPreInversionCofinanciadorLoaded)
      : super(
            perfilPreInversionCofinanciador:
                perfilPreInversionCofinanciadorLoaded);
}

class PerfilPreInversionCofinanciadorChanged
    extends PerfilPreInversionCofinanciadorState {
  final PerfilPreInversionCofinanciadorEntity
      perfilPreInversionCofinanciadorChanged;

  const PerfilPreInversionCofinanciadorChanged(
      this.perfilPreInversionCofinanciadorChanged)
      : super(
            perfilPreInversionCofinanciador:
                perfilPreInversionCofinanciadorChanged);
}

class PerfilPreInversionCofinanciadorSaved
    extends PerfilPreInversionCofinanciadorState {
  const PerfilPreInversionCofinanciadorSaved(
      {required super.perfilPreInversionCofinanciador});
}

class PerfilPreInversionCofinanciadorError
    extends PerfilPreInversionCofinanciadorState {
  final String message;

  PerfilPreInversionCofinanciadorError(this.message)
      : super(
            perfilPreInversionCofinanciador:
                PerfilPreInversionCofinanciadorEntity());

  @override
  List<Object?> get props => [message];
}
