part of 'v_perfil_cubit.dart';

abstract class VPerfilState extends Equatable {
  final VPerfilEntity? vPerfil;

  const VPerfilState({this.vPerfil});

  @override
  List<Object?> get props => [vPerfil];
}

class VPerfilInitial extends VPerfilState {}

class VPerfilSelected extends VPerfilState {
  final VPerfilEntity? vPerfilSelected;

  const VPerfilSelected(this.vPerfilSelected) : super(vPerfil: vPerfilSelected);
}

class VPerfilError extends VPerfilState {
  final String message;

  const VPerfilError(this.message);
  @override
  List<Object?> get props => [message];
}
