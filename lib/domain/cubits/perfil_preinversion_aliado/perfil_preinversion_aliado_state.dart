part of 'perfil_preinversion_aliado_cubit.dart';

abstract class PerfilPreInversionAliadoState extends Equatable {
  final PerfilPreInversionAliadoEntity? perfilPreInversionAliado;
  const PerfilPreInversionAliadoState({this.perfilPreInversionAliado});

  @override
  List<Object?> get props => [perfilPreInversionAliado];
}

class PerfilPreInversionAliadoInitial extends PerfilPreInversionAliadoState {}

class PerfilPreInversionAliadoLoading extends PerfilPreInversionAliadoState {}

class PerfilPreInversionAliadoLoaded extends PerfilPreInversionAliadoState {
  final PerfilPreInversionAliadoEntity? perfilPreInversionAliadoLoaded;

  const PerfilPreInversionAliadoLoaded(this.perfilPreInversionAliadoLoaded)
      : super(perfilPreInversionAliado: perfilPreInversionAliadoLoaded);
}

class PerfilPreInversionAliadoError extends PerfilPreInversionAliadoState {
  final String message;

  const PerfilPreInversionAliadoError(this.message);

  @override
  List<Object?> get props => [message];
}
