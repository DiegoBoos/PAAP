part of 'perfil_cubit.dart';

abstract class PerfilState extends Equatable {
  final VPerfilEntity? perfil;
  const PerfilState({this.perfil});

  @override
  List<Object?> get props => [perfil];
}

class PerfilInitial extends PerfilState {}

class PerfilLoading extends PerfilState {}

class PerfilLoaded extends PerfilState {
  final VPerfilEntity? perfilLoaded;

  const PerfilLoaded(this.perfilLoaded) : super(perfil: perfilLoaded);
}

class PerfilError extends PerfilState {
  final String message;

  const PerfilError(this.message);

  @override
  List<Object?> get props => [message];
}
