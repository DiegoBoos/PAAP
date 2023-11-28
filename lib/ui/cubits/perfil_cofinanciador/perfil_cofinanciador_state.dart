part of 'perfil_cofinanciador_cubit.dart';

abstract class PerfilCofinanciadorState extends Equatable {
  final PerfilCofinanciadorEntity perfilCofinanciador;
  const PerfilCofinanciadorState({required this.perfilCofinanciador});

  @override
  List<Object?> get props => [perfilCofinanciador];
}

class PerfilCofinanciadorInitial extends PerfilCofinanciadorState {
  PerfilCofinanciadorInitial()
      : super(perfilCofinanciador: PerfilCofinanciadorEntity());
}

class PerfilCofinanciadorLoaded extends PerfilCofinanciadorState {
  final PerfilCofinanciadorEntity perfilCofinanciadorLoaded;

  const PerfilCofinanciadorLoaded(this.perfilCofinanciadorLoaded)
      : super(perfilCofinanciador: perfilCofinanciadorLoaded);
}

class PerfilCofinanciadorChanged extends PerfilCofinanciadorState {
  final PerfilCofinanciadorEntity perfilCofinanciadorChanged;

  const PerfilCofinanciadorChanged(this.perfilCofinanciadorChanged)
      : super(perfilCofinanciador: perfilCofinanciadorChanged);
}

class PerfilCofinanciadorSaved extends PerfilCofinanciadorState {
  final PerfilCofinanciadorEntity perfilCofinanciadorSaved;

  const PerfilCofinanciadorSaved(this.perfilCofinanciadorSaved)
      : super(perfilCofinanciador: perfilCofinanciadorSaved);
}

class PerfilCofinanciadorError extends PerfilCofinanciadorState {
  final String message;

  PerfilCofinanciadorError(this.message)
      : super(perfilCofinanciador: PerfilCofinanciadorEntity());

  @override
  List<Object?> get props => [message];
}
