part of 'perfil_preinversion_aliados_bloc.dart';

abstract class PerfilPreInversionAliadosState extends Equatable {
  const PerfilPreInversionAliadosState();

  @override
  List<Object> get props => [];
}

class PerfilPreInversionAliadosInitial extends PerfilPreInversionAliadosState {}

class PerfilPreInversionAliadosLoading extends PerfilPreInversionAliadosState {}

class PerfilPreInversionAliadosLoaded extends PerfilPreInversionAliadosState {
  final List<PerfilPreInversionAliadoEntity>? perfilPreInversionAliadosLoaded;

  const PerfilPreInversionAliadosLoaded({this.perfilPreInversionAliadosLoaded});
}

class PerfilPreInversionAliadosError extends PerfilPreInversionAliadosState {
  final String message;

  const PerfilPreInversionAliadosError(this.message);
}
