part of 'perfil_preinversion_aliados_bloc.dart';

abstract class PerfilPreInversionAliadosState extends Equatable {
  final List<PerfilPreInversionAliadoEntity>? perfilPreInversionAliados;

  const PerfilPreInversionAliadosState({this.perfilPreInversionAliados});

  @override
  List<Object> get props => [];
}

class PerfilPreInversionAliadosInitial extends PerfilPreInversionAliadosState {
  PerfilPreInversionAliadosInitial() : super(perfilPreInversionAliados: []);
}

class PerfilPreInversionAliadosLoading extends PerfilPreInversionAliadosState {}

class PerfilPreInversionAliadosLoaded extends PerfilPreInversionAliadosState {
  final List<PerfilPreInversionAliadoEntity>? perfilPreInversionAliadosLoaded;

  const PerfilPreInversionAliadosLoaded({this.perfilPreInversionAliadosLoaded})
      : super(perfilPreInversionAliados: perfilPreInversionAliadosLoaded);
}

class PerfilPreInversionAliadosError extends PerfilPreInversionAliadosState {
  final String message;

  PerfilPreInversionAliadosError(this.message)
      : super(perfilPreInversionAliados: []);
}
