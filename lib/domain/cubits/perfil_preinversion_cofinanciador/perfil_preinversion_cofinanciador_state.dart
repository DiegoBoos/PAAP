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
      : super(perfilPreInversionCofinanciador: initObject());
}

class PerfilPreInversionCofinanciadorLoading
    extends PerfilPreInversionCofinanciadorState {
  const PerfilPreInversionCofinanciadorLoading(
      {required super.perfilPreInversionCofinanciador});
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
  PerfilPreInversionCofinanciadorSaved()
      : super(perfilPreInversionCofinanciador: initObject());
}

class PerfilPreInversionCofinanciadorError
    extends PerfilPreInversionCofinanciadorState {
  final String message;

  PerfilPreInversionCofinanciadorError(this.message)
      : super(perfilPreInversionCofinanciador: initObject());

  @override
  List<Object?> get props => [message];
}

PerfilPreInversionCofinanciadorEntity initObject() {
  return PerfilPreInversionCofinanciadorEntity(
      perfilPreInversionId: '',
      cofinanciadorId: '',
      monto: '',
      participacion: '',
      recordStatus: '',
      isEditing: false);
}
