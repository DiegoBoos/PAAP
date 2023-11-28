part of 'perfil_preinversion_aliado_cubit.dart';

abstract class PerfilPreInversionAliadoState extends Equatable {
  final PerfilPreInversionAliadoEntity perfilPreInversionAliado;
  const PerfilPreInversionAliadoState({required this.perfilPreInversionAliado});

  @override
  List<Object?> get props => [perfilPreInversionAliado];
}

class PerfilPreInversionAliadoInitial extends PerfilPreInversionAliadoState {
  PerfilPreInversionAliadoInitial()
      : super(perfilPreInversionAliado: PerfilPreInversionAliadoEntity());
}

class PerfilPreInversionAliadoLoaded extends PerfilPreInversionAliadoState {
  final PerfilPreInversionAliadoEntity perfilPreInversionAliadoLoaded;

  const PerfilPreInversionAliadoLoaded(this.perfilPreInversionAliadoLoaded)
      : super(perfilPreInversionAliado: perfilPreInversionAliadoLoaded);
}

class PerfilPreInversionAliadoChanged extends PerfilPreInversionAliadoState {
  final PerfilPreInversionAliadoEntity perfilPreInversionAliadoChanged;

  const PerfilPreInversionAliadoChanged(this.perfilPreInversionAliadoChanged)
      : super(perfilPreInversionAliado: perfilPreInversionAliadoChanged);
}

class PerfilPreInversionAliadoSaved extends PerfilPreInversionAliadoState {
  const PerfilPreInversionAliadoSaved(
      {required super.perfilPreInversionAliado});
}

class PerfilPreInversionAliadoError extends PerfilPreInversionAliadoState {
  final String message;

  PerfilPreInversionAliadoError(this.message)
      : super(perfilPreInversionAliado: PerfilPreInversionAliadoEntity());

  @override
  List<Object?> get props => [message];
}
