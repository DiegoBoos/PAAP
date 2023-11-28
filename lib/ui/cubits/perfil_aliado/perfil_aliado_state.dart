part of 'perfil_aliado_cubit.dart';

abstract class PerfilAliadoState extends Equatable {
  final PerfilAliadoEntity perfilAliado;
  const PerfilAliadoState({required this.perfilAliado});

  @override
  List<Object?> get props => [perfilAliado];
}

class PerfilAliadoInitial extends PerfilAliadoState {
  PerfilAliadoInitial() : super(perfilAliado: PerfilAliadoEntity());
}

class PerfilAliadoLoading extends PerfilAliadoState {
  const PerfilAliadoLoading({required super.perfilAliado});
}

class PerfilAliadoLoaded extends PerfilAliadoState {
  final PerfilAliadoEntity perfilAliadoLoaded;

  const PerfilAliadoLoaded(this.perfilAliadoLoaded)
      : super(perfilAliado: perfilAliadoLoaded);
}

class PerfilAliadoChanged extends PerfilAliadoState {
  final PerfilAliadoEntity perfilAliadoChanged;

  const PerfilAliadoChanged(this.perfilAliadoChanged)
      : super(perfilAliado: perfilAliadoChanged);
}

class PerfilAliadoSaved extends PerfilAliadoState {
  const PerfilAliadoSaved({required super.perfilAliado});
}

class PerfilAliadoError extends PerfilAliadoState {
  final String message;

  PerfilAliadoError(this.message) : super(perfilAliado: PerfilAliadoEntity());

  @override
  List<Object?> get props => [message];
}
