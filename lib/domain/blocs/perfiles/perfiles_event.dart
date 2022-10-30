part of 'perfiles_bloc.dart';

abstract class PerfilesEvent extends Equatable {
  const PerfilesEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilesFiltros extends PerfilesEvent {
  final UsuarioEntity usuario;
  final String? id;
  final String? nombre;

  const GetPerfilesFiltros({required this.usuario, this.id, this.nombre});
}

class GetPerfil extends PerfilesEvent {
  final UsuarioEntity usuario;
  final String perfilId;

  const GetPerfil({required this.usuario, required this.perfilId});
}
