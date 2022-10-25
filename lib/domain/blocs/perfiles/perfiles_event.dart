part of 'perfiles_bloc.dart';

abstract class PerfilesEvent extends Equatable {
  const PerfilesEvent();

  @override
  List<Object> get props => [];
}

class GetPerfiles extends PerfilesEvent {
  final UsuarioEntity usuario;
  final bool isOffline;

  const GetPerfiles({required this.usuario, this.isOffline = false});
}

class GetPerfilesFiltros extends PerfilesEvent {
  final UsuarioEntity usuario;
  final String? id;
  final String? nombre;
  final bool isOffline;

  const GetPerfilesFiltros(
      {required this.usuario, this.id, this.nombre, this.isOffline = false});
}

class GetPerfil extends PerfilesEvent {
  final UsuarioEntity usuario;
  final String perfilId;
  final bool isOffline;

  const GetPerfil(
      {required this.usuario, required this.perfilId, this.isOffline = false});
}
