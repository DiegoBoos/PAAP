part of 'perfiles_bloc.dart';

abstract class PerfilesState extends Equatable {
  final List<PerfilEntity>? perfiles;
  final PerfilEntity? perfil;

  const PerfilesState({this.perfiles, this.perfil});

  @override
  List<Object?> get props => [perfiles, perfil];
}

class PerfilesInitial extends PerfilesState {}

class PerfilInitial extends PerfilesState {}

class PerfilesLoading extends PerfilesState {}

class PerfilLoading extends PerfilesState {}

class PerfilesLoaded extends PerfilesState {
  final List<PerfilEntity>? perfilesLoaded;

  const PerfilesLoaded({this.perfilesLoaded}) : super(perfiles: perfilesLoaded);

  @override
  List<Object?> get props => [perfiles];
}

class PerfilLoaded extends PerfilesState {
  final PerfilEntity? perfilLoaded;

  const PerfilLoaded({this.perfilLoaded}) : super(perfil: perfilLoaded);

  @override
  List<Object?> get props => [perfil];
}

class PerfilesError extends PerfilesState {
  final String message;

  const PerfilesError(this.message);

  @override
  List<Object?> get props => [message];
}

class PerfilError extends PerfilesState {
  final String message;

  const PerfilError(this.message);

  @override
  List<Object?> get props => [message];
}
